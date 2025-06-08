package com.GolfStore.backend.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data


public class GetVariantDTO {
    Integer productId;
    String mainAttribute;
    String secondaryAttribute;
}
