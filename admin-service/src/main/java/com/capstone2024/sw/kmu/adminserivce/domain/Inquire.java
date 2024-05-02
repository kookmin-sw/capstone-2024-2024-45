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

    @Column(name = "inquire_text")
    private String inquireText;

    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;

    public static Inquire from(Long userId, String inquire) {
        return Inquire.builder()
                .inquirerId(userId)
                .inquireText(inquire)
                .build();
    }
}
