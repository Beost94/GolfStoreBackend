package com.GolfStore.backend.controller;
//TEST-MASTER

import com.GolfStore.backend.dto.FilterDTOs.FilterOptionDTO;
import com.GolfStore.backend.dto.ProductDTOs.MenuGridProductDTO;
import com.GolfStore.backend.dto.ProductDTOs.PageResponseDTO;
import com.GolfStore.backend.dto.ProductDTOs.ProductWithVariantsDTO;
import com.GolfStore.backend.dto.ProductDTOs.ProductSearchCriteriaDTO;
import com.GolfStore.backend.service.ProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products")

public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }
    /* There is no verify because all of the attributes in ProductSearchCriteriaDTO are optional,
    * so here are no @notnull or @notempty restrictions to verify.  */
    @GetMapping("/MenuGrid")
    @Operation(summary = "Fetch products as DTO's for menugrid",description = "Returns a paginated list of products that has variants with the filtering criterias")
    @ApiResponses ({
        @ApiResponse(responseCode = "200", description = "Successfully returned products matching filtering criteria"),
        @ApiResponse(responseCode = "500", description = "Internal server error")
    })

    public PageResponseDTO<MenuGridProductDTO> getProductsForMenuGrid(
            ProductSearchCriteriaDTO criteria,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int sizePerPage
    ) {
        return productService.getProductsForMenuGrid(criteria, page, sizePerPage);
    }

    @GetMapping("/GetProductDetail/{productId}")
    public ResponseEntity<ProductWithVariantsDTO> getProductDetail(@PathVariable Integer productId){
        return ResponseEntity.ok(productService.getProductWithVariants(productId));
    }


    @GetMapping("/filteroptions")
    @Operation(summary="Fetch Filter Options for a category",description = "Returns a list of Filter options for a specific category. Such as Size, Color etc")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Successfully returned a list of filtering options for given category"),
            @ApiResponse(responseCode = "204", description = "No filter options found for given category"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    public ResponseEntity<List<FilterOptionDTO>> getFilterOptionsForCategory(@RequestParam String category) {
        List<FilterOptionDTO> options = productService.getFilterOptionsForCategory(category);

        if (options == null || options.isEmpty()) {
            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.ok(options);
    }







}
