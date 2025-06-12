package com.GolfStore.backend.controller;

import com.GolfStore.backend.dto.CartDTOs.ShoppingCartDTO;
import com.GolfStore.backend.dto.CartDTOs.UpdateCartItemRequest;
import com.GolfStore.backend.service.ShoppingCartService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/ShoppingCart")
@RequiredArgsConstructor

public class ShoppingCartController {
    private final ShoppingCartService shoppingCartService;


    //--------------------------------------/GetShoppingCart--------------------------------------------------------
    @GetMapping("/GetShoppingCart")
    @Operation(summary = "Get user's shopping cart", description = "Fetch the current shopping cart belonging to the logged-in user")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Shopping cart successfully fetched"),
            @ApiResponse(responseCode = "401", description = "Unauthorized, guy",
                    content = @Content(mediaType = "text/plain",
                    schema = @Schema(type = "string", example = "nuh uh uh, nuh uh uh"))),
            @ApiResponse(responseCode = "404", description = "User or Shopping cart not found",
                    content = @Content(mediaType = "text/plain",
                    schema = @Schema(type = "string", example = "User or shoppingcart not found"))),
            @ApiResponse(responseCode = "500", description = "Internal server error",
                    content = @Content(mediaType = "text/plain",
                    schema = @Schema(type = "string", example = "Internal server error")))
    })
    public ResponseEntity<ShoppingCartDTO> getShoppingCart(@AuthenticationPrincipal Jwt jwt) {
        UUID keycloakId = UUID.fromString(jwt.getSubject());
        ShoppingCartDTO shoppingCartDTO = shoppingCartService.getShoppingCart(keycloakId);
        return ResponseEntity.ok(shoppingCartDTO);
    }

    //----------------------------------------//AlterShoppingCart-------------------------------------------------------------

    @PatchMapping("/AlterShoppingCart")
    @Operation(summary = "Add/subtract/register new item from shopping cart", description = "Modify the quantity of a product variant in the users shopping cart")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Shopping cart successfully updated"),
            @ApiResponse(responseCode = "400", description = "Invalid input",
                    content = @Content(mediaType = "text/plain",
                    schema = @Schema(type = "string", example = "Invalid input, guy"))),
            @ApiResponse(responseCode = "404", description = "User or Shopping cart not found",
                    content = @Content(mediaType = "text/plain",
                    schema = @Schema(type = "string", example = "ShoppingCart not found, buddy"))),
            @ApiResponse(responseCode = "500", description = "Internal server error",
                    content = @Content(mediaType = "text/plain",
                    schema = @Schema(type = "string", example = "Internal server error, friend")))
    })
    public ResponseEntity<ShoppingCartDTO> updateCartItem(@Valid @RequestBody UpdateCartItemRequest request,
                                                          @AuthenticationPrincipal Jwt jwt) {
        UUID keycloakId = UUID.fromString(jwt.getSubject());
        shoppingCartService.updateCartItem(keycloakId, request);
        ShoppingCartDTO updatedCart = shoppingCartService.getShoppingCart(keycloakId);
        return ResponseEntity.ok(updatedCart);
    }
}
