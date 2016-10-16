package com.lzh.entity;

public class PurchaseUnit {
	private Integer id;
	private String inventoryid;
	private Integer goodsid;
	private Integer amount;
	private Integer totalprice;
	private Goods goods;
	
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getInventoryid() {
		return inventoryid;
	}
	public void setInventoryid(String inventoryid) {
		this.inventoryid = inventoryid;
	}
	public Integer getGoodsid() {
		return goodsid;
	}
	public void setGoodsid(Integer goodsid) {
		this.goodsid = goodsid;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Integer getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(Integer totalprice) {
		this.totalprice = totalprice;
	}
	
}
