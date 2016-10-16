package com.lzh.service;

import com.lzh.entity.PurchaseUnit;

public interface PurchaseUnitService {

	void save(PurchaseUnit purchaseUnit);

	void delPurchaseUnitByInventoryId(String id);

}
