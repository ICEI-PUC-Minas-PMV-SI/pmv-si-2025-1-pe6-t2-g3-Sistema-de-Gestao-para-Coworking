package com.pucminas.conectabh_service.repository;

import com.pucminas.conectabh_service.repository.data.WorkspaceData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WorkspaceRepository extends JpaRepository<WorkspaceData, Integer> {}
