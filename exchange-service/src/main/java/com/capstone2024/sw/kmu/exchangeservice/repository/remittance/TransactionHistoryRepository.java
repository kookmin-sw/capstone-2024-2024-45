package com.capstone2024.sw.kmu.exchangeservice.repository.remittance;

import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.TransactionHistory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("transactionHistoryEntityManager")
public interface TransactionHistoryRepository extends JpaRepository<TransactionHistory, String> {
}
