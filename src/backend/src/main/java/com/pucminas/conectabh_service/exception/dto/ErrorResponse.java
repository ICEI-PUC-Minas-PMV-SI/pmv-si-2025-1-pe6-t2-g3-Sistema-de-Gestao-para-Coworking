package com.pucminas.conectabh_service.exception.dto;

import java.time.LocalDateTime;

public record ErrorResponse(
        LocalDateTime timestamp,
        int status,
        String error,
        String message,
        String path,
        String errorCode
) {
    public ErrorResponse(int status, String error, String message, String path, String errorCode) {
        this(LocalDateTime.now(), status, error, message, path, errorCode);
    }

    public ErrorResponse(String message, String errorCode) {
        this(0, "", message, "", errorCode);
    }
}