package com.GolfStore.backend.dto.ProductRepositoryDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class FlatVariantsDTO {
    private final Integer productId;
    private final Integer variantId;
    private final String attributeName;
    private final String attributeValue;
    private final boolean isMainAttribute;
}
