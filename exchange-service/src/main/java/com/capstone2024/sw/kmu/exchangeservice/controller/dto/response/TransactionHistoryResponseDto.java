package com.capstone2024.sw.kmu.exchangeservice.controller.dto.response;

import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.TransactionHistory;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

public class TransactionHistoryResponseDto {


    @Builder
    @Getter
    @Setter
    @AllArgsConstructor
    public static class RemittanceResult{

        private String senderAccountId;
        private String receiverAccountId;
        private int amount;
        private int senderBalanceAfter;
        private int receiverBalanceAfter;
        private LocalDateTime createdAt;


        public static RemittanceResult from(TransactionHistory response) {
            return RemittanceResult.builder()
                    .senderAccountId(response.getSenderAccountId())
                    .receiverAccountId(response.getReceiverAccountId())
                    .amount(response.getAmount())
                    .senderBalanceAfter(response.getSenderBalanceAfter())
                    .receiverBalanceAfter(response.getReceiverBalanceAfter())
                    .createdAt(response.getCreatedAt())
                    .build();
        }
    }

    @Builder
    @Getter
    @Setter
    @AllArgsConstructor
    public static class RemittanceList{

        private Long transId;
        private String senderAccountId;
        private String receiverAccountId;
        private int amount;

        public static RemittanceList from(TransactionHistory response) {
            return RemittanceList.builder()
                    .transId(response.getTransId())
                    .senderAccountId(response.getSenderAccountId())
                    .receiverAccountId(response.getReceiverAccountId())
                    .amount(response.getAmount())
                    .build();
        }
    }
}
