package com.lzh.serviceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lzh.dao.AdminDao;
import com.lzh.entity.Admin;
import com.lzh.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Resource
	AdminDao adminDao;
	
	@Override
	public Admin logInCheck(String name, String password) {
		// TODO Auto-generated method stub
		return adminDao.getAdminByNameAndPsw(name, password);
	}

	@Override
	public void updateAdmin(Admin admin) {
		// TODO Auto-generated method stub
		adminDao.updateAdmin(admin);
	}
	
}
