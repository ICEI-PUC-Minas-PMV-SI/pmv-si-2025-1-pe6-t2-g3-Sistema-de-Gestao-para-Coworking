package com.pucminas.conectabh_service.adapter.entityToData;

import com.pucminas.conectabh_service.adapter.Adapter;
import com.pucminas.conectabh_service.domain.User;
import com.pucminas.conectabh_service.repository.data.UserData;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class UserToUserData implements Adapter<User, UserData> {
    @Override
    public UserData convert(User user) {
        ModelMapper modelMapper = new ModelMapper();
        return modelMapper.map(user, UserData.class);
    }
}
