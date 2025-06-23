package com.pucminas.conectabh_service.repository;

import com.pucminas.conectabh_service.repository.data.UserData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserData, Integer> {
    Optional<UserData> findByEmail(String email);
}
