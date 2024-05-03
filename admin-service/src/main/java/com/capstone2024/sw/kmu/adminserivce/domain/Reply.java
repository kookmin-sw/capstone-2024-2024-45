package com.capstone2024.sw.kmu.adminserivce.domain;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

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
    private Long adminId;

    @MapsId("inquire_id")
    @OneToOne
    @JoinColumn(name = "admin_id")
    private Administrator admin;

    @Column(name = "reply")
    private String reply;

    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;

    /*
    @UpdateTimestamp
    @UpdateTimestamp 어노테이션이 있는 필드가 자동으로 업데이트되지 않는 이유는,
    @Query를 사용한 사용자 정의 쿼리로 데이터를 직접 업데이트할 때 JPA가 엔티티의 생명주기 이벤트를 트리거하지 않기 때문입니다.
     */
    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;

    public static Reply from(Long inquireId, Long adminId, String reply) {
        return Reply.builder()
                .inquireId(inquireId)
                .adminId(adminId)
                .reply(reply)
                .build();
    }
}
