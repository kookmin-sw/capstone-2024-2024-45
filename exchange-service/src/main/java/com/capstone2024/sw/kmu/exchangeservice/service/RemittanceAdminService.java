package com.capstone2024.sw.kmu.exchangeservice.service;

import com.capstone2024.sw.kmu.exchangeservice.domain.dto.request.RemittanceManageRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.response.RemittanceResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.response.TransactionHistoryResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.RemittanceManage;
import com.capstone2024.sw.kmu.exchangeservice.repository.remittance.RemittanceAdminRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional("transactionHistoryTransactionManager")
public class RemittanceAdminService {

    private final TransactionHistoryService transactionHistoryService;
    private final RemittanceService remittanceService;
    private final RemittanceAdminRepository remittanceAdminRepository;

    public void cancel(RemittanceManageRequestDto.RemittanceCancellation dto, String adminId, Long transId) {

        // 반대 거래 발생
        TransactionHistoryResponseDto.RemittanceResult remittanceResult = transactionHistoryService.findTransHistory(transId);
        remittanceService.remit(RemittanceResponseDto.Remittance.converseFrom(remittanceResult), null);

        // Audit 저장
        remittanceAdminRepository.save(RemittanceManage.build(dto,adminId,transId));

    }
}
