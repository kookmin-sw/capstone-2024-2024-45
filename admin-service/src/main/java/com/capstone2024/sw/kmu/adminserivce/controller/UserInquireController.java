package com.capstone2024.sw.kmu.adminserivce.controller;

import com.capstone2024.sw.kmu.adminserivce.base.dto.APIResponse;
import com.capstone2024.sw.kmu.adminserivce.base.dto.ErrorCode;
import com.capstone2024.sw.kmu.adminserivce.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.adminserivce.controller.dto.request.InquireRequestDto;
import com.capstone2024.sw.kmu.adminserivce.controller.dto.response.InquireReplyResponseDto;
import com.capstone2024.sw.kmu.adminserivce.domain.Inquire;
import com.capstone2024.sw.kmu.adminserivce.service.InquireService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "User Inquires", description = "사용자의 문의 API")
@Controller
@RequiredArgsConstructor
@RequestMapping("/timebank-admin-service/api/user/inquiries")
public class UserInquireController {

    private final InquireService inquireService;

    @Operation(summary = "일반 문의 등록", description = "사용자가 문의하기 기능을 사용합니다.")
    @PostMapping("")
    public ResponseEntity<APIResponse> createInquire(
            @RequestHeader String userId,
            @RequestBody InquireRequestDto.Inquire dto
    ) {
        try {
            inquireService.createInquire(userId, dto.getInquire());
            return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS));
        } catch (Exception e) {
            return ResponseEntity.ok(APIResponse.of(ErrorCode.INSERT_ERROR));
        }
    }

    @Operation(summary = "거래 취소 문의 등록", description = "사용자가 거래 취소 문의하기 기능을 사용합니다.")
    @PostMapping("/remittance")
    public ResponseEntity<APIResponse> createRemittanceInquire(
            @RequestHeader String userId,
            @RequestBody InquireRequestDto.RemittanceInquire dto
    ) {
        try {
            inquireService.createRemittanceInquire(userId, dto);
            return ResponseEntity.ok(APIResponse.of(SuccessCode.INSERT_SUCCESS));
        } catch (Exception e) {
            return ResponseEntity.ok(APIResponse.of(ErrorCode.INSERT_ERROR));
        }
    }

    @Operation(summary = "내 문의 리스트로 보기", description = "사용자가 자신의 문의했던 문의 리스트를 봅니다.")
    @GetMapping("")
    public ResponseEntity<APIResponse> getMyInquires(
            @RequestHeader String userId
    ) {
        List<Inquire> inquires = inquireService.getMyInquires(userId);
        return ResponseEntity.ok(APIResponse.of(SuccessCode.SELECT_SUCCESS, inquires));
    }

    @Operation(summary = "내 특정 문의 보기", description = "사용자가 자신의 문의했던 특정 문의를 봅니다.")
    @GetMapping("{inquireId}")
    public ResponseEntity<APIResponse<InquireReplyResponseDto.InquireReply>> getMyInquire(
            @Schema(description = "문의 id", example = "1")
            @PathVariable Long inquireId
    ) {
        InquireReplyResponseDto.InquireReply response = inquireService.getInquire(inquireId);
        return ResponseEntity.ok(APIResponse.of(SuccessCode.SELECT_SUCCESS, response));
    }

    @Operation(summary = "내 문의 수정하기", description = "사용자가 문의를 수정합니다. * 답변이 달리지 않았을 때만 가능")
    @PatchMapping("/{inquireId}")
    public ResponseEntity<APIResponse> updateInquire(
            @Schema(description = "문의 id", example = "1")
            @PathVariable Long inquireId,
            @RequestBody InquireRequestDto.Inquire dto
    ) {

        if( inquireService.isCompleted(inquireId))
            return ResponseEntity.ok(APIResponse.of(ErrorCode.INVALID_INQUIRE_STATUS, "이미 답변이 완료되어 문의를 수정할 수 없습니다."));

        try {
            inquireService.updateInquire(inquireId, dto.getInquire());
            return ResponseEntity.ok(APIResponse.of(SuccessCode.UPDATE_SUCCESS));
        } catch (Exception e){
            return ResponseEntity.ok(APIResponse.of(ErrorCode.UPDATE_ERROR));
        }
    }

    @Operation(summary = "내 문의 취소하기", description = "사용자가 문의를 취소합니다. * 답변이 달리지 않았을 때만 가능")
    @DeleteMapping("/{inquireId}")
    public ResponseEntity<APIResponse> deleteMyInquire(
            @Schema(description = "문의 id", example = "1")
            @PathVariable Long inquireId
    ) {

        if( inquireService.isCompleted(inquireId))
            return ResponseEntity.ok(APIResponse.of(ErrorCode.INVALID_INQUIRE_STATUS, "이미 답변이 완료되어 문의를 수정할 수 없습니다."));

        try {
            inquireService.deleteMyInquire(inquireId);
            return ResponseEntity.ok(APIResponse.of(SuccessCode.DELETE_SUCCESS));
        } catch (Exception e){
            return ResponseEntity.ok(APIResponse.of(ErrorCode.DELETE_ERROR, e));
        }
    }
}
