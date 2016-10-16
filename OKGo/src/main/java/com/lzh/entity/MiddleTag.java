package com.lzh.entity;

import java.util.List;

public class MiddleTag {
	private Integer id;
	private String tagName;
	private Integer uppertagid;
	private List<LowerTag> lowerTags;
	public List<LowerTag> getLowerTags() {
		return lowerTags;
	}
	public void setLowerTags(List<LowerTag> lowerTags) {
		this.lowerTags = lowerTags;
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
	public Integer getUppertagid() {
		return uppertagid;
	}
	public void setUppertagid(Integer uppertagid) {
		this.uppertagid = uppertagid;
	}
	
	
}
