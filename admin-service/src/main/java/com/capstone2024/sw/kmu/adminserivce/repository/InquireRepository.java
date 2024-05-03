package com.capstone2024.sw.kmu.adminserivce.repository;

import com.capstone2024.sw.kmu.adminserivce.domain.Inquire;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface InquireRepository extends JpaRepository<Inquire, Long> {
    Inquire findByInquireId(Long id);
    List<Inquire> findAllByOrderByCreatedAtDesc();
    List<Inquire> findByInquireTypeOrderByCreatedAtDesc(int type);

    @Modifying
    @Transactional
    @Query("UPDATE Inquire i SET i.isCompleted = true WHERE i.inquireId = :id")
    void findByInquireIdAndUpdateIsCompletedToTrue(Long id);

    @Query("SELECT i.isCompleted FROM Inquire i WHERE i.inquireId = :id")
    boolean findIsCompletedByInquireId(Long id);

    @Modifying
    @Transactional
    @Query("UPDATE Inquire i SET i.inquireText = :inquire, i.updatedAt = CURRENT_TIMESTAMP WHERE i.inquireId = :id")
    void findByInquireIdAndUpdateInquire(Long id, String inquire);

    List<Inquire> findByInquirerId(Long userId);

    void deleteByInquireId(Long inquireId);

}
