package com.pucminas.conectabh_service.usecase;

import com.pucminas.conectabh_service.domain.Workspace;

import java.util.List;

public interface WorkspaceUsecase {
    void create(Workspace workspace);
    Workspace get(Integer id);
    List<Workspace> getAll();
    void update(Integer id, Workspace workspace);
    void delete(Integer id);
}
