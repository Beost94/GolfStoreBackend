package com.GolfStore.backend.dto.ProductDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;
@Data
@AllArgsConstructor

public class ProductVariantDTO {

    private Integer variantId;
    private List<AttributeDTO> attributes;
}
