package com.capstone2024.sw.kmu.exchangeservice.repository.bankcore;

import com.capstone2024.sw.kmu.exchangeservice.domain.bankcore.AccountInfo;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("bankCoreEntityManager")
public interface BankCoreRepository extends JpaRepository<AccountInfo, Long> {
    AccountInfo findByAccountId(String accountId);

    @Query("SELECT a.balance FROM AccountInfo a WHERE a.accountId = :accountId")
    int findBalanceByAccountId(@Param("accountId") String accountId);
}
