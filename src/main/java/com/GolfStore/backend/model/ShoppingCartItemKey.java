package com.GolfStore.backend.model;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class ShoppingCartItemKey implements Serializable {
    private Integer shoppingCartId;
    private Integer productVariantId;
}


/*Fra JPA specifications i kapittelet om  sammensatte nøkler og embeddable:
 "The equals and hashCode methods must be implemented
  consistent with the database primary key equality."
Det kan tydeligvis bli krøll hvis man ikke overskriver disse metodene, så derfor er disse overskrevet.
 */


