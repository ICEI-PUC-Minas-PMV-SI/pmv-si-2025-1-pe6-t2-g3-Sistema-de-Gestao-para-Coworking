package com.pucminas.conectabh_service.controller.dto;

import com.pucminas.conectabh_service.utils.enums.RoleType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDto {
    private Integer id;
    private String fullName;
    private String email;
    private RoleType role;
}
