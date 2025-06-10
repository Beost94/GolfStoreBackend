package com.GolfStore.backend.dto.ProductDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
@Data
@AllArgsConstructor
@NoArgsConstructor

public class ProductSearchCriteriaDTO {
    private String category;
    private List<String> brand;
    private List<String> size;
    private List<String> color;
    private Double minPrice;
    private Double maxPrice;
    private String search;
}
