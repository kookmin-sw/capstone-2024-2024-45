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
@Table(name = "reply")
public class Reply {

    @Id
    @Column(name = "inquire_id")
    private Long inquireId;

    @MapsId("inquire_id")
    @OneToOne
    @JoinColumn(name = "inquire_id")
    private Inquire inquire;

    @Column(name = "admin_id")
    private Long AdminId;

    @MapsId("inquire_id")
    @OneToOne
    @JoinColumn(name = "admin_id")
    private Administrator admin;

    @Column(name = "reply")
    private String reply;

    @Column(name = "created_at", nullable = false)
    @CreationTimestamp
    private LocalDateTime createdAt;
}
