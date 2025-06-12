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

    // --------------------- Product Mappers ---------------------

    // Maps a full Product entity to a simpler version for the menu grid.
    public MenuGridProductDTO mapToDTOMenuGrid(Product product) {
        if (product == null) {
            throw new IllegalArgumentException("Product cant be null");
        }

        // Grab the first image URL if available, or null if not.
        String imageUrl = product.getImages().isEmpty() ? null : product.getImages().get(0).getImageUrl();

        return new MenuGridProductDTO(
                product.getProductId(),
                product.getProductName(),
                product.getPrice(),
                product.getBrand().getBrandName(),
                imageUrl
        );
    }

    //WORKAROUND WARNING -----------------------------
// This is a deliberate workaround to avoid major refactors across the backend.
// Our system treats variantId as the fundamental unit for stock, cart, and ordering logic.
// However, some products don't have true variants (i.e., no attributes).
//
// Rather than refactoring all services to handle products without variants,
// we inject the first available variantId for such products, which effectively
// represents the base product itself.
//
// This is technically sloppy because were assuming the existence of a single
// variant with no attributes and using it as a placeholder. Long term, this should be reevaluated.
//
// For now, this ensures all products (even variantless ones) can be added to the
// cart and flow through the system consistently without rewriting core logic.
// ---------------------------------------------------------------------------------

    // Maps a Product and its flattened variant data into a structured DTO with nested attribute lists.
    public ProductWithVariantsDTO mapToProductWithVariantsDTO(Product product, List<FlatVariantsDTO> flatVariantsDTOS) {
        ProductWithVariantsDTO productWithVariantsDTO = new ProductWithVariantsDTO();

        // Fill in the basic stuff about the product
        productWithVariantsDTO.setProductId(product.getProductId());
        productWithVariantsDTO.setProductName(product.getProductName());
        productWithVariantsDTO.setPrice(product.getPrice());
        productWithVariantsDTO.setDescription(product.getDescription());

        // Grab all the image URLs tied to this product
        productWithVariantsDTO.setImageUrls(
                product.getImages().stream()
                        .map(Images::getImageUrl)
                        .toList()
        );

        List<ProductVariantDTO> variantDTOs;

        // If there are no variant attributes, we still need to send a variantId
        // because the rest of the backend (like the cart logic) works based on variantId
        // So yeah, this is a bit of a hack, but it saves us from rewriting a ton of stuff
        if (flatVariantsDTOS.isEmpty()) {
            Integer variantId = product.getProductVariants().stream()
                    .findFirst()
                    .map(ProductVariant::getVariantId)
                    .orElseThrow(() -> new IllegalStateException("Product has no variants in product_variants table"));

            // Just send the variantId with an empty list of attributes
            variantDTOs = List.of(new ProductVariantDTO(variantId, List.of()));
        } else {
            // Normal case: we've got variant rows with attribute data
            // So group all the attributes by variantId
            Map<Integer, List<AttributeDTO>> variantMap = new LinkedHashMap<>();

            for (FlatVariantsDTO row : flatVariantsDTOS) {
                Integer variantId = row.getVariantId();

                // Wrap this row into an AttributeDTO
                AttributeDTO attributeDTO = new AttributeDTO(
                        row.getAttributeName(),
                        row.getAttributeValue(),
                        row.isMainAttribute()
                );

                // Toss it into the list for the right variant
                variantMap.computeIfAbsent(variantId, k -> new ArrayList<>()).add(attributeDTO);
            }

            // Now turn each variantId + list of attributes into a proper DTO
            variantDTOs = variantMap.entrySet().stream()
                    .map(entry -> new ProductVariantDTO(entry.getKey(), entry.getValue()))
                    .toList();
        }

        // Finally, attach all the variants to the product DTO
        productWithVariantsDTO.setVariants(variantDTOs);
        return productWithVariantsDTO;
    }


    // --------------------- Filter Mappers ---------------------

    // Turns a list of CategoryFilterOption entities into FilterOptionDTOs
    public List<FilterOptionDTO> mapToDTOFilterOptions(List<CategoryFilterOption> cfos){
        List<FilterOptionDTO> filterOptionDTOList = new ArrayList<>();

        for(CategoryFilterOption cfo : cfos){
            FilterOptionDTO dto = new FilterOptionDTO(
                    cfo.getFilterOption().getFilterName(),
                    cfo.getFilterOption().getFilterValues()
                            .stream()
                            .map(FilterValue::getFiltervalueName)
                            .collect(Collectors.toList())
            );
            filterOptionDTOList.add(dto);
        }

        return filterOptionDTOList;
    }

    // --------------------- Shopping Cart Mappers ---------------------

    // Takes a ShoppingCart and its items, and maps it to a ShoppingCartDTO
    public ShoppingCartDTO mapToShoppingCartDTO(ShoppingCart cart, List<ShoppingCartItem> shoppingCartItems) {
        List<ShoppingCartItemDTO> itemDTOs = mapToShoppingCartItemDTOList(shoppingCartItems);
        return new ShoppingCartDTO(cart.getShoppingCartId(), itemDTOs);
    }

    // Converts each ShoppingCartItem into a ShoppingCartItemDTO
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

    // --------------------- User Mapper ---------------------

    // Converts a User entity into a clean UserDTO for frontend use.
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
