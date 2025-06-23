package com.pucminas.conectabh_service.adapter.dataToEntity;

import com.pucminas.conectabh_service.adapter.Adapter;
import com.pucminas.conectabh_service.domain.Workspace;
import com.pucminas.conectabh_service.repository.data.WorkspaceData;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class WorkspaceDataToWorkspace implements Adapter<WorkspaceData, Workspace> {
    @Override
    public Workspace convert(WorkspaceData workspaceData) {
        ModelMapper modelMapper = new ModelMapper();
        return modelMapper.map(workspaceData, Workspace.class);
    }
}
