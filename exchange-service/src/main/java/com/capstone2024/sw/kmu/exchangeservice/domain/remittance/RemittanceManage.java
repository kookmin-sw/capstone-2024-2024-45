package com.capstone2024.sw.kmu.exchangeservice.domain.remittance;

import com.capstone2024.sw.kmu.exchangeservice.controller.dto.request.RemittanceManageRequestDto;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name = "remittancemanage")
public class RemittanceManage {

    @Id
    @Column(name = "trans_id")
    private Long transId;

    @MapsId("trans_id")
    @OneToOne
    @JoinColumn(name = "trans_id")
    private TransactionHistory transactionHistory;

    @Column(name = "admin_id", nullable = false)
    private String adminId;

//    @Column(name = "admin_name", nullable = false)
//    private int adminName;

    @Column(name = "comment", nullable = false, columnDefinition = "TEXT")
    private String comment;


    public static RemittanceManage build(RemittanceManageRequestDto.RemittanceCancellation dto, String adminId, Long transId) {
        return RemittanceManage.builder()
                .transId(transId)
                .adminId(adminId)
                .comment(dto.getComment())
                .build();
    }
}
