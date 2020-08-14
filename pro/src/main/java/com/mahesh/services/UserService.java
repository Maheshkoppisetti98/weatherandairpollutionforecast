package com.mahesh.services;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;
import com.mahesh.model.User;
import com.mahesh.repository.UserRepository;



import org.springframework.stereotype.Service;
@Service
@Transactional
public class UserService {
	private final UserRepository userRepository;
	public UserService(UserRepository userRepository) {
		this.userRepository=userRepository;
	}
	public void saveMyUser(User user) {
		userRepository.save(user);
	}
	public List<User> showAllUsers(){
		List<User> users=new ArrayList<User>();
		for(User user:userRepository.findAll()) {
			users.add(user);
		}
		return users;
	}
	
	public void deleteMyUser(int id) {
		userRepository.deleteById(id);;
	}

	public User findByUsernameAndPassword(String username, String password) {
		return userRepository.findByUsernameAndPassword(username, password);
	}
	
}
