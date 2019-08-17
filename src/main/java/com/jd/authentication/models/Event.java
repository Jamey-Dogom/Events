package com.jd.authentication.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Future;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * @author jameydogom
 *
 */
@Entity
@Table(name="events")
public class Event {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    @Size(min = 1, message = "First Name must be at least 1 Character")
    private String name;
    @Size(min = 1, message = "Last Name must be at least 1 Character")
    private String location;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @Future(message = "only future dates accepted")
    @Temporal(TemporalType.DATE)
    private Date date;
    private String state;
    @Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
    
    
    // many to many with events and user attendees
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "users_events", 
        joinColumns = @JoinColumn(name = "event_id"), 
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<User> attendees;
    
    
    // one to many with messages
    @OneToMany(mappedBy="event", fetch = FetchType.LAZY)
    private List<Message> messages;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User host;
    
    
    public Event() {
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}



	public String getLocation() {
		return location;
	}





	public void setLocation(String location) {
		this.location = location;
	}





	public Date getDate() {
		return date;
	}





	public void setDate(Date date) {
		this.date = date;
	}





	public String getState() {
		return state;
	}





	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setState(String state) {
		this.state = state;
	}





	public Date getCreatedAt() {
		return createdAt;
	}





	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}





	public Date getUpdatedAt() {
		return updatedAt;
	}





	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}





//	public User getHost() {
//		return host;
//	}
//
//
//
//
//
//	public void setHost(User host) {
//		this.host = host;
//	}





	public List<User> getAttendees() {
		return attendees;
	}





	public void setAttendees(List<User> attendees) {
		this.attendees = attendees;
	}





	public List<Message> getMessages() {
		return messages;
	}





	public User getHost() {
		return host;
	}

	public void setHost(User host) {
		this.host = host;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}





	// other getters and setters removed for brevity
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
    
}
