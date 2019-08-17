package com.jd.authentication.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.jd.authentication.models.Event;

public interface EventRepository extends CrudRepository<Event, Long> {

	@Query("SELECT e FROM Event e WHERE state = ?1")
	List<Event> findUserStateEvents(String state);
	
	@Query("SELECT e FROM Event e WHERE state != ?1")
	List<Event> findUserOutStateEvents(String state);

}
