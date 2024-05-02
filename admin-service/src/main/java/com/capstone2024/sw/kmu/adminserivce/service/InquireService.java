package com.capstone2024.sw.kmu.adminserivce.service;

import com.capstone2024.sw.kmu.adminserivce.base.dto.APIResponse;
import com.capstone2024.sw.kmu.adminserivce.base.dto.ErrorCode;
import com.capstone2024.sw.kmu.adminserivce.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.adminserivce.controller.dto.request.InquireRequestDto;
import com.capstone2024.sw.kmu.adminserivce.domain.Inquire;
import com.capstone2024.sw.kmu.adminserivce.repository.InquireRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class InquireService {

    private final InquireRepository inquireRepository;

    public void createInquire(Long userId, String inquire) {

        inquireRepository.save(Inquire.from(userId, inquire));
    }

    public void createRemittanceInquire(Long userId, InquireRequestDto.RemittanceInquire dto) {

        String inquire = formToText(dto.getTransId(), dto.getExpectedAmount(), dto.getInquire());

        inquireRepository.save(Inquire.from(userId, inquire));
    }

    private String formToText(Long transId, String expectedAmount, String inquire) {
        return "거래 id: " + transId + "\n\n원래 보내려고 했던 금액: " + expectedAmount + "\n\n추가 문의사항: " + inquire;
    }
}
