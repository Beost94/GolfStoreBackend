package com.GolfStore.backend.dto.UserDTOs;


import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
    @Schema(description = "Users Keycloak ID", example = "3f2504e0-4f89-11d3-9a0c-0305e82c3301")
    private UUID keyCloakId;

    @Schema(description = "First name of the user", example = "Jonas")
    private String firstname;

    @Schema(description = "Last name of the user", example = "Dingeling")
    private String lastname;

    @Schema(description = "Email address of the user", example = "Jonas@dingeling.com")
    private String email;

    @Schema(description = "Shipping address", example = "adresseland 123")
    private String address;

    @Schema(description = "Phone number", example = "12345678")

    private String phone;
}
