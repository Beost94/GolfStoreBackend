package com.GolfStore.backend.repository;

import com.GolfStore.backend.model.ShoppingCartItem;
import com.GolfStore.backend.model.ShoppingCartItemKey;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface ShoppingCartItemRepository extends JpaRepository<ShoppingCartItem, ShoppingCartItemKey> {
    List<ShoppingCartItem> findByShoppingCart_User_KeycloakId(UUID keycloakId);

}
