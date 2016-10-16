package com.lzh.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lzh.dao.AddressDao;
import com.lzh.entity.Address;
import com.lzh.service.AddressService;

@Service
public class AddressServiceImpl implements AddressService {

	@Resource
	AddressDao addressDao;
	
	@Override
	public List<Address> getAddressesByUserId(Integer userid) {
		// TODO Auto-generated method stub
		return addressDao.getAddressesByUserId(userid);
	}

	@Override
	public Address getAddressById(Integer id) {
		// TODO Auto-generated method stub
		return addressDao.getAddressById(id);
	}

	@Override
	public void updateAddress(Address address) {
		// TODO Auto-generated method stub
		addressDao.updateAddress(address);
	}

	@Override
	public void saveAddress(Address address) {
		// TODO Auto-generated method stub
		addressDao.saveAddress(address);
	}

	@Override
	public void delAddressById(Integer id) {
		// TODO Auto-generated method stub
		addressDao.delAddressById(id);
	}

}
