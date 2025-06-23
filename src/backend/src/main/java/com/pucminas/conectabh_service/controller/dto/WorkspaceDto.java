package com.pucminas.conectabh_service.controller.dto;

import com.pucminas.conectabh_service.utils.enums.WorkspaceStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class WorkspaceDto {
    private Integer workspaceId;
    private String name;
    private Integer capacity;
    private String location;
    private WorkspaceStatus status;
}
