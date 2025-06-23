package com.pucminas.conectabh_service.controller.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class WorkspaceReservationDto {
    private Integer workspaceId;
    private List<LocalDate> reservedDates;
}
