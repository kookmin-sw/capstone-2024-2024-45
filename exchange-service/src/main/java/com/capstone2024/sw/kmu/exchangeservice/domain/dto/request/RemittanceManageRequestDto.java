package com.capstone2024.sw.kmu.exchangeservice.domain.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class RemittanceManageRequestDto {

    @Schema(description = "송금 취소")
    @Getter
    @NoArgsConstructor
    public static class RemittanceCancellation {

//        @Schema(description = "취소하려는 거래의 id", example = "1,2,3,4 ...")
//        @NotEmpty
//        private Long transId;

//        @Schema(description = "admin의 실명", example = "")
//        @NotEmpty
//        private int adminName;

        @Schema(description = "취소 사유", example = "")
        @NotEmpty
        private String comment;
    }
}
