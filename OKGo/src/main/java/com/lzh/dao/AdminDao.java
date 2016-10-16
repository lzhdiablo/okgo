package com.lzh.dao;

import com.lzh.entity.Admin;

public interface AdminDao {

	Admin getAdminByNameAndPsw(String name, String password);

	void updateAdmin(Admin admin);

}
