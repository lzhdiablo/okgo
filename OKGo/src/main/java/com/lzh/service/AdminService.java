package com.lzh.service;

import com.lzh.entity.Admin;

public interface AdminService {

	Admin logInCheck(String name, String password);

	void updateAdmin(Admin admin);

}
