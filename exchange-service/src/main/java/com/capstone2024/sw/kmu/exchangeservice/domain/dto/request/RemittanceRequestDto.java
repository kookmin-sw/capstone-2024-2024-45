package com.capstone2024.sw.kmu.exchangeservice.domain.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Builder;
import lombok.Getter;

public class RemittanceRequestDto {

    @Schema(description = "qr 송금 요청")
    @Builder
    @Getter
    public static class QRRemittance {
        @Schema(description = "보내는 사람 account Id", example = "00000000-0000-0000-000000000000")
        @NotEmpty
        private String senderAccountId;

        @Schema(description = "보내는 금액", example = "50")
        @NotEmpty
        private int amount;

        @Schema(description = "받는 사람 account Id", example = "11111111-1111-1111-111111111111")
        @NotEmpty
        private String receiverAccountId;
    }
}
