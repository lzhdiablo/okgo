package com.lzh.serviceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lzh.dao.PurchaseUnitDao;
import com.lzh.entity.PurchaseUnit;
import com.lzh.service.PurchaseUnitService;

@Service
public class PurchaseUnitServiceImpl implements PurchaseUnitService {

	@Resource
	PurchaseUnitDao purchaseUnitDao;
	
	@Override
	public void save(PurchaseUnit purchaseUnit) {
		// TODO Auto-generated method stub
		purchaseUnitDao.insert(purchaseUnit);
	}

	@Override
	public void delPurchaseUnitByInventoryId(String id) {
		// TODO Auto-generated method stub
		purchaseUnitDao.delPurchaseUnitByInventoryId(id);
	}

}
