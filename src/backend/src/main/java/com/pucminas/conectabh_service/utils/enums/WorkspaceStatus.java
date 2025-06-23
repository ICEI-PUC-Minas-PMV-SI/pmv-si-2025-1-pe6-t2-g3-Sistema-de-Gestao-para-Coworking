package com.pucminas.conectabh_service.utils.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum     WorkspaceStatus {
    AVAILABLE("AVAILABLE"),
    RESERVED("RESERVED");

    private final String status;
}
