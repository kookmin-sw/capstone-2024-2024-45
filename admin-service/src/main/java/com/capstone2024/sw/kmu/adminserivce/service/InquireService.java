package com.capstone2024.sw.kmu.adminserivce.service;

import com.capstone2024.sw.kmu.adminserivce.controller.dto.request.InquireRequestDto;
import com.capstone2024.sw.kmu.adminserivce.controller.dto.response.InquireReplyResponseDto;
import com.capstone2024.sw.kmu.adminserivce.domain.Inquire;
import com.capstone2024.sw.kmu.adminserivce.domain.Reply;
import com.capstone2024.sw.kmu.adminserivce.repository.InquireRepository;
import com.capstone2024.sw.kmu.adminserivce.repository.ReplyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class InquireService {

    private final InquireRepository inquireRepository;
    private final ReplyRepository replyRepository;

    public void createInquire(String userId, String inquire) {

        inquireRepository.save(Inquire.from(userId, 1, inquire));
    }

    public void createRemittanceInquire(String userId, InquireRequestDto.RemittanceInquire dto) {

        String inquire = formToText(dto.getTransId(), dto.getExpectedAmount(), dto.getInquire());

        inquireRepository.save(Inquire.from(userId, 2, inquire));
    }

    private String formToText(Long transId, String expectedAmount, String inquire) {
        return "거래 id: " + transId + "\n\n원래 보내려고 했던 금액: " + expectedAmount + "\n\n추가 문의사항: " + inquire;
    }

    public List<Inquire> getInquires(String type, Boolean isCompleted) {

        Integer typeInt;
        switch (type) {
            case "all" -> typeInt = null;
            case "general" -> typeInt = 1;
            case "refund" -> typeInt = 2;
            default -> throw new IllegalArgumentException("잘못된 타입을 입력했습니다.: " + type);
        };

        return inquireRepository.findAllByFiltersOrderByCreatedAtDesc(typeInt, isCompleted);
    }

    public InquireReplyResponseDto.InquireReply getInquire(Long inquireId) {
        Reply reply = replyRepository.findByInquireId(inquireId);

        if(reply == null){
            Inquire inquire = inquireRepository.findByInquireId(inquireId);
            return InquireReplyResponseDto.InquireReply.IncompletedFrom(inquire);
        }else{
            return InquireReplyResponseDto.InquireReply.CompletedFrom(reply);
        }
    }

    public boolean isCompleted(Long inquireId) {
        return inquireRepository.findIsCompletedByInquireId(inquireId);
    }

    public void updateInquire(Long inquireId, String inquire) {
        inquireRepository.findByInquireIdAndUpdateInquire(inquireId, inquire);
    }

    public List<Inquire> getMyInquires(String userId) {
        return inquireRepository.findByInquirerId(Long.parseLong(userId));
    }

    @Transactional
    public void deleteMyInquire(Long inquireId) {
        inquireRepository.deleteByInquireId(inquireId);
    }
}
