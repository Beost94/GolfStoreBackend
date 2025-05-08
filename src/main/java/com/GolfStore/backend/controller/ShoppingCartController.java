package com.GolfStore.backend.controller;

import com.GolfStore.backend.dto.ShoppingCartDTO;
import com.GolfStore.backend.dto.UpdateCartItemRequest;
import com.GolfStore.backend.repository.StockRepository;
import com.GolfStore.backend.service.ShoppingCartService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
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
    @Operation(summary = "Get user's shopping cart", description = "Fetch the current shopping cart belonging to the logged-in user")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Shopping cart successfully fetched"),
            @ApiResponse(responseCode = "404", description = "User or Shopping cart not found"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    public ResponseEntity<ShoppingCartDTO> getShoppingCart(@AuthenticationPrincipal Jwt jwt) {
        UUID keycloakId = UUID.fromString(jwt.getSubject());
        ShoppingCartDTO shoppingCartDTO = shoppingCartService.getShoppingCart(keycloakId);
        return ResponseEntity.ok(shoppingCartDTO);
    }

    @PatchMapping("/AlterShoppingCart")
    @Operation(summary = "Add/subtract/register new item from shopping cart", description = "Modify the quantity of a product variant in the users shopping cart")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Shopping cart successfully updated"),
            @ApiResponse(responseCode = "400", description = "Invalid input"),
            @ApiResponse(responseCode = "404", description = "User or Shopping cart not found"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    public ResponseEntity<ShoppingCartDTO> updateCartItem(@Valid @RequestBody UpdateCartItemRequest request,
                                                          @AuthenticationPrincipal Jwt jwt) {
        UUID keycloakId = UUID.fromString(jwt.getSubject());
        shoppingCartService.updateCartItem(keycloakId, request);
        ShoppingCartDTO updatedCart = shoppingCartService.getShoppingCart(keycloakId);
        return ResponseEntity.ok(updatedCart);
    }
}
