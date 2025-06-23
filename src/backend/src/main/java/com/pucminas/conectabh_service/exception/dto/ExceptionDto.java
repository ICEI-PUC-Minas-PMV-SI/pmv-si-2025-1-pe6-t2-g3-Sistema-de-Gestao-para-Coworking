package com.pucminas.conectabh_service.exception.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
public class ExceptionDto {
    private String message;
    private HttpStatus status;
    private LocalDateTime timestamp;
}
