package com.lzh.entity;

import java.util.Date;
import java.util.List;

public class Inventory {
	private String id;
	private Date createdTime;
	private Integer userid;
	private Integer totalPrice;
	private String status;
	private Address address;
	private Integer addressid;
	private List<PurchaseUnit> purchaseUnits;
	private User user;
	
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public List<PurchaseUnit> getPurchaseUnits() {
		return purchaseUnits;
	}
	public void setPurchaseUnits(List<PurchaseUnit> purchaseUnits) {
		this.purchaseUnits = purchaseUnits;
	}
	public Integer getAddressid() {
		return addressid;
	}
	public void setAddressid(Integer addressid) {
		this.addressid = addressid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Date getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	public Integer getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
