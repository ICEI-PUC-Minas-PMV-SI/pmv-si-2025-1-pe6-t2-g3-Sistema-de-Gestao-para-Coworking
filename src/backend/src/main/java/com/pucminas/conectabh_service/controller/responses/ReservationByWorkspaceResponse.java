package com.pucminas.conectabh_service.controller.responses;

import com.pucminas.conectabh_service.controller.dto.WorkspaceDto;
import com.pucminas.conectabh_service.utils.enums.ReservationStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReservationByWorkspaceResponse {
    private Integer id;
    private WorkspaceDto workspace;
    private List<LocalDate> reservationsDate;
    private ReservationStatus status;
}
