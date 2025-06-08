package com.GolfStore.backend.DTOMapper;

import com.GolfStore.backend.dto.FilterOptionDTO;
import com.GolfStore.backend.dto.MenuGridProductDTO;
import com.GolfStore.backend.dto.ProductDetailDTO;
import com.GolfStore.backend.model.CategoryFilterOption;
import com.GolfStore.backend.model.FilterValue;
import com.GolfStore.backend.model.Images;
import com.GolfStore.backend.model.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class DTOMapper {


    public MenuGridProductDTO mapToDTOMenuGrid(Product product) {
        if (product == null) {
            throw new IllegalArgumentException("Product cant be null");
        }
        return new MenuGridProductDTO(
                product.getProductId(),
                product.getProductName(),
                product.getPrice(),
                product.getBrand().getBrandName(),
                !product.getImages().isEmpty() ? product.getImages().get(0).getImageUrl() : null
        );
    }
    public ProductDetailDTO mapToDTOProductDetail(Product product) {
        if (product == null) {
            throw new IllegalArgumentException("Product cant be null");
        }
        return new ProductDetailDTO(
                product.getProductId(),
                product.getProductName(),
                product.getPrice(),
                product.getDescription(),
                product.getBrand().getBrandName(),
                product.getCategory().getCategoryName(),
                product.getHasVariants(),
                product.getImages().stream()
                        .map(Images::getImageUrl) //
                        .collect(Collectors.toList())
        );

    }
    public List<FilterOptionDTO> mapToDTOFilterOptions(List<CategoryFilterOption> cfos){
        List<FilterOptionDTO> filterOptionDTOList = new ArrayList<>();

        for(CategoryFilterOption cfo: cfos){
            FilterOptionDTO filterOptionDTO = new FilterOptionDTO(
                    cfo.getFilterOption().getFilterName(),
                    cfo.getFilterOption().getFilterValues()
                            .stream().map(FilterValue::getFiltervalueName)
                            .collect(Collectors.toList())
            );
            filterOptionDTOList.add(filterOptionDTO);
        }
        return filterOptionDTOList;
    }

}
