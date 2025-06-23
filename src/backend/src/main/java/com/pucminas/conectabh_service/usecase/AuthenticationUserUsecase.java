package com.pucminas.conectabh_service.usecase;

import com.pucminas.conectabh_service.controller.dto.LoginUserDto;
import com.pucminas.conectabh_service.controller.dto.RegisterUserDto;
import com.pucminas.conectabh_service.controller.dto.UserDto;
import com.pucminas.conectabh_service.domain.User;

public interface AuthenticationUserUsecase {
    User signup(RegisterUserDto input);
    User authenticate(LoginUserDto input);
    UserDto getUserFromToken(String token);
}
