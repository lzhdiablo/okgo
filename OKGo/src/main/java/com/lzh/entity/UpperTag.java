package com.lzh.entity;

import java.util.List;

public class UpperTag {
	private Integer id;
	private String tagName;
	private List<MiddleTag> middleTags;
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
	public List<MiddleTag> getMiddleTags() {
		return middleTags;
	}
	public void setMiddleTags(List<MiddleTag> middleTags) {
		this.middleTags = middleTags;
	}
	
	
	
}
