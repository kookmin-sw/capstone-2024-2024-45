package com.capstone2024.sw.kmu.adminserivce.domain;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "inquire")
public class Inquire {

    @Id
    @Column(name = "inquire_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long inquireId;

    @Column(name = "inquirer_id")
    private Long inquirerId;

    // 1: 일반 문의, 2: 거래 취소 문의
    @Column(name = "inquire_type")
    private int inquireType;

    @Column(name = "inquire_text")
    private String inquireText;

    @Column(name = "is_completed")
    private boolean isCompleted;

    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;

    public static Inquire from(Long userId, int type, String inquire) {
        return Inquire.builder()
                .inquirerId(userId)
                .inquireType(type)
                .inquireText(inquire)
                .isCompleted(false)
                .build();
    }
}
