package com.lzh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.lzh.entity.User;

public interface UserDao {

	public User getUserByNickNameAndPsw(String account, String password);

	public User getUserByPhoneAndPsw(String account, String password);

	public User getUserByEmailAndPsw(String account, String password);


	public User getUserByPhone(String phone);

	public User getUserByEmail(String email);

	public void saveUser(User user);


	public void updateUser(User user);

	public void delUserById(Integer id);

	public Integer getCountByNickName(String nickname);

	public Integer getTotalCount();

	public User getUserByNickName(String nickname);

	public List<User> getAllUsers(Integer start, Integer pageSize);

}
