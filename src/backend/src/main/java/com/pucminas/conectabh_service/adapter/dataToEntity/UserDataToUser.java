package com.pucminas.conectabh_service.adapter.dataToEntity;

import com.pucminas.conectabh_service.adapter.Adapter;
import com.pucminas.conectabh_service.domain.User;
import com.pucminas.conectabh_service.repository.data.UserData;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class UserDataToUser implements Adapter<UserData, User> {

    @Override
    public User convert(UserData userData) {
        ModelMapper modelMapper = new ModelMapper();
        return modelMapper.map(userData, User.class);
    }
}
