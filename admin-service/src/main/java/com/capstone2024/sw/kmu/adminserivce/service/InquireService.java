package com.capstone2024.sw.kmu.adminserivce.service;

import com.capstone2024.sw.kmu.adminserivce.controller.dto.request.InquireRequestDto;
import com.capstone2024.sw.kmu.adminserivce.domain.Inquire;
import com.capstone2024.sw.kmu.adminserivce.repository.InquireRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class InquireService {

    private final InquireRepository inquireRepository;

    public void createInquire(Long userId, String inquire) {

        inquireRepository.save(Inquire.from(userId, 1, inquire));
    }

    public void createRemittanceInquire(Long userId, InquireRequestDto.RemittanceInquire dto) {

        String inquire = formToText(dto.getTransId(), dto.getExpectedAmount(), dto.getInquire());

        inquireRepository.save(Inquire.from(userId, 2, inquire));
    }

    private String formToText(Long transId, String expectedAmount, String inquire) {
        return "거래 id: " + transId + "\n\n원래 보내려고 했던 금액: " + expectedAmount + "\n\n추가 문의사항: " + inquire;
    }

    public List<Inquire> getInquires(String type) {

        return switch (type) {
            case "all" -> inquireRepository.findAllByOrderByCreatedAtDesc();
            case "general" -> inquireRepository.findByInquireTypeOrderByCreatedAtDesc(1);
            case "refund" -> inquireRepository.findByInquireTypeOrderByCreatedAtDesc(2);
            default -> throw new IllegalArgumentException("잘못된 타입을 입력했습니다.: " + type);
        };
    }
}
