package com.jd.authentication.repositories;

import org.springframework.data.repository.CrudRepository;

import com.jd.authentication.models.Message;

public interface MessageRepository extends CrudRepository<Message, Long> {

}
