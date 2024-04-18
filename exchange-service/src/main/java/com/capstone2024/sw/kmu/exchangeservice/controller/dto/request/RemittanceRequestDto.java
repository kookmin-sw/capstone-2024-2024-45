package com.capstone2024.sw.kmu.exchangeservice.controller.dto.request;

import com.capstone2024.sw.kmu.exchangeservice.domain.TransactionType;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

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

    @Schema(description = "특정 계좌의 거래 내역 보기")
    @NoArgsConstructor
    @Getter
    public static class History {

        @Schema(description = "보기 옵션", example = "ALL :전체 내역보기, SEND :보낸 내역만 보기, RECEIVE :받은 내역만 보기")
        @NotEmpty
        private TransactionType type;

        @Schema(description = "계좌 id", example = "550e8400-e294-1d4a-716446655440000")
        @NotEmpty
        private String accountId;

    }
}
