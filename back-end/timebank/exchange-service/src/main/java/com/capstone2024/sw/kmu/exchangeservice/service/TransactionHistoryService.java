package com.capstone2024.sw.kmu.exchangeservice.service;


import com.capstone2024.sw.kmu.exchangeservice.base.dto.APIResponse;
import com.capstone2024.sw.kmu.exchangeservice.base.dto.SuccessCode;
import com.capstone2024.sw.kmu.exchangeservice.client.UserClient;
import com.capstone2024.sw.kmu.exchangeservice.client.UserClientResponseDto;
import com.capstone2024.sw.kmu.exchangeservice.domain.User;
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
    private final UserClient userClient;


    public TransactionHistory create(AccountInfo senderInfo, AccountInfo receiverInfo, int amount, String userId) {

        return transactionHistoryRepository.save(TransactionHistory.build(senderInfo,receiverInfo,amount,userId));
    }

    public TransactionHistoryResponseDto.RemittanceResult findTransHistory(Long transId) {

        TransactionHistory transactionHistory = transactionHistoryRepository.findByTransId(transId);

        return TransactionHistoryResponseDto.RemittanceResult.from(transactionHistory);
    }

    public TransactionHistoryResponseDto.RemittanceResultWithUserInfo findSpecificTransHistory(Long transId, boolean isSender) {

        TransactionHistory transactionHistory = transactionHistoryRepository.findByTransId(transId);

        UserClientResponseDto.UserInfo receiverInfo = userClient.getProfile(transactionHistory.getReceiverAccountId()).get(0);
        UserClientResponseDto.UserInfo senderInfo = userClient.getProfile(transactionHistory.getSenderAccountId()).get(0);

        if(isSender){
            User user = new User(receiverInfo.getNickname(), receiverInfo.getProfile_img());
            return TransactionHistoryResponseDto.RemittanceResultWithUserInfo.receiverInfoFrom(transactionHistory, user);
        }else {
            User user = new User(senderInfo.getNickname(), senderInfo.getProfile_img());
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

        User user = new User(null, null);

        List<TransactionHistoryResponseDto.RemittanceList> list = transactionHistories.stream()
                .map( i -> {
                    if( i.getSenderAccountId().equals(dto.getAccountId())){ // 내가 보낸이면
                        UserClientResponseDto.UserInfo receiverInfo = userClient.getProfile(i.getReceiverAccountId()).get(0);
                        user.setUserNickname(receiverInfo.getNickname());
                        user.setUserProfileImg(receiverInfo.getProfile_img());
                        return TransactionHistoryResponseDto.RemittanceList.receiverInfoFrom(i, user);
                    }else{
                        UserClientResponseDto.UserInfo senderInfo = userClient.getProfile(i.getSenderAccountId()).get(0);
                        user.setUserNickname(senderInfo.getNickname());
                        user.setUserProfileImg(senderInfo.getProfile_img());
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
