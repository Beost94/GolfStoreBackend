package com.GolfStore.backend.controller;

import com.GolfStore.backend.dto.UserDTO;
import com.GolfStore.backend.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
@CrossOrigin(origins = "*")
public class UserController {
    private final UserService userService;

    @GetMapping
    public UserDTO getOrCreateUser(@AuthenticationPrincipal Jwt jwt) {
        return userService.getOrCreateUser(jwt);
    }

    @GetMapping("/forfaen")
    public String testCart(@AuthenticationPrincipal Jwt jwt) {
        return "hore";
    }

}








