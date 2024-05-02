package com.capstone2024.sw.kmu.adminserivce.repository;

import com.capstone2024.sw.kmu.adminserivce.domain.Reply;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface ReplyRepository extends JpaRepository<Reply, Long> {

    @Modifying
    @Transactional
    @Query("UPDATE Reply i SET i.reply = :reply, i.updatedAt = CURRENT_TIMESTAMP WHERE i.inquireId = :id")
    void findByInquireIdAndUpdateReply(Long id, String reply);

    @Query("SELECT i.adminId FROM Reply i WHERE i.inquireId = :id")
    Long findAdminIdByInquireId(Long id);
}
