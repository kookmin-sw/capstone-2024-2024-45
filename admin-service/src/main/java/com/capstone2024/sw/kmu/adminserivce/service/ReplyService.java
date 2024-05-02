package com.capstone2024.sw.kmu.adminserivce.service;

import com.capstone2024.sw.kmu.adminserivce.controller.dto.request.ReplyRequestDto;
import com.capstone2024.sw.kmu.adminserivce.domain.Reply;
import com.capstone2024.sw.kmu.adminserivce.repository.ReplyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReplyService {

    private final ReplyRepository replyRepository;

    public void reply(Long inquireId, Long adminId, ReplyRequestDto.Reply dto) {
        replyRepository.save(Reply.from(inquireId,adminId, dto.getReply()));
    }
}
