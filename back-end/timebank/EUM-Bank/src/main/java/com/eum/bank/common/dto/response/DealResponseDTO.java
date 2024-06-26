package com.eum.bank.common.dto.response;

import jakarta.validation.GroupSequence;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

public class DealResponseDTO {

    @Getter
    @Builder
    @AllArgsConstructor
    public static class createDeal {
        // 거래 id
        private Long dealId;
        // 송신자 계좌 번호
        private String senderAccountNumber;
        // 상태
        private String status;
        // 예치금
        private Long deposit;
        // 최대 인원수
        private Long maxPeopleNum;
        // 실제 모집인원수
        private Long realPeopleNum;
        // 게시글 ID
        private Long postId;
    }
}
