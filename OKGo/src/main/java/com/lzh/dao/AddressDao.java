package com.lzh.dao;

import java.util.List;

import com.lzh.entity.Address;

public interface AddressDao {

	List<Address> getAddressesByUserId(Integer userid);

	Address getAddressById(Integer id);

	void updateAddress(Address address);

	void saveAddress(Address address);

	void delAddressById(Integer id);

}
