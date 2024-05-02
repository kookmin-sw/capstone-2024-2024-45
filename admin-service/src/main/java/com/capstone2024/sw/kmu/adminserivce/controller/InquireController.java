package com.capstone2024.sw.kmu.adminserivce.controller;

import com.capstone2024.sw.kmu.adminserivce.base.dto.APIResponse;
import com.capstone2024.sw.kmu.adminserivce.base.dto.ErrorCode;
import com.capstone2024.sw.kmu.adminserivce.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.adminserivce.controller.dto.request.InquireRequestDto;
import com.capstone2024.sw.kmu.adminserivce.service.InquireService;
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
@RequestMapping("/api/admin/inquiries")
public class InquireController {

    private final InquireService inquireService;

    @Operation(summary = "일반 문의", description = "사용자가 문의하기 기능을 사용합니다.")
    @PostMapping("")
    public ResponseEntity<APIResponse> createInquire(
            @RequestHeader Long userId,
            @RequestBody InquireRequestDto.Inquire dto
    ) {
        try {
            inquireService.createInquire(userId, dto.getInquire());
            return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS));
        } catch (Exception e) {
            return ResponseEntity.ok(APIResponse.of(ErrorCode.INSERT_ERROR));
        }
    }

    @Operation(summary = "거래 취소 문의", description = "사용자가 거래 취소 문의하기 기능을 사용합니다.")
    @PostMapping("/remittance")
    public ResponseEntity<APIResponse> createRemittanceInquire(
            @RequestHeader Long userId,
            @RequestBody InquireRequestDto.RemittanceInquire dto
    ) {
        try {
            inquireService.createRemittanceInquire(userId, dto);
            return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS));
        } catch (Exception e) {
            return ResponseEntity.ok(APIResponse.of(ErrorCode.INSERT_ERROR));
        }
    }
}
