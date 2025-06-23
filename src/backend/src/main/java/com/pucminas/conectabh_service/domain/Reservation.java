package com.pucminas.conectabh_service.domain;

import com.pucminas.conectabh_service.utils.enums.ReservationStatus;
import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class Reservation {
    private Integer id;
    private Workspace workspace;
    private User user;
    private LocalDate reservationDate;
    private ReservationStatus status;
}
