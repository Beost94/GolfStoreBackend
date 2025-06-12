package com.GolfStore.backend.SpringSecurityConfig;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity // Let’s us lock down methods with @PreAuthorize and friends
public class SecurityConfig {

    // This is where we wire up the security rules
    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // Don’t need CSRF protection for stateless API
                .cors(cors -> {})             // Enables CORS using the bean below
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)) // No sessions; JWT all the way
                .authorizeHttpRequests(auth -> auth
                        // Public stuff — anyone can hit these
                        .requestMatchers("/", "/index.html", "/error", "/products/**",
                                "/swagger-ui.html", "/swagger-ui/**", "/v3/api-docs/**").permitAll()

                        // Only users with "USER" role can access these endpoints
                        .requestMatchers("/user/**", "/ShoppingCart/**").hasRole("USER")

                        // Only admins allowed here
                        .requestMatchers("/admin/**").hasRole("ADMIN")

                        // Anything else? You gotta be logged in
                        .anyRequest().authenticated()
                )
                // Hooking up the JWT converter so we can pull roles from the token
                .oauth2ResourceServer(oauth2 -> oauth2
                        .jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter()))
                );

        return http.build();
    }

    // Custom converter that grabs roles from Keycloak-style token structure
    @Bean
    JwtAuthenticationConverter jwtAuthenticationConverter() {
        JwtAuthenticationConverter converter = new JwtAuthenticationConverter();

        converter.setJwtGrantedAuthoritiesConverter(jwt -> {
            // Get roles from "realm_access" part of the token
            Map<String, Object> realm = jwt.getClaimAsMap("realm_access");
            if (realm == null || !realm.containsKey("roles")) {
                return List.of(); // No roles, no authorities
            }

            @SuppressWarnings("unchecked")
            Collection<String> roles = (Collection<String>) realm.get("roles");

            // Prefix with "ROLE_" so Spring can match them with hasRole()
            return roles.stream()
                    .map(role -> new SimpleGrantedAuthority("ROLE_" + role.toUpperCase()))
                    .collect(Collectors.toList());
        });

        return converter;
    }

    // Cors setup
    // Since the frontend needs to talk to this backend,
    // we open it up to accept requests from any origin, method, and header.
    // This makes local dev easier and removes CORS errors when calling the API from the browser.
    //
    // In production, one might want to lock this down to specific origins
    // to avoid abuse or unwanted exposure.
    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.addAllowedOriginPattern("*"); // Allow any origin
        config.addAllowedHeader("*");        // Allow all headers
        config.addAllowedMethod("*");        // Allow all HTTP methods
        config.setAllowCredentials(true);    // Include cookies or auth headers

        UrlBasedCorsConfigurationSource src = new UrlBasedCorsConfigurationSource();
        src.registerCorsConfiguration("/**", config); // Applies to all endpoints
        return src;
    }
}
