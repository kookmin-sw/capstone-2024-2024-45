package com.capstone2024.sw.kmu.exchangeservice.service;

import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.RemittanceResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.bankcore.AccountInfo;
import com.capstone2024.sw.kmu.exchangeservice.repository.bankcore.BankCoreRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional("bankCoreTransactionManager")
public class BankCoreService {

    private final BankCoreRepository bankCoreRepository;

    public AccountInfo getInfo(String accountId) {
        return bankCoreRepository.findByAccountId(accountId);
    }

    public void updateBalance(AccountInfo userInfo, int amount, String type){

        switch (type){

            case "DECREASE":
                userInfo.setBalance(userInfo.getBalance() - amount);
                break;

            case "INCREASE":
                userInfo.setBalance(userInfo.getBalance() + amount);

                // if 일시정지 && balance > 0 then 일시정지 해제
                if(userInfo.isSuspended() && userInfo.getSuspendedType() == AccountInfo.SuspensionType.SEND && userInfo.getBalance() > 0){
                    userInfo.updateSuspended(AccountInfo.SuspensionType.NONE, false);
                }
                break;
        }
        bankCoreRepository.save(userInfo);
    }

    public boolean validateSenderBalance(String accountId, int amount) {
        AccountInfo userInfo = getInfo(accountId);
        return userInfo.getBalance() >= amount;
    }
}
