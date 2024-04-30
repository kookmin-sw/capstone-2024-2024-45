package com.capstone2024.sw.kmu.exchangeservice.service;

import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.ErrorCode;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
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
import java.util.Objects;

@Slf4j
@Service
@Transactional("transactionHistoryTransactionManager")
@RequiredArgsConstructor
public class QRService {

    private final BankCoreRepository bankCoreRepository;

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

        String data = userId + ":" + accountId;

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

            String[] parts = dto.getUserInfo().split(":");
            String ReceiverUserId = parts[0];
            String ReceiverAccountId = parts[1];

            // TODO: user service 호출, ReceiverUserId 로 닉네임, 프로필 이미지 받아오기 연결

            int senderBalance = bankCoreRepository.findBalanceByAccountId(dto.getSenderAccountId());

            QRResponseDto.ScannedData response = QRResponseDto.ScannedData.from(ReceiverAccountId, "김국민(예시)", senderBalance);

            return APIResponse.of(SuccessCode.SELECT_SUCCESS, response);

        } else {
            return APIResponse.of(ErrorCode.INVALID_DEAL_STATUS, "QR 코드 인증에 실패했습니다.");
        }
    }
}
