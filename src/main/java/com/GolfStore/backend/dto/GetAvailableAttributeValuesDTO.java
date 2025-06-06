package com.GolfStore.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class GetAvailableAttributeValuesDTO {

    String mainAttributeName;
    String secondaryAttributeName;
    List<String> mainAttribute;
    List<String> secondaryAttribute;


}
