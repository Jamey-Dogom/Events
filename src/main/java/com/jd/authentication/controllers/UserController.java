package com.jd.authentication.controllers;


import java.util.Iterator;
import java.util.List;


import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jd.authentication.models.Event;
import com.jd.authentication.models.Message;
import com.jd.authentication.models.User;
import com.jd.authentication.services.UserService;
import com.jd.authentication.validator.UserValidator;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private UserValidator userValidator;

	@RequestMapping("/")
	public String registerForm(@ModelAttribute("user") User user) {
		return "registrationPage.jsp";
	}

	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		// if result has errors, return the registration page (don't worry about
		// validations just now)

		// validator does check on form as well
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "registrationPage.jsp";
		} else {
			// else, save the user in the database, save the user id in session, and
			// redirect them to the /home route
			userService.registerUser(user);
			session.setAttribute("user", user);
			return "redirect:/events";
		}
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginUser(@ModelAttribute("user") User user, @RequestParam("email") String email,
			@RequestParam("password") String password, Model model, HttpSession session) {
		// if the user is authenticated, save their user id in session
		if (userService.authenticateUser(email, password)) {
			session.setAttribute("user", userService.findByEmail(email));
			return "redirect:/events";
		}
		// else, add error messages and return the login page
		else {
			model.addAttribute("error", "Invalid Credentials. Please try again.");
			return "registrationPage.jsp";
		}
	}

	@RequestMapping("/events")
	public String home(HttpSession session, Model model) {
		if (session.getAttribute("user") == null) {
			return "redirect:/";
		}
		
		User user = (User) session.getAttribute("user");
		// get user from session, save them in the model and return the home page
		model.addAttribute("user", session.getAttribute("user"));

		// events within user state
		model.addAttribute("instate_events", userService.findAllEventsInUserState((User) session.getAttribute("user")));

		// events outside of user state
		model.addAttribute("outstate_events",
				userService.findAllEventsOutUserState((User) session.getAttribute("user")));
		
		//
		model.addAttribute("eventsjoined", userService.findJoinedEventsByUserId(user.getId()));

		model.addAttribute("event", new Event());
		return "homePage.jsp";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		// invalidate session
		session.invalidate();
		// redirect to login page
		return "redirect:/";
	}

	@PostMapping("/createEvent")
	public String createEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session,
			Model model) {
		if (result.hasErrors()) {
			// get user from session, save them in the model and return the home page
			model.addAttribute("user", session.getAttribute("user"));

			// events within user state
			model.addAttribute("instate_events",
					userService.findAllEventsInUserState((User) session.getAttribute("user")));

			// events outside of user state
			model.addAttribute("outstate_events",
					userService.findAllEventsOutUserState((User) session.getAttribute("user")));
			return "homePage.jsp";
		} else {
			event.setHost((User) session.getAttribute("user"));
			userService.createEvent(event);
			return "redirect:/events";
		}
	}

	@RequestMapping("/events/{id}/edit")
	public String editEvent(@PathVariable("id") Long id, Model model, HttpSession session) {
		Event event = userService.findEventById(id);
		if (session.getAttribute("user") != event.getHost()) {
			model.addAttribute("user", session.getAttribute("user"));
			model.addAttribute("event", event);
			return "editEvent.jsp";

		} else {
			return "redirect:/";
		}
	}

	@RequestMapping("/events/{id}/delete")
	public String deleteEvent(@PathVariable("id") Long id, Model model, HttpSession session) {
		Event event = userService.findEventById(id);
		User user = (User) session.getAttribute("user");
		if (user.getId() != event.getHost().getId()) {
			System.out.println("no");
			return "redirect:/events";

		} else {
			System.out.println("yes");
			userService.deleteEvent(event.getId());
			return "redirect:/events";
		}
	}

	@RequestMapping("/events/{id}/join")
	public String joinEvent(@PathVariable("id") Long id, HttpSession session) {
		Event event = userService.findEventById(id);
		User user = (User) session.getAttribute("user");
		List<User> guests = event.getAttendees();
		guests.add(user);
		event.setAttendees(guests);
		userService.createEvent(event);
		return "redirect:/events";
	}

	@RequestMapping("/events/{id}/cancel")
	public String cancelEvent(@PathVariable("id") Long id, HttpSession session) {
		Event event = userService.findEventById(id);
		User user = (User) session.getAttribute("user");
		List<User> guests = event.getAttendees();
		Iterator<User> i = guests.iterator();
		while (i.hasNext()) {
			User o = i.next();
			if (o.getId() == user.getId()) {
				i.remove();
			}
		}

		event.setAttendees(guests);
		userService.createEvent(event);
		return "redirect:/events";
	}

	@PutMapping(value = "/editEvent/{id}")
	public String update(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session) {
		if (result.hasErrors()) {
			System.out.println("nope");
			return "editEvent.jsp";
		} else {
			System.out.println("updated");
			event.setHost((User) session.getAttribute("user"));
			userService.createEvent(event);
			return "redirect:/events";
		}
	}

	@RequestMapping("/events/{id}")
	public String showEvent(@PathVariable("id") Long id, Model model, HttpSession session) {
		model.addAttribute("event", userService.findEventById(id));
		model.addAttribute("user", (User) session.getAttribute("user"));
		model.addAttribute("attendees", userService.findEventById(id).getAttendees());
		model.addAttribute("messages", userService.findEventById(id).getMessages());
		return "event.jsp";
	}
	
	@PostMapping("/events/{id}/addMessage")
	public String addMessageToEvent(@RequestParam("message") String message, @PathVariable("id") Long id, HttpSession session) {
		Message message1 = new Message();
		Event event = userService.findEventById(id);
		message1.setUser((User) session.getAttribute("user"));
		message1.setMessage(message);
		message1.setEvent(event);
		userService.createMessage(message1);
		
		List<Message> messages = event.getMessages();
		messages.add(message1);
		event.setMessages(messages);
		userService.createEvent(event);
		return "redirect:/events/{id}";
	}

}
