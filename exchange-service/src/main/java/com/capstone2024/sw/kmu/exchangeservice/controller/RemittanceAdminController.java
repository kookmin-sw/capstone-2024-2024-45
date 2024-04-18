package com.capstone2024.sw.kmu.exchangeservice.controller;

import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.request.RemittanceManageRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.TransactionHistoryResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.service.RemittanceAdminService;
import com.capstone2024.sw.kmu.exchangeservice.service.TransactionHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/admin/exchange/")
public class RemittanceAdminController {

    private final RemittanceAdminService remittanceAdminService;
    private final TransactionHistoryService transactionHistoryService;

    // 관리자의 송금 취소
    @Operation(summary = "송금 취소 (관리자용)", description = "자유 송금을 합니다.")
    @PostMapping("/{transId}/cancel")
    public ResponseEntity<APIResponse> CancelRemittance(
            @Schema(description = "송금 취소", required = true)
            @RequestHeader String adminId,
            @PathVariable Long transId,
            @RequestBody RemittanceManageRequestDto.RemittanceCancellation dto
    ) {

        remittanceAdminService.cancel(dto , adminId, transId);

        return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS));
    }

    // 모든 거래 내역 확인
    @Operation(summary = "모든 계좌의 거래 내역 확인", description = "거래 내역을 확인합니다.")
    @GetMapping("/remittance/history")
    public ResponseEntity<APIResponse<List<TransactionHistoryResponseDto.RemittanceResult>>> getAllHistory(
    ) {

        return ResponseEntity.ok(transactionHistoryService.getAllHistory()); // TODO: 다른 endpoint 도 이렇게 refactoring
    }
}
