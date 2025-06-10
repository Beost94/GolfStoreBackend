package com.GolfStore.backend.service;

import com.GolfStore.backend.DTOMapper.DTOMapper;
import com.GolfStore.backend.dto.CartDTOs.ShoppingCartDTO;
import com.GolfStore.backend.dto.CartDTOs.UpdateCartItemRequest;
import com.GolfStore.backend.model.*;
import com.GolfStore.backend.repository.ShoppingCartItemRepository;
import com.GolfStore.backend.repository.StockRepository;
import com.GolfStore.backend.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ShoppingCartService {

    private final ShoppingCartItemRepository shoppingCartItemRepository;
    private final UserRepository userRepository;
    private final StockRepository stockRepository;
    private final DTOMapper dtoMapper;

    public ShoppingCartDTO getShoppingCart(UUID keycloakId) {
        User user = userRepository.findById(keycloakId)
                .orElseThrow(() -> new EntityNotFoundException("User not found with given ID"));

        ShoppingCart cart = user.getShoppingCart();
        if (cart == null) {
            throw new EntityNotFoundException("No Shoppingcart registered to that user");
        }

        List<ShoppingCartItem> items = shoppingCartItemRepository.findByShoppingCart_User_KeycloakId(keycloakId);
        return dtoMapper.mapToShoppingCartDTO(cart, items);
    }

    public void updateCartItem(UUID keycloakId, UpdateCartItemRequest request) {
        User user = userRepository.findById(keycloakId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        ShoppingCart shoppingCart = user.getShoppingCart();
        ShoppingCartItemKey itemKey = new ShoppingCartItemKey(shoppingCart.getShoppingCartId(), request.getVariantId());
        ShoppingCartItem item = shoppingCartItemRepository.findById(itemKey).orElse(null);

        if (item == null && request.getAction().equalsIgnoreCase("add")) {
            ProductVariant variant = new ProductVariant();
            variant.setVariantId(request.getVariantId());

            ShoppingCartItem newItem = new ShoppingCartItem();
            newItem.setId(itemKey);
            newItem.setShoppingCart(shoppingCart);
            newItem.setProductVariant(variant);
            newItem.setAmount(1);
            shoppingCartItemRepository.save(newItem);

        } else if (item != null) {
            if (request.getAction().equalsIgnoreCase("add")) {
                Integer maxAmount = stockRepository.findStockCountByVariantId(request.getVariantId());
                if (maxAmount != null && maxAmount > item.getAmount()) {
                    item.setAmount(item.getAmount() + 1);
                    shoppingCartItemRepository.save(item);
                }

            } else if (request.getAction().equalsIgnoreCase("subtract")) {
                int updatedAmount = item.getAmount() - 1;
                if (updatedAmount > 0) {
                    item.setAmount(updatedAmount);
                    shoppingCartItemRepository.save(item);
                } else {
                    shoppingCartItemRepository.delete(item);
                }
            } else if (request.getAction().equalsIgnoreCase("delete")) {
                shoppingCartItemRepository.delete(item);
            }
        }
    }
}