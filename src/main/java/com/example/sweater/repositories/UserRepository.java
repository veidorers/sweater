package com.example.sweater.repositories;

import com.example.sweater.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByActivationCode(String code);


    User findByUsername(String username);

    User findByEmail(String email);
}
