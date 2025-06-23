package com.pucminas.conectabh_service.adapter.dtoToEntity;

import com.pucminas.conectabh_service.adapter.Adapter;
import com.pucminas.conectabh_service.controller.dto.WorkspaceDto;
import com.pucminas.conectabh_service.domain.Workspace;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class WorkspaceDtoToWorkspace implements Adapter<WorkspaceDto, Workspace> {
    @Override
    public Workspace convert(WorkspaceDto workspaceDto) {
        ModelMapper modelMapper = new ModelMapper();
        Workspace workspace = modelMapper.map(workspaceDto, Workspace.class);
        workspace.setCreatedAt(LocalDateTime.now());
        workspace.setUpdatedAt(LocalDateTime.now());
        return workspace;
    }
}
