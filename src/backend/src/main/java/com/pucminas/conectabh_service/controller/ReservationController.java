package com.pucminas.conectabh_service.controller;

import com.pucminas.conectabh_service.adapter.dtoToEntity.ReservationDtoToReservation;
import com.pucminas.conectabh_service.controller.dto.ReservationDto;
import com.pucminas.conectabh_service.controller.dto.UpdateReservationDto;
import com.pucminas.conectabh_service.controller.dto.WorkspaceReservationDto;
import com.pucminas.conectabh_service.controller.responses.ReservationResponse;
import com.pucminas.conectabh_service.domain.Reservation;
import com.pucminas.conectabh_service.repository.data.ReservationData;
import com.pucminas.conectabh_service.usecase.ReservationUsecase;
import com.pucminas.conectabh_service.utils.enums.ReservationStatus;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RequestMapping("/reservation")
@RestController
public class ReservationController {
    @Autowired
    ReservationUsecase reservationUsecase;
    @Autowired
    ReservationDtoToReservation adapter;

    @PostMapping("/create")
    public ResponseEntity<Reservation> createReservation(@RequestBody ReservationDto reservationDto) throws Exception {
        Reservation createdReservation = reservationUsecase.create(adapter.convert(reservationDto));
        return ResponseEntity.ok(createdReservation);
    }

    @DeleteMapping("/{id}")
    public void deleteReservation(@PathVariable Integer id) {
        reservationUsecase.delete(id);
    }

    @PatchMapping("/{id}/cancel")
    public ResponseEntity<?> cancelReservation(@PathVariable Integer id) {
        try {
            reservationUsecase.updateStatus(id, ReservationStatus.CANCELLED);
            return ResponseEntity.ok().build();
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }


    @GetMapping("/{workspaceId}")
    public ResponseEntity<WorkspaceReservationDto> getReservationsByWorkspaceId(@PathVariable Integer workspaceId) {
        return ResponseEntity.ok(reservationUsecase.getReservationsByWorkspaceId(workspaceId));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<ReservationResponse>> getReservationsByUser(@PathVariable Integer userId) {
        System.out.println("Fetching reservations for user: " + userId);
        List<ReservationResponse> reservations = reservationUsecase.getByUserId(userId);
        System.out.println("Reservations found: " + reservations.size());
        reservations.forEach(r -> System.out.println(r.toString()));
        return ResponseEntity.ok(reservations);
    }

    @PutMapping("/{id}")
    public void updateReservation(@PathVariable Integer id, @RequestBody UpdateReservationDto updateReservationDto) {
        reservationUsecase.update(id, updateReservationDto);
    }

    @GetMapping
    public ResponseEntity<List<WorkspaceReservationDto>> getReservationsByWorkspace() {
        return ResponseEntity.ok(reservationUsecase.getWorkspaceReservations());
    }
}
