package com.capstone2024.sw.kmu.exchangeservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@FeignClient(name = "user-service", url = "${path.service.user}")
public interface UserClient {

    @GetMapping("/api/user/{account_id}/profile")
    // 상대 측에서 단일 정보를 List 로 보냄.
    List<UserClientResponseDto.UserInfo> getProfile(@PathVariable String account_id);
}
