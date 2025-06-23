package com.pucminas.conectabh_service.usecase;

import com.pucminas.conectabh_service.controller.dto.UpdateReservationDto;
import com.pucminas.conectabh_service.controller.dto.WorkspaceReservationDto;
import com.pucminas.conectabh_service.controller.responses.ReservationResponse;
import com.pucminas.conectabh_service.domain.Reservation;
import com.pucminas.conectabh_service.utils.enums.ReservationStatus;

import java.util.List;

public interface ReservationUsecase {
    Reservation create(Reservation reservation) throws Exception;
    WorkspaceReservationDto getReservationsByWorkspaceId(Integer workspaceId);
    List<ReservationResponse> getByUserId(Integer userId);
    void update(Integer id, UpdateReservationDto updateReservationDto);
    void delete(Integer id);
    List<WorkspaceReservationDto> getWorkspaceReservations();

    void updateStatus(Integer id, ReservationStatus newStatus);
}
