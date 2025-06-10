package com.GolfStore.backend.dto.UserDTOs;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {
    private UUID keyCloakId;
    private String firstname;
    private String lastname;
    private String email;
    private String address;
    private String phone;

}
