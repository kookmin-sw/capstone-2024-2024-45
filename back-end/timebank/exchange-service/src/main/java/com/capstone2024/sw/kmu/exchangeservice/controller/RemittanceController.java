package com.capstone2024.sw.kmu.exchangeservice.controller;

import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.request.RemittanceRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.RemittanceResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.TransactionHistoryResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.service.BankCoreService;
import com.capstone2024.sw.kmu.exchangeservice.service.RemittanceService;
import com.capstone2024.sw.kmu.exchangeservice.service.TransactionHistoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/api/exchange/remittance")
public class RemittanceController {

    private final RemittanceService remittanceService;
    private final TransactionHistoryService transactionHistoryService;
    private final BankCoreService bankCoreService;

    // 송금
    @Operation(summary = "자유 송금", description = "자유 송금을 합니다.")
    @PostMapping("/qr")
    public ResponseEntity<APIResponse<TransactionHistoryResponseDto.RemittanceResult>> QRRemittance(
            @Schema(description = "송금 요청", required = true)
            @RequestHeader String userId,
            @RequestBody RemittanceRequestDto.QRRemittance remit
    ) {
        RemittanceResponseDto.Remittance dto = RemittanceResponseDto.Remittance.from(remit);

        APIResponse check = bankCoreService.validateUser(dto.getSenderAccountId(), dto.getReceiverAccountId(), dto.getAmount());
        if(check != null){
            return ResponseEntity.ok(check);
        }

        TransactionHistoryResponseDto.RemittanceResult response = remittanceService.remit(dto, userId);

        return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS, response));
    }

    // 특정 계좌의 거래 내역 확인
    @Operation(summary = "특정 계좌의 거래 내역 확인", description = "거래 내역을 확인합니다.")
    @PostMapping("/history")
    public ResponseEntity<APIResponse<List<TransactionHistoryResponseDto.RemittanceList>>> getHistory(
            @RequestBody RemittanceRequestDto.History dto
    ) {
        return ResponseEntity.ok(transactionHistoryService.getUserHistory(dto));
    }

    @Operation(summary = "특정 거래 내역 확인", description = "특정 거래 내역을 확인합니다.")
    @PostMapping("/history/{transId}")
    public ResponseEntity<APIResponse<TransactionHistoryResponseDto.RemittanceResult>> getDetailHistory(
            @PathVariable Long transId,
            @RequestBody RemittanceRequestDto.isSender dto
            ) {
        return ResponseEntity.ok(APIResponse.of(SuccessCode.SELECT_SUCCESS,transactionHistoryService.findSpecificTransHistory(transId, dto.isSender())));
    }
}
