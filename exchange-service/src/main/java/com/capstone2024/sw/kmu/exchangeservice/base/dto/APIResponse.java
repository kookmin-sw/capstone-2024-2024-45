package com.capstone2024.sw.kmu.exchangeservice.base.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.HashMap;

@Getter
@NoArgsConstructor
public class APIResponse<T> {
    private int status;         // 성공 상태 코드
    private String code;        // 구분 코드
    private String msg;         // 성공 메시지
    private String detailMsg;

    private T data;

    @Builder
    public APIResponse(final SuccessCode code) {
        this.msg = code.getMessage();
        this.status = code.getStatus();
        this.code = code.getCode();
        this.detailMsg = "";
        this.data = (T)new HashMap<String,String>();
    }

    @Builder
    public APIResponse(final SuccessCode code, final T data) {
        this.msg = code.getMessage();
        this.status = code.getStatus();
        this.code = code.getCode();
        this.data = data;
        this.detailMsg = "";
    }

    @Builder
    public APIResponse(final SuccessCode code, String detailMsg) {
        this.msg = code.getMessage();
        this.status = code.getStatus();
        this.code = code.getCode();
        this.detailMsg = detailMsg;
        this.data = (T) "";
    }

    @Builder
    public APIResponse(final ErrorCode code) {
        this.msg = code.getMessage();
        this.status = code.getStatus();
        this.code = code.getDivisionCode();
        this.detailMsg = "";
        this.data = (T)new HashMap<String,String>();
    }

    @Builder
    public APIResponse(final ErrorCode code, final T data) {
        this.msg = code.getMessage();
        this.status = code.getStatus();
        this.code = code.getDivisionCode();
        this.data = data;
        this.detailMsg = "";
    }

    @Builder
    public APIResponse(final ErrorCode code, String detailMsg) {
        this.msg = code.getMessage();
        this.status = code.getStatus();
        this.code = code.getDivisionCode();
        this.detailMsg = detailMsg;
        this.data = (T) "";
    }


    public static APIResponse of(final SuccessCode code) {
        return new APIResponse(code);
    }

    public static APIResponse of(final SuccessCode code, Object data){
        return new APIResponse(code, data);
    }

    public static APIResponse of(final SuccessCode code, String detailMsg){
        return new APIResponse(code, detailMsg);
    }

    public static APIResponse of(final ErrorCode code) {
        return new APIResponse(code);
    }

    public static APIResponse of(final ErrorCode code, Object data){
        return new APIResponse(code, data);
    }

    public static APIResponse of(final ErrorCode code, String detailMsg){
        return new APIResponse(code, detailMsg);
    }
}
