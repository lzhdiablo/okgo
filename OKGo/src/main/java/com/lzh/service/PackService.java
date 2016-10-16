package com.lzh.service;

import com.lzh.entity.LowerTag;
import com.lzh.entity.MiddleTag;
import com.lzh.entity.UpperTag;

public interface PackService {

	UpperTag getUpperTagByName(String uppertag);

	MiddleTag getMiddleTagByName(String middletag);

	LowerTag getLowerTagByName(String lowertag);

}
