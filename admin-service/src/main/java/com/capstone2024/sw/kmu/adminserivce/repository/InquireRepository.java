package com.capstone2024.sw.kmu.adminserivce.repository;

import com.capstone2024.sw.kmu.adminserivce.domain.Inquire;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InquireRepository extends JpaRepository<Inquire, Long> {

    List<Inquire> findAllByOrderByCreatedAtDesc();
    List<Inquire> findByInquireTypeOrderByCreatedAtDesc(int type);
}
