package com.pucminas.conectabh_service.controller.responses;

import com.pucminas.conectabh_service.controller.dto.WorkspaceDto;
import com.pucminas.conectabh_service.utils.enums.ReservationStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReservationResponse {
    private Integer id;
    private WorkspaceDto workspace;
    private LocalDate reservationDate;
    private ReservationStatus status;
}
