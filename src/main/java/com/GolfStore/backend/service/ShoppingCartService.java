package com.GolfStore.backend.service;

import com.GolfStore.backend.dto.ShoppingCartDTO;
import com.GolfStore.backend.dto.ShoppingCartItemDTO;
import com.GolfStore.backend.dto.UpdateCartItemRequest;
import com.GolfStore.backend.model.*;
import com.GolfStore.backend.repository.ProductRepository;
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
    private final ProductRepository productRepository;


    public ShoppingCartDTO getShoppingCart(UUID keycloakId){
        User user = userRepository.findById(keycloakId).orElse(null);
        ShoppingCart cart = user.getShoppingCart();

        List<ShoppingCartItem> items = shoppingCartItemRepository.findByShoppingCart_User_KeycloakId(keycloakId);

        return convertToShoppingCartDTO(cart,items);
    }

    public ShoppingCartDTO convertToShoppingCartDTO(ShoppingCart cart, List<ShoppingCartItem> shoppingCartItems) {
        List<ShoppingCartItemDTO> itemDTOs = convertToShoppingCartItemDTO(shoppingCartItems);
        return new ShoppingCartDTO(cart.getShoppingCartId(), itemDTOs);
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

    public void updateCartItem(UUID keycloakId, UpdateCartItemRequest request) {

        🚦 Neste steg:

        Nå kan du bruke stockRepository.findStockCountByVariantId(variantId) direkte i updateCartItem(...) for å sammenligne mot amount.

        Vil du at vi bygger inn den sjekken nå i "add"-blokken?



        User user = userRepository.findById(keycloakId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        ShoppingCart shoppingCart = user.getShoppingCart();
        ShoppingCartItemKey itemKey = new ShoppingCartItemKey(shoppingCart.getShoppingCartId(), request.getVariantId());
        ShoppingCartItem item = shoppingCartItemRepository.findById(itemKey).orElse(null);

        if (item == null && request.getAction().equalsIgnoreCase("add")) {
            // Opprett ny vare i handlekurven
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
                item.setAmount(item.getAmount() + 1);
                shoppingCartItemRepository.save(item);
            } else if (request.getAction().equalsIgnoreCase("subtract")) {
                int updatedAmount = item.getAmount() - 1;
                if (updatedAmount > 0) {
                    item.setAmount(updatedAmount);
                    shoppingCartItemRepository.save(item);
                } else {
                    shoppingCartItemRepository.delete(item);
                }
            }
        }
    }






    }

    /* 1. Bruker trykker på legg til produkt. Sender en request til endpointet post request i controller.
       1.1 - Dette sender da variantId og token. Controller kaller da en metode i service layer med variantid
       på produktet som skal legges til, og en token som forteller hvilken brukers handlekurv dette skal legges til i.
       Service må da finne riktig handlekurv, sende riktig produkt og kalle repository som legger til en post i shoppingcartitems.

       2. */



