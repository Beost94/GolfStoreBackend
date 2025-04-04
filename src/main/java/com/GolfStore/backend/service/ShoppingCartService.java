package com.GolfStore.backend.service;

import com.GolfStore.backend.dto.ShoppingCartDTO;
import com.GolfStore.backend.dto.ShoppingCartItemDTO;
import com.GolfStore.backend.model.*;
import com.GolfStore.backend.repository.ShoppingCartItemRepository;
import com.GolfStore.backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ShoppingCartService {

    private final ShoppingCartItemRepository shoppingCartItemRepository;
    private final UserRepository userRepository;


    public ShoppingCartDTO getShoppingCart(UUID keycloakId){
        User user = userRepository.findById(keycloakId).orElse(null);
        ShoppingCart cart = user.getShoppingCart();

        List<ShoppingCartItem> items = shoppingCartItemRepository.findByShoppingCart_User_KeycloakId(keycloakId);

        return convertToShoppingCartDTO(cart,items);
    }

    public List <ShoppingCartItemDTO> convertToShoppingCartItemDTO(List<ShoppingCartItem> shoppingCartItems){
        List <ShoppingCartItemDTO> shoppingCartItemDTOS = new ArrayList<>();
        for (ShoppingCartItem item : shoppingCartItems) {
            ProductVariant variant = item.getProductVariant();
            Product product = variant.getProduct();

            shoppingCartItemDTOS.add(new ShoppingCartItemDTO(
                    product.getProductId(),
                    variant.getVariantId(),
                    product.getProductName(),
                    product.getPrice()
            ));
        }
        return shoppingCartItemDTOS;
    }

    public ShoppingCartDTO convertToShoppingCartDTO(ShoppingCart cart, List<ShoppingCartItem> shoppingCartItems) {
        return new ShoppingCartDTO(
                cart.getShoppingCartId(),
                convertToShoppingCartItemDTO(shoppingCartItems)
        );
    }


}
