package com.GolfStore.backend.dto.ProductDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AttributeDTO {

    private String attributeName;
    private String attributeValue;
    private boolean isMainAttribute;
}
