package com.lzh.entity;

import java.util.List;

public class LowerTag {
	private Integer id;
	private String tagName;
	private MiddleTag middleTag;
	private List<Goods> goods;
	public List<Goods> getGoods() {
		return goods;
	}
	public void setGoods(List<Goods> goods) {
		this.goods = goods;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public MiddleTag getMiddleTag() {
		return middleTag;
	}
	public void setMiddleTag(MiddleTag middleTag) {
		this.middleTag = middleTag;
	}
	
}
