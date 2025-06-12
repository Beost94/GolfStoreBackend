package com.GolfStore.backend.dto.ProductDTOs;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.domain.Page;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "Generic paginated response containing a list of items and pagination metadata")
public class PageResponseDTO<T> {

    @Schema(
            description = "List of items for the current page",
            example = "[{\"productId\":101,\"productName\":\"TaylorMade Stealth Driver\",\"price\":499.99,\"brandName\":\"TaylorMade\",\"imageUrl\":\"https://cdn.store.com/images/stealth-driver.jpg\"}," +
                    "{\"productId\":102,\"productName\":\"Callaway Chrome Soft Balls\",\"price\":44.99,\"brandName\":\"Callaway\",\"imageUrl\":\"https://cdn.store.com/images/chrome-soft.jpg\"}]"
    )
    private List<T> content;

    @Schema(description = "Current page index (0 based)", example = "0")
    private int pageNumber;

    @Schema(description = "Number of items per page", example = "12")
    private int pageSize;

    @Schema(description = "Total number of elements across all pages", example = "120")
    private long totalElements;

    @Schema(description = "Total number of pages", example = "10")
    private int totalPages;

    @Schema(description = "Whether this is the last page", example = "false")
    private boolean last;

    public static <T> PageResponseDTO<T> of(Page<?> page, List<T> content) {
        return new PageResponseDTO<>(
                content,
                page.getNumber(),
                page.getSize(),
                page.getTotalElements(),
                page.getTotalPages(),
                page.isLast()
        );
    }
}
