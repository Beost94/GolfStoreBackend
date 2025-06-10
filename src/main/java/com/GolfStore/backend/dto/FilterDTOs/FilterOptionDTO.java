package com.GolfStore.backend.dto.FilterDTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class FilterOptionDTO {
    private String filterOption;
    private List<String> filterValues;

}
