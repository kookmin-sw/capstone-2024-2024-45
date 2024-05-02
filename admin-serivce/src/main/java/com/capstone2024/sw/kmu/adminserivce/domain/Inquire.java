package com.capstone2024.sw.kmu.adminserivce.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
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
    private Long inquireId;

    @Column(name = "inquirer_id")
    private Long inquirerId;

    @Column(name = "inquire_text")
    private String inquireText;

    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
}
