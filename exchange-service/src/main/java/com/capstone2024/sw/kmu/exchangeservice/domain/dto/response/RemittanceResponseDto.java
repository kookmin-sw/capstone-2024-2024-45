package com.capstone2024.sw.kmu.exchangeservice.domain.dto.response;

import com.capstone2024.sw.kmu.exchangeservice.domain.dto.request.RemittanceRequestDto;
import lombok.Builder;
import lombok.Getter;

public class RemittanceResponseDto {

    @Builder
    @Getter
    public static class Remittance {
        private String senderAccountId;
        private String receiverAccountId;
        private int amount;
//        private String password;

        public static Remittance from(RemittanceRequestDto.QRRemittance dto) {
            return Remittance.builder()
                    .senderAccountId(dto.getSenderAccountId())
                    .receiverAccountId(dto.getReceiverAccountId())
                    .amount(dto.getAmount())
                    .build();
        }
    }

}
