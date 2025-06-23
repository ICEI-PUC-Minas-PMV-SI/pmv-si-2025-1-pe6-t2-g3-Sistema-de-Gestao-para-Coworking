package com.pucminas.conectabh_service.adapter.dtoToEntity;

import com.pucminas.conectabh_service.adapter.Adapter;
import com.pucminas.conectabh_service.adapter.dataToEntity.UserDataToUser;
import com.pucminas.conectabh_service.adapter.dataToEntity.WorkspaceDataToWorkspace;
import com.pucminas.conectabh_service.controller.dto.ReservationDto;
import com.pucminas.conectabh_service.domain.Reservation;
import com.pucminas.conectabh_service.repository.UserRepository;
import com.pucminas.conectabh_service.repository.WorkspaceRepository;
import com.pucminas.conectabh_service.repository.data.UserData;
import com.pucminas.conectabh_service.repository.data.WorkspaceData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ReservationDtoToReservation implements Adapter<ReservationDto, Reservation> {
    @Autowired
    WorkspaceRepository workspaceRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    UserDataToUser userDataToUser;
    @Autowired
    WorkspaceDataToWorkspace workspaceDataToWorkspace;

    @Override
    public Reservation convert(ReservationDto reservationDto) {
        WorkspaceData workspace = workspaceRepository.findById(reservationDto.getWorkspaceId())
                .orElseThrow(() -> new RuntimeException("Workspace not found."));
        UserData user = userRepository.findById(reservationDto.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found. "));
        

        Reservation reservation = new Reservation();
        reservation.setUser(userDataToUser.convert(user));
        reservation.setWorkspace(workspaceDataToWorkspace.convert(workspace));
        reservation.setReservationDate(reservationDto.getReservationDate());
        reservation.setStatus(reservationDto.getStatus());

        return reservation;
    }
}
