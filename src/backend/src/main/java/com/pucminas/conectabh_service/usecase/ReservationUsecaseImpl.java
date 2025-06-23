package com.pucminas.conectabh_service.usecase;

import com.pucminas.conectabh_service.adapter.dataToEntity.ReservationDataToReservation;
import com.pucminas.conectabh_service.adapter.entityToData.ReservationToReservationData;
import com.pucminas.conectabh_service.controller.dto.UpdateReservationDto;
import com.pucminas.conectabh_service.controller.dto.WorkspaceDto;
import com.pucminas.conectabh_service.controller.dto.WorkspaceReservationDto;
import com.pucminas.conectabh_service.controller.responses.ReservationResponse;
import com.pucminas.conectabh_service.domain.Reservation;
import com.pucminas.conectabh_service.repository.ReservationRepository;
import com.pucminas.conectabh_service.repository.data.ReservationData;
import com.pucminas.conectabh_service.repository.data.WorkspaceData;
import com.pucminas.conectabh_service.utils.enums.ReservationStatus;
import com.pucminas.conectabh_service.utils.enums.WorkspaceStatus;
import jakarta.persistence.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ReservationUsecaseImpl implements ReservationUsecase {
    @Autowired
    ReservationRepository reservationRepository;
    @Autowired
    ReservationToReservationData reservationToReservationData;
    @Autowired
    ReservationDataToReservation reservationDataToReservation;

    private static final Logger logger = LoggerFactory.getLogger(ReservationUsecaseImpl.class);
    
    @Override
    public Reservation create(Reservation reservation) throws Exception {
        Integer workspaceId = reservation.getWorkspace().getId();
        LocalDate targetDate = reservation.getReservationDate();

        List<ReservationData> existingReservations = reservationRepository
                .findByWorkspaceIdAndStatus(workspaceId, ReservationStatus.CONFIRMED);
        boolean existsSameDay = existingReservations.stream()
                .anyMatch(r -> r.getReservationDate().equals(targetDate));

        if (existsSameDay) {
            logger.error("There is already a confirmed reservation for this date. Cannot create the reservation");
            throw new Exception("There is already a confirmed reservation for this date. Cannot create the reservation");
        }

        if (!reservation.getWorkspace().getStatus().equals(WorkspaceStatus.AVAILABLE)) {
            reservation.setStatus(ReservationStatus.CANCELLED);
            logger.error("Workspace is not available for reservation.");
            throw new Exception("Workspace is not available for reservation.");
        }
        reservation.setStatus(ReservationStatus.CONFIRMED);
        reservation.getWorkspace().setStatus(WorkspaceStatus.RESERVED);
        reservationRepository.save(reservationToReservationData.convert(reservation));
        logger.info("Reservation create with success!");
        return reservation;
    }

    @Override
    public WorkspaceReservationDto getReservationsByWorkspaceId(Integer workspaceId) {
        List<Object[]> rawData = reservationRepository.findConfirmedReservationDatesByWorkspaceId(workspaceId);

        List<LocalDate> reservationDates = rawData.stream()
                .map(row -> (LocalDate) row[1])
                .toList();

        if (reservationDates.isEmpty()) {
            throw new EntityNotFoundException("No reservations found for workspace id: " + workspaceId);
        }

        return new WorkspaceReservationDto(workspaceId, reservationDates);
    }

    @Override
    public List<ReservationResponse> getByUserId(Integer userId) {
        List<ReservationData> entities = reservationRepository.findUpcomingReservationsByUserId(userId);

        return entities.stream().map(entity -> {
            WorkspaceData workspace = entity.getWorkspace();
            WorkspaceDto workspaceDTO = new WorkspaceDto(workspace.getId(), workspace.getName(), workspace.getId(), workspace.getLocation(), workspace.getStatus());

            return new ReservationResponse(
                    entity.getId(),
                    workspaceDTO,
                    entity.getReservationDate(),
                    entity.getStatus()
            );
        }).collect(Collectors.toList());
    }

    @Override
    public void update(Integer id, UpdateReservationDto newReservation) {
        ReservationData savedReservation = reservationRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Reservation not found for id: " + id));

        Integer workspaceId = savedReservation.getWorkspace().getId();
        LocalDate newDate = newReservation.getReservationDate();

        List<ReservationData> existingReservations = reservationRepository
                .findByWorkspaceIdAndStatus(workspaceId, ReservationStatus.CONFIRMED);

        boolean conflict = existingReservations.stream()
                .anyMatch(r -> !r.getId().equals(id) &&
                        r.getReservationDate().equals(newDate));

        if (conflict) {
            logger.error("There is already a confirmed reservation for this date. Cannot update the reservation");
            throw new IllegalStateException("There is already a confirmed reservation for this date. Cannot update the reservation");
        }

        savedReservation.setReservationDate(newReservation.getReservationDate());
        savedReservation.setStatus(ReservationStatus.CONFIRMED);

        reservationRepository.save(savedReservation);
    }

    @Override
    public void delete(Integer id) {
        ReservationData reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Reservation not found for id: " + id));
        reservationRepository.delete(reservation);
        logger.info("Deleted the reservation: {}", id);
    }

    @Override
    public List<WorkspaceReservationDto> getWorkspaceReservations() {
        List<Object[]> rawData = reservationRepository.findConfirmedReservationDatesByWorkspace();

        Map<Integer, List<LocalDate>> grouped = new HashMap<>();

        for (Object[] row : rawData) {
            Integer workspaceId = (Integer) row[0];
            LocalDate date = (LocalDate) row[1];

            grouped.computeIfAbsent(workspaceId, k -> new ArrayList<>()).add(date);
        }

        return grouped.entrySet().stream()
                .map(entry -> new WorkspaceReservationDto(entry.getKey(), entry.getValue()))
                .toList();
    }

    @Override
    public void updateStatus(Integer id, ReservationStatus newStatus) {
        ReservationData reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Reserva não encontrada com ID: " + id));

        // Validações adicionais se necessário
        if (reservation.getStatus() == newStatus) {
            logger.warn("O status da reserva {} já é {}", id, newStatus);
            return;
        }

        // Lógica específica para cancelamento
        if (newStatus == ReservationStatus.CANCELLED) {
            reservation.getWorkspace().setStatus(WorkspaceStatus.AVAILABLE);
            logger.info("Workspace {} liberado devido ao cancelamento",
                    reservation.getWorkspace().getId());
        }

        reservation.setStatus(newStatus);
        reservationRepository.save(reservation);
        logger.info("Status da reserva {} atualizado para {}", id, newStatus);
    }

}
