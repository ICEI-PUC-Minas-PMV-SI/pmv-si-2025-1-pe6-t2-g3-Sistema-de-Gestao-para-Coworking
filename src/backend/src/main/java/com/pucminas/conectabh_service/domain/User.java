package com.pucminas.conectabh_service.domain;

import com.pucminas.conectabh_service.utils.enums.RoleType;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
public class User {
    private Integer id;
    private String fullName;
    private String email;
    private String password;
    private String role;
}
