package com.pucminas.conectabh_service.utils.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ReservationStatus {
    PENDING("PENDING"),
    CANCELLED("CANCELLED"),
    CONFIRMED("CONFIRMED");

    private final String status;
}
