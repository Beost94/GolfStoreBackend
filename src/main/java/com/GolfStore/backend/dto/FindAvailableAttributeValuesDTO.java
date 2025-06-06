package com.GolfStore.backend.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class FindAvailableAttributeValuesDTO {

    Integer productId;
    List<String> mainAttribute;

}
