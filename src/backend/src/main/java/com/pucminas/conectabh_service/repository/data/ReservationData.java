package com.pucminas.conectabh_service.repository.data;

import com.pucminas.conectabh_service.utils.enums.ReservationStatus;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@DynamicUpdate
@Table(name = "reservation")
public class ReservationData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reservation_id")
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "workspace_id")
    private WorkspaceData workspace;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserData user;
    @Column(name = "reservation_date")
    private LocalDate reservationDate;
    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private ReservationStatus status;
    @Column(name = "created_at")
    @CreationTimestamp
    private LocalDateTime createdAt;
}
