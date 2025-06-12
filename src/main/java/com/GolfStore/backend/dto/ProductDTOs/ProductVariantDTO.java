package com.GolfStore.backend.dto.ProductDTOs;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;
@Data
@AllArgsConstructor

public class ProductVariantDTO {

    @Schema(description = "ID of the product variant", example = "5001")
    private Integer variantId;

    @Schema(description = "List of attributes defining this variant")
    private List<AttributeDTO> attributes;

}
