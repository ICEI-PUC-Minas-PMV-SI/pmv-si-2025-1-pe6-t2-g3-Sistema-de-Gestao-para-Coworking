package com.pucminas.conectabh_service.controller.responses;

import com.pucminas.conectabh_service.controller.dto.UserDto;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Schema(description = "Resposta de autenticação contendo token JWT e informações do usuário")
public class LoginResponse {
    @Schema(description = "Token JWT para autenticação", example = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...")
    private String token;

    @Schema(description = "Tempo de expiração do token em milissegundos", example = "86400000")
    private Long expiresIn;

    @Schema(description = "Informações básicas do usuário autenticado")
    private UserDto user;

    @Schema(description = "Tipo do token", example = "Bearer")
    @Builder.Default
    private String tokenType = "Bearer";

    // Método estático para construção facilitada
    public static LoginResponse of(String token, Long expiresIn, UserDto user) {
        return LoginResponse.builder()
                .token(token)
                .expiresIn(expiresIn)
                .user(user)
                .build();
    }
}