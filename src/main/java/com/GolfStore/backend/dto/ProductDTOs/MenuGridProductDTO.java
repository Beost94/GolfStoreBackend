package com.GolfStore.backend.dto.ProductDTOs;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "Simplified product information for menu grid display")
public class MenuGridProductDTO {

    @Schema(description = "Unique ID of the product", example = "101")
    private Integer productId;

    @Schema(description = "Name of the product", example = "TaylorMade Stealth Driver")
    private String productName;

    @Schema(description = "Base price of the product", example = "499.99")
    private Double price;

    @Schema(description = "Brand name of the product", example = "TaylorMade")
    private String brandName;

    @Schema(description = "URL of the primary product image", example = "https://cdn.store.com/images/stealth-driver.jpg")
    private String imageUrl;
}
