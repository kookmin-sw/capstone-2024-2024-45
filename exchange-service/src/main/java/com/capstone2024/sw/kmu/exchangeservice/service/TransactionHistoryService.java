package com.capstone2024.sw.kmu.exchangeservice.service;


import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.domain.bankcore.AccountInfo;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.request.RemittanceRequestDto;
import com.capstone2024.sw.kmu.exchangeservice.controller.dto.response.TransactionHistoryResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.remittance.TransactionHistory;
import com.capstone2024.sw.kmu.exchangeservice.repository.remittance.TransactionHistoryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TransactionHistoryService {

    private final TransactionHistoryRepository transactionHistoryRepository;


    public TransactionHistory create(AccountInfo senderInfo, AccountInfo receiverInfo, int amount, String userId) {

        return transactionHistoryRepository.save(TransactionHistory.build(senderInfo,receiverInfo,amount,userId));
    }

    public TransactionHistoryResponseDto.RemittanceResult findTransHistory(Long transId) {

        TransactionHistory transactionHistory = transactionHistoryRepository.findByTransId(transId);

        return TransactionHistoryResponseDto.RemittanceResult.from(transactionHistory);
    }

    public TransactionHistoryResponseDto.RemittanceResultWithUserInfo findSpecificTransHistory(Long transId, boolean isSender) {

        TransactionHistory transactionHistory = transactionHistoryRepository.findByTransId(transId);

        // TODO: user-service, 해당 정보를 바탕으로 닉네임과 프로필이미지를 받아오는 api
        User user = new User(null, null);

        if(isSender){
            user.setUserNickname("받은이");
            user.setUserProfileImg("받은이 프로필 이미지 url 이 들어갈 예정");
            return TransactionHistoryResponseDto.RemittanceResultWithUserInfo.receiverInfoFrom(transactionHistory, user);
        }else {
            user.setUserNickname("보낸이");
            user.setUserProfileImg("보낸이 프로필 이미지 url 이 들어갈 예정");
            return TransactionHistoryResponseDto.RemittanceResultWithUserInfo.senderInfoFrom(transactionHistory, user);
        }

    }

    public APIResponse<List<TransactionHistoryResponseDto.RemittanceList>> getUserHistory(RemittanceRequestDto.History dto) {

        List<TransactionHistory> transactionHistories = new ArrayList<>();

        switch (dto.getType()){
            case ALL:
                transactionHistories = transactionHistoryRepository.findByAccountId(dto.getAccountId());
                break;
            case SEND:
                transactionHistories = transactionHistoryRepository.findBySenderAccountId(dto.getAccountId());
                break;
            case RECEIVE:
                transactionHistories = transactionHistoryRepository.findByReceiverAccountId(dto.getAccountId());
        }

        // TODO: user-service, 해당 정보를 바탕으로 닉네임과 프로필이미지를 받아오는 api
        User user = new User(null, null);

        List<TransactionHistoryResponseDto.RemittanceList> list = transactionHistories.stream()
                .map( i -> {
                    if( i.getSenderAccountId().equals(dto.getAccountId())){ // 내가 보낸이면
                        user.setUserNickname("받은이");
                        user.setUserProfileImg("받은이 프로필 이미지 url 이 들어갈 예정");
                        return TransactionHistoryResponseDto.RemittanceList.receiverInfoFrom(i, user);
                    }else{
                        user.setUserNickname("보낸이");
                        user.setUserProfileImg("보낸이 프로필 이미지 url 이 들어갈 예정");
                        return TransactionHistoryResponseDto.RemittanceList.senderInfoFrom(i, user);
                    }
                })
                .toList();

        return APIResponse.of(SuccessCode.SELECT_SUCCESS, list);
    }

    public APIResponse<List<TransactionHistoryResponseDto.RemittanceResult>> getAllHistory() {

        List<TransactionHistory> transactionHistories = transactionHistoryRepository.findAllByOrderByTransIdDesc();

        return APIResponse.of(SuccessCode.SELECT_SUCCESS, transactionHistories);
    }
}
