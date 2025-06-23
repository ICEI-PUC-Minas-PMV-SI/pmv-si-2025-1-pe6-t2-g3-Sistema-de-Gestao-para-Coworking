package com.pucminas.conectabh_service.adapter.dataToEntity;

import com.pucminas.conectabh_service.adapter.Adapter;
import com.pucminas.conectabh_service.domain.Reservation;
import com.pucminas.conectabh_service.repository.data.ReservationData;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class ReservationDataToReservation implements Adapter<ReservationData, Reservation> {
    @Override
    public Reservation convert(ReservationData reservationData) {
        ModelMapper modelMapper = new ModelMapper();
        return modelMapper.map(reservationData, Reservation.class);
    }
}
