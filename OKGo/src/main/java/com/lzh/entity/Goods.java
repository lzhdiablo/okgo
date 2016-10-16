package com.lzh.entity;

public class Goods {
	private Integer id;
	private String image;
	private String fullname;
	private Integer price;
	private Integer stock;
	private String lowerTag;
	private String middleTag;
	private String upperTag;
	private boolean hot;
	private boolean special;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public String getLowerTag() {
		return lowerTag;
	}
	public void setLowerTag(String lowerTag) {
		this.lowerTag = lowerTag;
	}
	public String getMiddleTag() {
		return middleTag;
	}
	public void setMiddlTag(String middlTag) {
		this.middleTag = middlTag;
	}
	public String getUpperTag() {
		return upperTag;
	}
	public void setUpperTag(String upperTag) {
		this.upperTag = upperTag;
	}
	public boolean isHot() {
		return hot;
	}
	public void setHot(boolean hot) {
		this.hot = hot;
	}
	public boolean isSpecial() {
		return special;
	}
	public void setSpecial(boolean special) {
		this.special = special;
	}
	
}
