package com.lzh.dao;

import java.util.List;


import com.lzh.entity.UpperTag;

public interface UpperTagMapper {
	public List<UpperTag> getAllTags();

	public UpperTag getUpperTagByTagName(String uppertag); 
}   
