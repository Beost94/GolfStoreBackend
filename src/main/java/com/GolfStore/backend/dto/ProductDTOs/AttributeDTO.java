package com.GolfStore.backend.dto.ProductDTOs;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AttributeDTO {

    @Schema(description = "Name of the attribute (e.g., Size, Color)", example = "Size")
    private String attributeName;

    @Schema(description = "Value of the attribute", example = "Medium")
    private String attributeValue;

    @Schema(description = "Whether this is the primary attribute (like size or color)", example = "true")
    private boolean isMainAttribute;
}
