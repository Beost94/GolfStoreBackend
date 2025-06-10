package com.GolfStore.backend.DTOMapper;

import com.GolfStore.backend.dto.CartDTOs.ShoppingCartDTO;
import com.GolfStore.backend.dto.CartDTOs.ShoppingCartItemDTO;
import com.GolfStore.backend.dto.FilterDTOs.FilterOptionDTO;
import com.GolfStore.backend.dto.ProductDTOs.AttributeDTO;
import com.GolfStore.backend.dto.ProductDTOs.MenuGridProductDTO;
import com.GolfStore.backend.dto.ProductDTOs.ProductVariantDTO;
import com.GolfStore.backend.dto.ProductDTOs.ProductWithVariantsDTO;
import com.GolfStore.backend.dto.ProductRepositoryDTOs.FlatVariantsDTO;
import com.GolfStore.backend.dto.UserDTOs.UserDTO;
import com.GolfStore.backend.model.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class DTOMapper {

    //Product mappers--------------------------------------------------------------------------------------------------------
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

    public ProductWithVariantsDTO mapToProductWithVariantsDTO(Product product, List<FlatVariantsDTO> flatVariantsDTOS){
        ProductWithVariantsDTO productWithVariantsDTO = new ProductWithVariantsDTO();

        productWithVariantsDTO.setProductName(product.getProductName());
        productWithVariantsDTO.setPrice(product.getPrice());
        productWithVariantsDTO.setDescription(product.getDescription());
        productWithVariantsDTO.setImageUrls(
                product.getImages().stream()
                        .map(Images::getImageUrl)
                        .toList()
        );

        Map<Integer, List<AttributeDTO>> variantMap = new LinkedHashMap<>();

        for (FlatVariantsDTO row : flatVariantsDTOS) {
            Integer variantId = row.getVariantId();
            AttributeDTO attributeDTO = new AttributeDTO(
                    row.getAttributeName(),
                    row.getAttributeValue(),
                    row.isMainAttribute()
            );
            variantMap.computeIfAbsent(variantId, k -> new ArrayList<>()).add(attributeDTO);
        }

        List<ProductVariantDTO> variantDTOs = variantMap.entrySet().stream()
                .map(entry -> new ProductVariantDTO(entry.getKey(), entry.getValue()))
                .toList();

        productWithVariantsDTO.setVariants(variantDTOs);
        return productWithVariantsDTO;

    }

    //Filter mappers---------------------------------------------------------------------------------------------------------

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

    //ShoppingCart Mappers---------------------------------------------------------------------------------------------------

    public ShoppingCartDTO mapToShoppingCartDTO(ShoppingCart cart, List<ShoppingCartItem> shoppingCartItems) {
        List<ShoppingCartItemDTO> itemDTOs = mapToShoppingCartItemDTOList(shoppingCartItems);
        return new ShoppingCartDTO(cart.getShoppingCartId(), itemDTOs);
    }

    public List<ShoppingCartItemDTO> mapToShoppingCartItemDTOList(List<ShoppingCartItem> shoppingCartItems) {
        List<ShoppingCartItemDTO> dtos = new ArrayList<>();
        for (ShoppingCartItem item : shoppingCartItems) {
            ProductVariant variant = item.getProductVariant();
            Product product = variant.getProduct();
            dtos.add(new ShoppingCartItemDTO(
                    product.getProductId(),
                    variant.getVariantId(),
                    product.getProductName(),
                    product.getPrice(),
                    item.getAmount(),
                    product.getImages().get(0).getImageUrl()
            ));
        }
        return dtos;
    }

    //User Mappers-----------------------------------------------------------------------------------------------------------

    public UserDTO mapToUserDTO(User user) {
        return new UserDTO(
                user.getKeycloakId(),
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getAddress(),
                user.getPhone()
        );
    }

}
