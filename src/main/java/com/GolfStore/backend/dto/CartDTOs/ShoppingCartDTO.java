package com.GolfStore.backend.dto.CartDTOs;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;
@AllArgsConstructor
@Data

@Schema(description = "DTO to send the content of a users shoppingcart to the frontend")
public class ShoppingCartDTO {

    @Schema(description = "the ID of the shoppingcart", example = "123")
    private Integer shoppingcartId;
    @Schema(
            description = "The content of the shopping cart, contains items with variant ID, amount, and image",
            example = "[{\"productId\":101,\"variantId\":5001,\"productName\":\"Nike Vapor Golf Shoes\",\"price\":199.99,\"amount\":2,\"imageUrl\":\"https://cdn.store.com/images/nike-vapor.jpg\"}," +
                    "{\"productId\":102,\"variantId\":5002,\"productName\":\"Titleist Pro V1 Golf Balls\",\"price\":49.99,\"amount\":1,\"imageUrl\":\"https://cdn.store.com/images/pro-v1.jpg\"}]")
    private List<ShoppingCartItemDTO> shoppingcartItems;

}
