package com.capstone2024.sw.kmu.exchangeservice.service;


import com.capstone2024.sw.kmu.exchangeservice.domain.bankcore.AccountInfo;
import com.capstone2024.sw.kmu.exchangeservice.domain.dto.response.TransactionHistoryResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.TransactionHistory;
import com.capstone2024.sw.kmu.exchangeservice.repository.remittance.TransactionHistoryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

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
}
