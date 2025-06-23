package com.pucminas.conectabh_service.exception;

import com.pucminas.conectabh_service.exception.dto.ErrorResponse;
import com.pucminas.conectabh_service.exception.security.*;
import com.pucminas.conectabh_service.exception.service.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ApiExceptionHandler {

    @ExceptionHandler({
            InvalidCredentialsException.class,
            UnauthorizedAccessException.class
    })
    public ResponseEntity<ErrorResponse> handleUnauthorized(RuntimeException ex, HttpServletRequest request) {
        return buildResponse(HttpStatus.UNAUTHORIZED, "AUTH-001", ex, request);
    }



    @ExceptionHandler({
            UserAlreadyExistsException.class
    })
    public ResponseEntity<ErrorResponse> handleConflict(RuntimeException ex, HttpServletRequest request) {
        return buildResponse(HttpStatus.CONFLICT, "CONFLICT-001", ex, request);
    }

    @ExceptionHandler({
            InvalidUserDataException.class
    })
    public ResponseEntity<ErrorResponse> handleBadRequest(RuntimeException ex, HttpServletRequest request) {
        return buildResponse(HttpStatus.BAD_REQUEST, "VALIDATION-001", ex, request);
    }

    @ExceptionHandler({
            ExpiredTokenException.class,
            InvalidTokenException.class
    })
    public ResponseEntity<ErrorResponse> handleTokenErrors(RuntimeException ex, HttpServletRequest request) {
        return buildResponse(HttpStatus.FORBIDDEN, "TOKEN-001", ex, request);
    }

    private ResponseEntity<ErrorResponse> buildResponse(HttpStatus status, String errorCode,
                                                        RuntimeException ex, HttpServletRequest request) {
        ErrorResponse errorResponse = new ErrorResponse(
                status.value(),
                status.getReasonPhrase(),
                ex.getMessage(),
                request.getRequestURI(),
                errorCode
        );

        return ResponseEntity.status(status).body(errorResponse);
    }
}