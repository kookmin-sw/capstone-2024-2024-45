package com.capstone2024.sw.kmu.exchangeservice.service;

import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.ErrorCode;
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
                // balance < 0 && 정지 아님 then 일시정지 <- 관리자가 송금 되돌릴 때 예외 사항
                if(userInfo.getBalance() < 0 && !userInfo.isSuspended()){
                    userInfo.updateSuspended(AccountInfo.SuspensionType.SEND, true);
                }
                break;

            case "INCREASE":
                userInfo.setBalance(userInfo.getBalance() + amount);

                // if 일시정지 && balance > 0 then 일시정지 해제 <- 송금 시 예외 사항
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

    public APIResponse validateSender(String accountId, int amount) {
        AccountInfo userInfo = getInfo(accountId);

        if(userInfo.isSuspended()){
            switch (userInfo.getSuspendedType()){
                case SEND :
                    return APIResponse.of(ErrorCode.BLOCK_ACCOUNT, "잔액이 0 미만이므로 송금이 제한되어 있습니다.");
                case BOTH:
                    return APIResponse.of(ErrorCode.BLOCK_ACCOUNT, "휴면 계좌 입니다.");
            }
        }

        // 정지계좌가 아니면, 잔액 확인
        if(userInfo.getBalance() < amount){
            return APIResponse.of(ErrorCode.INSUFFICIENT_AMOUNT, "보내는 사람의 잔액이 부족합니다.");
        }

        return null;
    }
}
