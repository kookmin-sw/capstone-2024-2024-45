package com.capstone2024.sw.kmu.exchangeservice.repository.remittance;

import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.TransactionHistory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Qualifier("transactionHistoryEntityManager")
public interface TransactionHistoryRepository extends JpaRepository<TransactionHistory, String> {

    TransactionHistory findByTransId(Long transId);

    @Query("SELECT t FROM TransactionHistory t " +
            "WHERE t.senderAccountId = :accountId OR t.receiverAccountId = :accountId ORDER BY t.createdAt DESC")
    List<TransactionHistory> findByAccountId(@Param("accountId") String accountId);

    List<TransactionHistory> findAllByOrderByTransIdDesc();
}
