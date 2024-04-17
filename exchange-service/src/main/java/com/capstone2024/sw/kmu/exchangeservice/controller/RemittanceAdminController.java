package com.capstone2024.sw.kmu.exchangeservice.controller;

import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.request.RemittanceManageRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.service.RemittanceAdminService;
import com.capstone2024.sw.kmu.exchangeservice.service.RemittanceService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/admin/exchange/")
public class RemittanceAdminController {

    private final RemittanceAdminService remittanceAdminService;

    // 관리자의 송금 취소
    @Operation(summary = "송금 취소 (관리자용)", description = "자유 송금을 합니다.")
    @PostMapping("/{transId}/cancel")
    public ResponseEntity<APIResponse> CancelRemittance(
            @Schema(description = "송금 취소", required = true)
            @RequestHeader String adminId,
            @PathVariable Long transId,
            @RequestBody RemittanceManageRequestDto.RemittanceCancellation dto
    ) throws IllegalAccessException {

        remittanceAdminService.cancel(dto , adminId, transId);

        return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS));
    }
}
