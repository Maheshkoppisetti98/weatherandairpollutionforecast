package com.mahesh.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mahesh.model.User;
import com.mahesh.services.UserService;

@Controller
public class ApplicationController {
	@Autowired
	private UserService userService;
	@RequestMapping("/")
	public String hello(HttpServletRequest request) {//
		request.setAttribute("mode","MODE_HOME");
		//.setAttribute()
		return "index";
	}
	@RequestMapping("/welcome")
	public String welcome(HttpServletRequest request) {
		request.setAttribute("mode","MODE_HOME");
		return "index";
	}
	@RequestMapping("/register")
	public String registration(HttpServletRequest request) {
		request.setAttribute("mode","MODE_REGISTER");
		return "index";
	}
	@PostMapping("/save-user")
	public String registerUser(@ModelAttribute User user,BindingResult bindingResult,HttpServletRequest request) {
		userService.saveMyUser(user);
		request.setAttribute("mode","MODE_HOME");
		return "index";
	}
	public String showAllUsers(HttpServletRequest request) {
		request.setAttribute("users",userService.showAllUsers());
		request.setAttribute("mode","ALL_USERS");
		
		return "index";
	}
	
	public String deleteUser(@RequestParam int id,HttpServletRequest request) {
		userService.deleteMyUser(id);
		request.setAttribute("mode",userService.showAllUsers());
		return "index";
	}
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_LOGIN");
		return "index";
	}
 
	@RequestMapping ("/login-user")
	public String loginUser(@ModelAttribute User user, HttpServletRequest request) {
		if(userService.findByUsernameAndPassword(user.getUsername(), user.getPassword())!=null) {
			return "homepage";
		}
		else {
			request.setAttribute("error", "Invalid Username or Password");
			request.setAttribute("mode", "MODE_LOGIN");
			return "index";
			
		}
	}
	
	
	
}
