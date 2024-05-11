package com.capstone2024.sw.kmu.exchangeservice.service;

import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.ErrorCode;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.client.UserClient;
import com.capstone2024.sw.kmu.exchangeservice.client.UserClientResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.request.QRRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.QRResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.repository.bankcore.BankCoreRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.buf.HexUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.Duration;
import java.util.Objects;

@Slf4j
@Service
@Transactional("transactionHistoryTransactionManager")
@RequiredArgsConstructor
public class QRService {

    private final BankCoreRepository bankCoreRepository;
    private final UserClient userClient;

    // secret key
    @Value("${app.qr.key}")
    private String SECRET_KEY;

    // hash 알고리즘 규격
    @Value("${app.qr.algorithm}")
    private String ALGORITHM;

    public QRResponseDto.QRCode createQRCode(String userId, String accountId) throws NoSuchAlgorithmException, InvalidKeyException {

        SecretKey secretKey = new SecretKeySpec(SECRET_KEY.getBytes(StandardCharsets.UTF_8), ALGORITHM);
        Mac hasher = Mac.getInstance(ALGORITHM);
        hasher.init(secretKey);

        // 한국 시간대 설정
        ZonedDateTime nowInKorea = ZonedDateTime.now(ZoneId.of("Asia/Seoul"));
        // ISO 8601 형식으로 시간 포맷
        String formattedTime = nowInKorea.format(DateTimeFormatter.ISO_OFFSET_DATE_TIME);

        String data = userId + "%" + accountId + "%" + formattedTime;

        byte[] hash = hasher.doFinal(data.getBytes());
        String hashed = HexUtils.toHexString(hash);

        return QRResponseDto.QRCode.from(hashed, data);

    }

    public APIResponse scanQRCode(QRRequestDto.QRCodeWithSenderInfo dto) throws Exception {

        SecretKey secretKey = new SecretKeySpec(SECRET_KEY.getBytes(StandardCharsets.UTF_8), ALGORITHM);
        Mac hasher = Mac.getInstance(ALGORITHM);
        hasher.init(secretKey);

        byte[] hash = hasher.doFinal(dto.getUserInfo().getBytes());
        String hashed = HexUtils.toHexString(hash);

        if (Objects.equals(hashed, dto.getHmac())) {

            String[] parts = dto.getUserInfo().split("%");
            String ReceiverUserId = parts[0];
            String ReceiverAccountId = parts[1];
            String createdAt = parts[2];

            if(!isValid(createdAt)){
                return APIResponse.of(ErrorCode.INVALID_QR_CODE, "유효시간이 지난 QR 코드 입니다.");
            }

            UserClientResponseDto.UserInfo userInfo = userClient.getProfile(ReceiverAccountId);

            int senderBalance = bankCoreRepository.findBalanceByAccountId(dto.getSenderAccountId());

            QRResponseDto.ScannedData response = QRResponseDto.ScannedData.from(ReceiverAccountId, userInfo, senderBalance);

            return APIResponse.of(SuccessCode.SELECT_SUCCESS, response);

        } else {
            return APIResponse.of(ErrorCode.INVALID_QR_CODE, "QR 코드 인증에 실패했습니다.");
        }
    }

    private boolean isValid(String createdAt) {

        // 문자열을 ZonedDateTime 객체로 파싱
        ZonedDateTime parsedTime = ZonedDateTime.parse(createdAt, DateTimeFormatter.ISO_OFFSET_DATE_TIME);
        // 현재 한국 시간대의 시간
        ZonedDateTime now = ZonedDateTime.now(ZoneId.of("Asia/Seoul"));

        // 두 시간 사이의 차이 계산
        Duration duration = Duration.between(parsedTime, now);

        System.out.println(duration);

        // 차이가 2분 이상인지 확인
        return duration.toMinutes() <= 2;
    }
}
