package com.GolfStore.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GolfClubsDTO {
    private int productid;
    private String productname;
    private double price;
    private String description;
    private String gccategoryname;

}
