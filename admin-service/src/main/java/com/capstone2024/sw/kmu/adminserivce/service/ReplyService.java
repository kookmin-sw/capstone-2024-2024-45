package com.capstone2024.sw.kmu.adminserivce.service;

import com.capstone2024.sw.kmu.adminserivce.controller.dto.request.ReplyRequestDto;
import com.capstone2024.sw.kmu.adminserivce.domain.Reply;
import com.capstone2024.sw.kmu.adminserivce.repository.InquireRepository;
import com.capstone2024.sw.kmu.adminserivce.repository.ReplyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class ReplyService {

    private final ReplyRepository replyRepository;
    private final InquireRepository inquireRepository;

    public void reply(Long inquireId, Long adminId, ReplyRequestDto.Reply dto) {

        inquireRepository.findByInquireIdAndUpdateIsCompletedToTrue(inquireId);
        replyRepository.save(Reply.from(inquireId,adminId, dto.getReply()));
    }
}
