package com.mahesh.repository;

import org.springframework.data.repository.CrudRepository;

import com.mahesh.model.User;

public interface UserRepository extends CrudRepository<User,Integer> {


User findByUsernameAndPassword(String username, String password);

}
