package com.GolfStore.backend.controller;
import com.GolfStore.backend.dto.UserDTOs.UserDTO;
import com.GolfStore.backend.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")


public class UserController {
    private final UserService userService;

    /*This endpoint was intentionally made to get user information that is stored in the database for the backend.
    But the user information was gathered from the token instead. So now this endpoint is primarily used to copy
    the user from keycloaks database, to the backends database.
    */
    @GetMapping
    @Operation(summary = "Gets user data", description = "Gets the users data. Additionally," +
            " if its the first time the user visits this endpoint, data is copied form keycloak " +
            "the database" )
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "User data successfully retrieved"),
            @ApiResponse(responseCode = "401", description = "Unauthorized, token missing or expired",
                    content = @Content(mediaType = "text/plain",
                    schema = @Schema(type = "string", example = "Unauthorized, friend"))),
            @ApiResponse(responseCode = "500", description = "Internal server error",
                    content = @Content(mediaType = "text/plain",
                    schema = @Schema(type = "string", example = "Internal server error")))
    })
    public ResponseEntity<UserDTO> getOrCreateUser(@AuthenticationPrincipal Jwt jwt) {
        UserDTO userDTO = userService.getOrCreateUser(jwt);
        return ResponseEntity.ok(userDTO);


    }


}








