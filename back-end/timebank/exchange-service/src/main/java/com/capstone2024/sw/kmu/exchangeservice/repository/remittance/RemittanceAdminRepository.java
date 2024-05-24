package com.capstone2024.sw.kmu.exchangeservice.repository.remittance;

import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.RemittanceManage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RemittanceAdminRepository extends JpaRepository<RemittanceManage, String> {
}
