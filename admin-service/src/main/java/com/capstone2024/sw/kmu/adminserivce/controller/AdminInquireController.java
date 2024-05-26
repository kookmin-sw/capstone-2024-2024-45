package com.capstone2024.sw.kmu.adminserivce.controller;

import com.capstone2024.sw.kmu.adminserivce.base.dto.APIResponse;
import com.capstone2024.sw.kmu.adminserivce.base.dto.ErrorCode;
import com.capstone2024.sw.kmu.adminserivce.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.adminserivce.controller.dto.response.InquireReplyResponseDto;
import com.capstone2024.sw.kmu.adminserivce.domain.Inquire;
import com.capstone2024.sw.kmu.adminserivce.service.InquireService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/timebank-admin-service/api/admin/inquiries")
public class AdminInquireController {

    private final InquireService inquireService;

    @Operation(summary = "(관리자) 문의 리스트로 보기", description = "관리자가 문의 유형에 따라 문의 리스트를 봅니다.")
    @GetMapping("/all")
    public ResponseEntity<APIResponse> getInquires(
            @Schema(description = "문의 타입", example = "all / general / refund 중 하나 입력")
            @RequestParam(value = "type", defaultValue="all") String type,
            @RequestParam(value = "completion", required = false) Boolean completion

    ) {
        try {
            List<Inquire> inquires = inquireService.getInquires(type, completion);
            return ResponseEntity.ok(APIResponse.of(SuccessCode.SELECT_SUCCESS, inquires));
        }catch (Exception e){
            return ResponseEntity.ok(APIResponse.of(ErrorCode.INVALID_PARAMETER, e + "잘못된 타입을 입력했습니다."));
        }
    }

    @Operation(summary = "(관리자) 특정 문의 보기", description = "관리자가 특정 문의를 봅니다.")
    @GetMapping("/id/{inquireId}")
    public ResponseEntity<APIResponse<InquireReplyResponseDto.InquireReply>> getInquire(
            @Schema(description = "문의 id", example = "1")
            @PathVariable Long inquireId
    ) {
        InquireReplyResponseDto.InquireReply response = inquireService.getInquire(inquireId);
        return ResponseEntity.ok(APIResponse.of(SuccessCode.SELECT_SUCCESS, response));
    }

}
