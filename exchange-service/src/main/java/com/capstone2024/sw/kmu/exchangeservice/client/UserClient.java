package com.capstone2024.sw.kmu.exchangeservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@FeignClient(name = "user-service", url = "${path.service.user}")
public interface UserClient {

    @PostMapping("/api/user/{account_id}/profile")
    UserClientResponseDto.UserInfo getProfile(@PathVariable String account_id);
}
