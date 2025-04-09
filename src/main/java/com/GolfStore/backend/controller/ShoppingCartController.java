package com.GolfStore.backend.controller;

import com.GolfStore.backend.dto.ShoppingCartDTO;
import com.GolfStore.backend.dto.UpdateCartItemRequest;
import com.GolfStore.backend.repository.StockRepository;
import com.GolfStore.backend.service.ShoppingCartService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController

@RequestMapping("/ShoppingCart")
@RequiredArgsConstructor
@Data
public class ShoppingCartController {
    private final ShoppingCartService shoppingCartService;
    private final StockRepository stockRepository;


@GetMapping("/GetShoppingCart")
    public ShoppingCartDTO getShoppingCart(@AuthenticationPrincipal Jwt jwt){

        UUID keycloakId = UUID.fromString(jwt.getSubject());

        return shoppingCartService.getShoppingCart(keycloakId);

    }

    @PatchMapping("/AddToCart")
    public ResponseEntity<?> updateCartItem(@RequestBody UpdateCartItemRequest request,
                                            @AuthenticationPrincipal Jwt jwt) {
        UUID keycloakId = UUID.fromString(jwt.getSubject());
        shoppingCartService.updateCartItem(keycloakId, request);
        return ResponseEntity.ok().build();
    }








}
