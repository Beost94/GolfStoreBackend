package com.GolfStore.backend.dto.ProductDTOs;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "Detailed product data, including base info and variant attribute structure")
public class ProductWithVariantsDTO {

    @Schema(description = "ID of the product", example = "101")
    private Integer productId;

    @Schema(description = "Name of the product", example = "TaylorMade Stealth Driver")
    private String productName;

    @Schema(description = "Base price of the product", example = "499.99")
    private Double price;

    @Schema(description = "Full product description text", example = "The TaylorMade Stealth Driver delivers incredible speed and forgiveness.")
    private String description;

    @Schema(
            description = "URLs of all images of this product",
            example = "[\"https://cdn.store.com/images/stealth-driver-front.jpg\", \"https://cdn.store.com/images/stealth-driver-side.jpg\"]"
    )
    private List<String> imageUrls;

    @Schema(description = "List of all variant configurations for this product, grouped by attributes")
    private List<ProductVariantDTO> variants;
}
