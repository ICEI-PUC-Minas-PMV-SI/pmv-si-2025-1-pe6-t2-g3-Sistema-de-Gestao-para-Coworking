package com.pucminas.conectabh_service.domain;

import com.pucminas.conectabh_service.utils.enums.WorkspaceStatus;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class Workspace {
    private Integer id;
    private String name;
    private Integer capacity;
    private String location;
    private WorkspaceStatus status;
    private LocalDateTime updatedAt;
    private LocalDateTime createdAt;
}
