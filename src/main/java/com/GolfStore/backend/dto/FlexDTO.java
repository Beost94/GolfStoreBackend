package com.GolfStore.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FlexDTO {
    private int flexid;
    private String flexname;
    private List<String> lofts;
}
