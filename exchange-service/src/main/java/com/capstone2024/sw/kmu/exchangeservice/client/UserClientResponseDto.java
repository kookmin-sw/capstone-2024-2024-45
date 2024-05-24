package com.capstone2024.sw.kmu.exchangeservice.client;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;

public class UserClientResponseDto {

    @Schema(description = "유저 닉네임과 프로필 이미지 url")
    @Getter
    public static class UserInfo {

        @Schema(description = "닉네임", example = "김국민")
        @NotEmpty
        private String nickname;

        @Schema(description = "프로필 사진 링크", example = "")
        @NotEmpty
        private String profile_img;
    }
}
