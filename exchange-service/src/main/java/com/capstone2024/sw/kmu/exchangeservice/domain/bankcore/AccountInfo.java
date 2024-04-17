package com.capstone2024.sw.kmu.exchangeservice.domain.bankcore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
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
    @Column(name = "account_id")
    private String accountId;

    @Column(name = "balance")
    private int balance;

    @Column(name = "is_suspended")
    private boolean isSuspended;

    @Column(name = "suspended_type")
    private SuspensionType suspendedType;


    public void updateSuspended(SuspensionType suspendedType, boolean isSuspended) {
        this.suspendedType = suspendedType;
        this.isSuspended = isSuspended;
    }

    public enum SuspensionType {
        NONE, SEND, BOTH;
    }

}
