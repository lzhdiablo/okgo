package com.lzh.dao;

import com.lzh.entity.PurchaseUnit;

public interface PurchaseUnitDao {

	void insert(PurchaseUnit purchaseUnit);

	void delPurchaseUnitByInventoryId(String id);

}
