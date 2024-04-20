package com.capstone2024.sw.kmu.exchangeservice.domain.bankcore;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "bankcore")
public class AccountInfo {
    @Id
    @Column(name = "account_id", nullable = false)
    private String accountId;

    @Column(name = "balance", nullable = false)
    private int balance;

    @Column(name = "is_suspended", nullable = false, columnDefinition = "TINYINT(1)")
    private boolean isSuspended;

    @Enumerated(EnumType.STRING)
    @Column(name = "suspended_type", nullable = false, columnDefinition = "ENUM('NONE', 'SEND', 'BOTH')")
    private SuspensionType suspendedType;


    public void updateSuspended(SuspensionType suspendedType, boolean isSuspended) {
        this.suspendedType = suspendedType;
        this.isSuspended = isSuspended;
    }

    public enum SuspensionType {
        NONE, SEND, BOTH;
    }

}
