package com.lzh.service;

import java.util.List;

import com.lzh.entity.User;

public interface UserService {

	User logInCheck(String account, String password);

	User getUserByPhone(String phone);

	User getUserByEmail(String email);

	void registerUser(User user);

	List<User> getAllUsers(Integer start, Integer pageSize);

	void updateUser(User user);

	void delUserById(Integer id);

	Integer getCountByNickName(String nickname);

	User getUserByNickName(String nickname);

	Integer getTotalCount();

	Integer getUseridByNicname(String nickname);
	
}
