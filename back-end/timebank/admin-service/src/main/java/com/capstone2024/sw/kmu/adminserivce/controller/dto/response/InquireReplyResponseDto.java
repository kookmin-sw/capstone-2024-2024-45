package com.capstone2024.sw.kmu.adminserivce.controller.dto.response;

import com.capstone2024.sw.kmu.adminserivce.domain.Administrator;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;


public class InquireReplyResponseDto {

    @Schema(description = "답변 미완료인 문의")
    @Getter
    @Builder
    public static class InquireReply {
        Inquire inquire;
        Reply reply;

        public static InquireReply IncompletedFrom(com.capstone2024.sw.kmu.adminserivce.domain.Inquire entityInquire) {
            Inquire dtoInquire = Inquire.from(entityInquire);

            return InquireReply.builder()
                    .inquire(dtoInquire)
                    .build();
        }

        public static InquireReply CompletedFrom(com.capstone2024.sw.kmu.adminserivce.domain.Reply entityReply) {
            Inquire dtoInquire = Inquire.from(entityReply.getInquire());
            Reply dtoReply = Reply.from(entityReply);

            return InquireReply.builder()
                    .inquire(dtoInquire)
                    .reply(dtoReply)
                    .build();
        }
    }

    @Schema(description = "문의")
    @Getter
    @Builder
    public static class Inquire {

        // 1: 일반 문의, 2: 거래 취소 문의
        private int inquireType;

        private String inquireText;
        private boolean isCompleted;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;

        public static Inquire from(com.capstone2024.sw.kmu.adminserivce.domain.Inquire inquire) {
            return Inquire.builder()
                    .inquireType(inquire.getInquireType())
                    .inquireText(inquire.getInquireText())
                    .isCompleted(inquire.isCompleted())
                    .createdAt(inquire.getCreatedAt())
                    .updatedAt(inquire.getUpdatedAt())
                    .build();
        }

    }

    @Schema(description = "답변")
    @Getter
    @Builder
    public static class Reply {
        private Replier admin;
        private String reply;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;

        public static Reply from(com.capstone2024.sw.kmu.adminserivce.domain.Reply reply) {
            return Reply.builder()
                    .admin(Replier.from(reply.getAdmin()))
                    .reply(reply.getReply())
                    .createdAt(reply.getCreatedAt())
                    .updatedAt(reply.getUpdatedAt())
                    .build();
        }
    }

    @Schema(description = "답변자")
    @Getter
    @Builder
    public static class Replier {
        private Long adminId;
        private String name;

        public static Replier from(Administrator admin) {
            return Replier.builder()
                    .adminId(admin.getAdminId())
                    .name(admin.getName())
                    .build();
        }
    }
}
