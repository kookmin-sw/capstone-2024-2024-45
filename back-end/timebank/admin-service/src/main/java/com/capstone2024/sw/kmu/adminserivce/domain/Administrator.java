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
@Table(name = "administrator")
public class Administrator {

    @Id
    @Column(name = "admin_id")
    private Long adminId;

    @Column(name = "role")
    private String role;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "login_id")
    private String loginId;

    @Column(name = "login_pw")
    private String loginPw;

    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
}
