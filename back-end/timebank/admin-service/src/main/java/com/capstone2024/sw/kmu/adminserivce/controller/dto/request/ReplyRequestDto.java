package com.capstone2024.sw.kmu.adminserivce.controller.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;

public class ReplyRequestDto {

    @Schema(description = "답변 폼")
    @Getter
    public static class Reply {

        @Schema(description = "답변 내용", example = "이렇게 저렇게 해결했습니다~")
        @NotEmpty
        private String reply;
    }
}
