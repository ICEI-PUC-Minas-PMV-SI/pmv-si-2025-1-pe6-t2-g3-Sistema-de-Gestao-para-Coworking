package com.pucminas.conectabh_service.controller.dto;

import com.pucminas.conectabh_service.utils.enums.ReservationStatus;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class UpdateReservationDto {
    private LocalDate reservationDate;
    private ReservationStatus status;
}
