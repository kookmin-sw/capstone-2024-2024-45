package com.capstone2024.sw.kmu.adminserivce.controller;

import com.capstone2024.sw.kmu.adminserivce.base.dto.APIResponse;
import com.capstone2024.sw.kmu.adminserivce.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.adminserivce.controller.dto.request.ReplyRequestDto;
import com.capstone2024.sw.kmu.adminserivce.domain.Inquire;
import com.capstone2024.sw.kmu.adminserivce.domain.Reply;
import com.capstone2024.sw.kmu.adminserivce.service.ReplyService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@RequiredArgsConstructor
@RequestMapping("/api/admin/inquiries")
public class ReplyController {

    private final ReplyService replyService;

    @Operation(summary = "특정 문의에 답변하기", description = "관리자가 특정 문의에 답변합니다.")
    @GetMapping("/{inquireId}/reply")
    public ResponseEntity<APIResponse> reply(
            @Schema(description = "문의 id", example = "1")
            @PathVariable Long inquireId,
            @RequestHeader Long adminId,
            @RequestBody ReplyRequestDto.Reply dto
    ) {

        replyService.reply(inquireId, adminId, dto);
        return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS));
    }
}
