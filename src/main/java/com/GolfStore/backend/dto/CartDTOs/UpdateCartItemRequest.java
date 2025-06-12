package com.GolfStore.backend.dto.CartDTOs;

import com.GolfStore.backend.annotations.ActionConstraint;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "A DTO sending the ID of a variant to be either added or removed from the shoppingcart")
public class UpdateCartItemRequest {


    private Integer productId;
    @Schema(description = "Variant ID of the selected variant", example = "123")
    @NotNull
    private Integer variantId;
    @Schema(description = "Action to be performed on the variant ID in the shoppingcart." , examples = {"Add","Subtract","Delete"})

    //Custom constraint to ensure values are either "add", "subtract" or "delete"
    @ActionConstraint
    private String action;


}
