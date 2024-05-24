package com.capstone2024.sw.kmu.adminserivce.controller.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;

public class InquireRequestDto {

    @Schema(description = "일반 문의 폼")
    @Getter
    public static class Inquire {

        @Schema(description = "문의 내용", example = "문의문의")
        @NotEmpty
        private String inquire;
    }

    @Schema(description = "거래 취소 문의 폼")
    @Getter
    public static class RemittanceInquire {

        @Schema(description = "거래 id", example = "1")
        @NotEmpty
        private Long transId;

        @Schema(description = "원래 보내려고 했던 매듭", example = "500")
        private String expectedAmount;

        @Schema(description = "추가 문의 내용", example = "문의문의")
        private String inquire;

    }
}
