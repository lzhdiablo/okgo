package com.lzh.service;

import java.util.List;

import com.lzh.entity.Inventory;

public interface InventoryService {

	void save(Inventory inventory);

	List<Inventory> getAllOrdersByUserid(Integer userid);

	void delOrderById(String id);


	Integer getTotalCount();

	List<Inventory> getAllOrders(Integer start, Integer pageSize);

	Integer getCountByUserid(Integer userid);

	List<Inventory> getOrdersByUserid(Integer userid, Integer start, Integer pageSize);

	Inventory getOrderById(String id);

	Inventory getOrderDetailById(String id);

	void updateOrderStatus(String status, String id);

	

}
