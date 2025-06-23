package com.pucminas.conectabh_service.controller;

import com.pucminas.conectabh_service.controller.dto.*;
import com.pucminas.conectabh_service.controller.responses.LoginResponse;
import com.pucminas.conectabh_service.domain.User;
import com.pucminas.conectabh_service.exception.dto.ErrorResponse;
import com.pucminas.conectabh_service.exception.security.*;
import com.pucminas.conectabh_service.exception.service.*;
import com.pucminas.conectabh_service.security.JwtService;
import com.pucminas.conectabh_service.usecase.AuthenticationUserUsecase;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final JwtService jwtService;
    private final AuthenticationUserUsecase authenticationUserUsecase;

    @PostMapping("/login")
    public ResponseEntity<?> authenticate(@Valid @RequestBody LoginUserDto loginUserDto) {
        try {
            User authenticatedUser = authenticationUserUsecase.authenticate(loginUserDto);
            String jwtToken = jwtService.generateToken(authenticatedUser);

            return ResponseEntity.ok(LoginResponse.builder()
                    .token(jwtToken)
                    .expiresIn(jwtService.getExpirationTime())
                    .user(authenticationUserUsecase.getUserFromToken(jwtToken))
                    .build());
        } catch (UsernameNotFoundException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ErrorResponse("Usuário não encontrado", "AUTH-001"));
        } catch (InvalidCredentialsException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ErrorResponse("Credenciais inválidas", "AUTH-002"));
        }
    }

    @PostMapping("/signup")
    public ResponseEntity<?> register(@Valid @RequestBody RegisterUserDto registerUserDto) {
        try {
            User registeredUser = authenticationUserUsecase.signup(registerUserDto);

            return ResponseEntity.ok(registeredUser);
        } catch (UserAlreadyExistsException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(new ErrorResponse(e.getMessage(), "AUTH-003"));
        } catch (InvalidUserDataException e) {
            return ResponseEntity.badRequest()
                    .body(new ErrorResponse(e.getMessage(), "AUTH-004"));
        }
    }

    @GetMapping("/me")
    public ResponseEntity<?> getCurrentUser(@RequestHeader("Authorization") String authHeader) {
        try {
            if (authHeader == null || !authHeader.startsWith("Bearer ")) {
                throw new InvalidTokenException("Token não fornecido");
            }

            String token = authHeader.substring(7);
            return ResponseEntity.ok(authenticationUserUsecase.getUserFromToken(token));
        } catch (InvalidTokenException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ErrorResponse(e.getMessage(), "AUTH-005"));
        } catch (ExpiredTokenException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new ErrorResponse(e.getMessage(), "AUTH-006"));
        }
    }
}