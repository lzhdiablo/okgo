package com.lzh.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lzh.dao.UserDao;
import com.lzh.entity.User;
import com.lzh.service.UserService;


@Service
public class UserServiceImpl implements UserService {
	@Resource
	private UserDao userDao;
	

	@Override
	public User logInCheck(String account, String password) {
		// TODO Auto-generated method stub
		User user = userDao.getUserByNickNameAndPsw(account, password);
		if (user == null) {
			user = userDao.getUserByPhoneAndPsw(account, password);
			if (user == null) {
				user = userDao.getUserByEmailAndPsw(account, password);
			}
		}
		return user;
	}




	@Override
	public User getUserByPhone(String phone) {
		// TODO Auto-generated method stub
		return userDao.getUserByPhone(phone);
	}


	@Override
	public User getUserByEmail(String email) {
		// TODO Auto-generated method stub
		return userDao.getUserByEmail(email);
	}


	@Override
	public void registerUser(User user) {
		// TODO Auto-generated method stub
		userDao.saveUser(user);
	}


	@Override
	public List<User> getAllUsers(Integer start, Integer pageSize) {
		// TODO Auto-generated method stub
		return userDao.getAllUsers(start, pageSize);
	}


	@Override
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		userDao.updateUser(user);
	}


	@Override
	public void delUserById(Integer id) {
		// TODO Auto-generated method stub
		userDao.delUserById(id);
	}


	@Override
	public Integer getCountByNickName(String nickname) {
		// TODO Auto-generated method stub
		if ("".equals(nickname)) {
			return userDao.getTotalCount();
		}
		else {
			return userDao.getCountByNickName(nickname);
		}
		
	}


	@Override
	public User getUserByNickName(String nickname) {
		// TODO Auto-generated method stub
		return userDao.getUserByNickName(nickname);
	}


	@Override
	public Integer getTotalCount() {
		// TODO Auto-generated method stub
		return userDao.getTotalCount();
	}




	@Override
	public Integer getUseridByNicname(String nickname) {
		// TODO Auto-generated method stub
		User user = userDao.getUserByNickName(nickname);
		if (user != null) {
			return user.getId();
		}
		else return null;
	}

	
	
	
	

}
