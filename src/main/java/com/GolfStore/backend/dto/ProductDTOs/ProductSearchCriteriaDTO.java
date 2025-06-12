package com.GolfStore.backend.dto.ProductDTOs;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "Search and filter options for querying products")
public class ProductSearchCriteriaDTO {

    @Schema(description = "Category name to filter by", example = "Drivers")
    @Size(max = 20, message = "Category name must be under 20 characters")
    private String category;

    @Schema(description = "List of brand names to include", example = "[\"TaylorMade\", \"Callaway\"]")
    private List<@NotBlank(message = "Brand cannot be blank") String> brand;

    @Schema(description = "List of sizes to include (typically for clothing/shoes)", example = "[\"Medium\", \"Large\"]")
    private List<@NotBlank(message = "Size cannot be blank") String> size;

    @Schema(description = "List of color names to include", example = "[\"Black\", \"Red\"]")
    private List<@NotBlank(message = "Color cannot be blank") String> color;

    @Schema(description = "Minimum price for filtering products", example = "100.00")
    @PositiveOrZero(message = "Minimum price must be positive")
    private Double minPrice;

    @Schema(description = "Maximum price for filtering products", example = "500.00")
    @PositiveOrZero(message = "Maximum price must be positive")
    private Double maxPrice;

    @Schema(description = "Search term to match against product name or description", example = "golf ball")
    @Size(max = 100, message = "Search term must be under 100 characters")
    private String search;
}
