package com.jd.authentication.services;

import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jd.authentication.models.Event;
import com.jd.authentication.models.Message;
import com.jd.authentication.models.User;
import com.jd.authentication.repositories.EventRepository;
import com.jd.authentication.repositories.MessageRepository;
import com.jd.authentication.repositories.UserRepository;

@Service
public class UserService {
	@Autowired
    private UserRepository userRepository;
	@Autowired
    private EventRepository eventRepository;
	@Autowired
    private MessageRepository messageRepository;
	

    
    // register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepository.save(user);
    }
    
    // find user by email
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    // find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepository.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    
    // authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepository.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    
    public void deleteEvent(Long id) {
    	eventRepository.deleteById(id);
    }

	public Object findAllEventsInUserState(User user) {
		return eventRepository.findUserStateEvents(user.getState());
		
	}

	public void createEvent(Event event) {
		eventRepository.save(event);
		
	}

	public Object findAllEventsOutUserState(User user) {
		return eventRepository.findUserOutStateEvents(user.getState());
	}

	public Event findEventById(Long id) {
		return eventRepository.findById(id).get();
	}

	public void createMessage(Message message) {
		messageRepository.save(message);
		
	}



	public List<Event> findJoinedEventsByUserId(Long id) {
		return userRepository.findById(id).get().getEvents();
	}
    
}
