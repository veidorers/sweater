package com.example.sweater.repositories;

import com.example.sweater.domain.Message;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageRepository extends CrudRepository<Message, Integer > {
    List<Message> findByTag(String tag);
}
