package com.GolfStore.backend.dto.FilterDTOs;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class FilterOptionDTO {
    @Schema(description = "Name of the filter option (e.g., brand, size)", example = "Brand")
    private String filterOption;

    @Schema(description = "Possible values for this filter", example = "[\"Callaway\", \"TaylorMade\"]")
    private List<String> filterValues;


}
