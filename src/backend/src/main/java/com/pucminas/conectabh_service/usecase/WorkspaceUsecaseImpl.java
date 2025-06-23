package com.pucminas.conectabh_service.usecase;

import com.pucminas.conectabh_service.adapter.dataToEntity.WorkspaceDataToWorkspace;
import com.pucminas.conectabh_service.adapter.entityToData.WorkspaceToWorkspaceData;
import com.pucminas.conectabh_service.domain.Workspace;
import com.pucminas.conectabh_service.repository.WorkspaceRepository;
import com.pucminas.conectabh_service.repository.data.WorkspaceData;
import jakarta.persistence.EntityNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class WorkspaceUsecaseImpl implements WorkspaceUsecase {
    @Autowired
    WorkspaceRepository workspaceRepository;
    @Autowired
    WorkspaceToWorkspaceData entityToData;
    @Autowired
    WorkspaceDataToWorkspace dataToEntity;

    private static final Logger logger = LoggerFactory.getLogger(WorkspaceUsecaseImpl.class);

    @Override
    public void create(Workspace workspace) {
        try {
            workspaceRepository.save(entityToData.convert(workspace));
            logger.info("Workspace {} created with success.", workspace.getName());
        } catch (Exception e) {
            logger.error("Error on create workspace {}. err: {}", workspace.getCreatedAt(), e.getMessage());
        }
    }

    @Override
    public Workspace get(Integer id) {
        return dataToEntity.convert(workspaceRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Workspace not found for id: " + id)));
    }

    @Override
    public List<Workspace> getAll() {
        return dataToEntity.convert(workspaceRepository.findAll());
    }

    @Override
    public void update(Integer id, Workspace workspace) {
        try {
            WorkspaceData savedWorkspace = workspaceRepository.getReferenceById(id);
            savedWorkspace.setName(workspace.getName());
            savedWorkspace.setCapacity(workspace.getCapacity());
            savedWorkspace.setLocation(workspace.getLocation());
            savedWorkspace.setUpdatedAt(LocalDateTime.now());

            workspaceRepository.save(savedWorkspace);
            logger.info("Updated the workspace {} with success.", id);
        } catch(Exception e) {
            logger.error("Error on update the workspace: {}. err: {}", id, e.getMessage());
        }
    }

    @Override
    public void delete(Integer id) {
        try {
            workspaceRepository.deleteById(id);
            logger.info("Deleted the workspace {} with success.", id);
        } catch (Exception e) {
            logger.error("Error on delete the workspace: {}. err: {}", id, e.getMessage());
        }
    }
}
