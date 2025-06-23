package com.pucminas.conectabh_service.adapter.entityToData;

import com.pucminas.conectabh_service.adapter.Adapter;
import com.pucminas.conectabh_service.domain.Workspace;
import com.pucminas.conectabh_service.repository.data.WorkspaceData;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class WorkspaceToWorkspaceData implements Adapter<Workspace, WorkspaceData> {
    @Override
    public WorkspaceData convert(Workspace workspace) {
        ModelMapper modelMapper = new ModelMapper();
        return modelMapper.map(workspace, WorkspaceData.class);
    }
}
