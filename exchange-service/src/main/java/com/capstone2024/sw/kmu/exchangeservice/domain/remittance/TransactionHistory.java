package com.capstone2024.sw.kmu.exchangeservice.domain.remittance;

import com.capstone2024.sw.kmu.exchangeservice.domain.bankcore.AccountInfo;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name = "transactionhistory")
public class TransactionHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trans_id")
    private Long transId;

    @Column(name = "sender_account_id")
    @NotNull
    private String senderAccountId;

    @Column(name = "receiver_account_id")
    @NotNull
    private String receiverAccountId;

    @Column(name = "amount")
    @NotNull
    private int amount;

    @Column(name = "sender_user_id")
    private String senderId;

    @Column(name = "sender_balance_after")
    @NotNull
    private int senderBalanceAfter;

    @Column(name = "receiver_balance_after")
    @NotNull
    private int receiverBalanceAfter;

    @Column(name = "created_at")
    @NotNull
    @CreationTimestamp
    private LocalDateTime createdAt;

    @Column(name = "is_success")
    @NotNull
    private boolean isSuccess;

    public static TransactionHistory build(AccountInfo senderInfo, AccountInfo receiverInfo, int amount, String userId){
        return TransactionHistory.builder()
                .senderAccountId(senderInfo.getAccountId())
                .receiverAccountId(receiverInfo.getAccountId())
                .amount(amount)
                .senderId(userId)
                .senderBalanceAfter(senderInfo.getBalance())
                .receiverBalanceAfter(receiverInfo.getBalance())
                .build();

    }

}
