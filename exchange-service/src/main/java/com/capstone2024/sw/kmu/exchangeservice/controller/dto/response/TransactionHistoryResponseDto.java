package com.capstone2024.sw.kmu.exchangeservice.controller.dto.response;

import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.TransactionHistory;
import com.capstone2024.sw.kmu.exchangeservice.domain.User;
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
    public static class RemittanceResultWithUserInfo{

        private int amount;
        private boolean isSender;

        private String senderNickname;
        private String senderProfileImg;
        private int senderBalanceAfter;

        private String receiverNickname;
        private String receiverProfileImg;
        private int receiverBalanceAfter;

        private LocalDateTime createdAt;


        public static RemittanceResultWithUserInfo senderInfoFrom(TransactionHistory response, User user) {
            return RemittanceResultWithUserInfo.builder()
                    .amount(response.getAmount())
                    .isSender(false)
                    .senderNickname(user.getUserNickname())
                    .senderProfileImg(user.getUserProfileImg())
                    .receiverBalanceAfter(response.getReceiverBalanceAfter())
                    .createdAt(response.getCreatedAt())
                    .build();
        }

        public static RemittanceResultWithUserInfo receiverInfoFrom(TransactionHistory response, User user) {
            return RemittanceResultWithUserInfo.builder()
                    .amount(response.getAmount())
                    .isSender(true)
                    .receiverNickname(user.getUserNickname())
                    .receiverProfileImg(user.getUserProfileImg())
                    .senderBalanceAfter(response.getSenderBalanceAfter())
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
        private boolean send;
        private String senderNickname;
        private String senderProfileImg;
        private String receiverNickname;
        private String receiverProfileImg;
        private int amount;

        public static RemittanceList senderInfoFrom(TransactionHistory response, User user) {
            return RemittanceList.builder()
                    .transId(response.getTransId())
                    .send(false)
                    .senderNickname(user.getUserNickname())
                    .senderProfileImg(user.getUserProfileImg())
                    .amount(response.getAmount())
                    .build();
        }

        public static RemittanceList receiverInfoFrom(TransactionHistory response, User user) {
            return RemittanceList.builder()
                    .transId(response.getTransId())
                    .send(true)
                    .receiverNickname(user.getUserNickname())
                    .receiverProfileImg(user.getUserProfileImg())
                    .amount(response.getAmount())
                    .build();
        }
    }
}
