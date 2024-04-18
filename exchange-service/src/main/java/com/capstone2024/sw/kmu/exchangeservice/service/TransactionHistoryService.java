package com.capstone2024.sw.kmu.exchangeservice.service;


import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.domain.bankcore.AccountInfo;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.request.RemittanceRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.response.TransactionHistoryResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.TransactionHistory;
import com.capstone2024.sw.kmu.exchangeservice.repository.remittance.TransactionHistoryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TransactionHistoryService {

    private final TransactionHistoryRepository transactionHistoryRepository;


    public TransactionHistory create(AccountInfo senderInfo, AccountInfo receiverInfo, int amount, String userId) {

        return transactionHistoryRepository.save(TransactionHistory.build(senderInfo,receiverInfo,amount,userId));
    }

    public TransactionHistoryResponseDto.RemittanceResult findTransHistory(Long transId) {

        TransactionHistory transactionHistory = transactionHistoryRepository.findByTransId(transId);

        return TransactionHistoryResponseDto.RemittanceResult.from(transactionHistory);
    }

    public APIResponse<List<TransactionHistoryResponseDto.RemittanceList>> getUserHistory(RemittanceRequestDto.History dto) {


        List<TransactionHistory> transactionHistories = transactionHistoryRepository.findByAccountId(dto.getAccountId());

        List<TransactionHistoryResponseDto.RemittanceList> list = transactionHistories.stream()
                .map(TransactionHistoryResponseDto.RemittanceList::from)
                .toList();

        return APIResponse.of(SuccessCode.SELECT_SUCCESS, list);
    }

    public APIResponse<List<TransactionHistoryResponseDto.RemittanceResult>> getAllHistory() {

        List<TransactionHistory> transactionHistories = transactionHistoryRepository.findAllByOrderByTransIdDesc();

        return APIResponse.of(SuccessCode.SELECT_SUCCESS, transactionHistories);
    }
}
