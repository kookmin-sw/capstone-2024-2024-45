package com.capstone2024.sw.kmu.exchangeservice.domain.bankcore;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "account")
public class AccountInfo {
    @Id
    @Column(name = "account_id", nullable = false)
    private String accountId;

    @Column(name = "balance", nullable = false)
    private int balance;

    @Column(name = "is_suspended", nullable = false)
    private boolean isSuspended;

    @Enumerated(EnumType.STRING)
    @Column(name = "suspend_type", nullable = false)
    private SuspensionType suspendType;


    public void updateSuspended(SuspensionType suspendedType, boolean isSuspended) {
        this.suspendType = suspendedType;
        this.isSuspended = isSuspended;
    }

    public enum SuspensionType {
        NONE, SEND, BOTH,
    }

}
