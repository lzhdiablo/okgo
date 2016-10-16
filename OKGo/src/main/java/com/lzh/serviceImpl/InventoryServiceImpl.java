package com.lzh.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lzh.dao.InventoryDao;
import com.lzh.entity.Inventory;
import com.lzh.service.InventoryService;

@Service
public class InventoryServiceImpl implements InventoryService {

	@Resource
	InventoryDao inventoryDao;
		
	@Override
	public void save(Inventory inventory) {
		// TODO Auto-generated method stub
		inventoryDao.insert(inventory);
	}

	@Override
	public List<Inventory> getAllOrdersByUserid(Integer userid) {
		// TODO Auto-generated method stub
		return inventoryDao.getAllOrdersByUserid(userid);
	}

	@Override
	public void delOrderById(String id) {
		// TODO Auto-generated method stub
		inventoryDao.delOrderById(id);
	}

	@Override
	public Integer getTotalCount() {
		// TODO Auto-generated method stub
		return inventoryDao.getTotalCount();
	}

	@Override
	public List<Inventory> getAllOrders(Integer start, Integer pageSize) {
		// TODO Auto-generated method stub
		return inventoryDao.getAllOrders(start, pageSize);
	}

	@Override
	public Integer getCountByUserid(Integer userid) {
		// TODO Auto-generated method stub
		return inventoryDao.getCountByUserid(userid);
	}

	@Override
	public List<Inventory> getOrdersByUserid(Integer userid, Integer start, Integer pageSize) {
		// TODO Auto-generated method stub
		return inventoryDao.getOrdersByUserid(userid, start, pageSize);
	}

	@Override
	public Inventory getOrderById(String id) {
		// TODO Auto-generated method stub
		return inventoryDao.getOrderById(id);
	}

	@Override
	public Inventory getOrderDetailById(String id) {
		// TODO Auto-generated method stub
		return inventoryDao.getOrderDetailById(id);
	}

	@Override
	public void updateOrderStatus(String status, String id) {
		// TODO Auto-generated method stub
		inventoryDao.updateOrderStatus(status, id);
	}

	

}
