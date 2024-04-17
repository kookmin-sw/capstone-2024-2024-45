package com.capstone2024.sw.kmu.exchangeservice.repository.bankcore;

import com.capstone2024.sw.kmu.exchangeservice.domain.bankcore.AccountInfo;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Qualifier("bankCoreEntityManager")
public interface BankCoreRepository extends JpaRepository<AccountInfo, Long> {
    AccountInfo findByAccountId(String accountId);
}
