package com.GolfStore.backend.controller;
//TEST-MASTER

import com.GolfStore.backend.dto.*;
import com.GolfStore.backend.service.ProductService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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

    @GetMapping("/detail/{productId}")
    @Operation(summary = "Fetch a specific product as DTO",description = "Returns a DTO containing information about a specific product. Only information needed for presenting the product")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Successfully returned a product based on given productId"),
            @ApiResponse(responseCode = "404", description = "Product not found"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    public ResponseEntity<ProductDetailDTO> getProductForProductDetail(@PathVariable Integer productId) {
        ProductDetailDTO productDTO = productService.getProductsForProductDetail(productId);
        return ResponseEntity.ok(productDTO);
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




//EKSPERIMENTELT

    // ProductController.java (utvidelse)
    @GetMapping("/available-filter-values/{productId}")
    @Operation(summary = "Available filter values for product", description = "Returnerer en liste over tilgjengelige verdier (som finnes på lager) for et produkt.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Verdier hentet"),
            @ApiResponse(responseCode = "204", description = "Ingen verdier funnet for produkt"),
            @ApiResponse(responseCode = "500", description = "Intern feil")
    })
    public ResponseEntity<Map<String, List<String>>> getAvailableFilterValues(@PathVariable Integer productId) {
        Map<String, List<String>> result = productService.getAvailableFilterValuesForProduct(productId);
        if (result.isEmpty()) return ResponseEntity.noContent().build();
        return ResponseEntity.ok(result);
    }






}
