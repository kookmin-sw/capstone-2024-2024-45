package com.capstone2024.sw.kmu.exchangeservice.controller;

import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.request.QRRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.QRResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.service.QRService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/exchange/qr")
public class QRController {

    private final QRService qrService;

    @Operation(summary = "QR 생성", description = "QR 코드를 생성합니다.")
    @PostMapping("/create")
    public ResponseEntity<APIResponse<QRResponseDto.QRCode>> createQRCode(
            @RequestHeader String userId,
            @RequestBody String accountId
    ) throws NoSuchAlgorithmException, InvalidKeyException {

        // TODO: 인증 시간

        QRResponseDto.QRCode response = qrService.createQRCode(userId, accountId);
        return ResponseEntity.ok(APIResponse.of(SuccessCode.SELECT_SUCCESS, response));
    }


    @Operation(summary = "QR 스캔", description = "QR 코드에서 정보를 추출합니다.")
    @PostMapping("/scan")
    public ResponseEntity<APIResponse> scanQRCode(
            @RequestBody QRRequestDto.QRCodeWithSenderInfo dto
    ) throws Exception {

        APIResponse response = qrService.scanQRCode(dto);

        return ResponseEntity.ok(response);
    }

}
