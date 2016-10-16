package com.lzh.serviceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lzh.dao.LowerTagDao;
import com.lzh.dao.MiddleTagDao;
import com.lzh.dao.UpperTagMapper;
import com.lzh.entity.LowerTag;
import com.lzh.entity.MiddleTag;
import com.lzh.entity.UpperTag;
import com.lzh.service.PackService;


@Service
public class PackServiceImpl implements PackService {

	@Resource
	UpperTagMapper upperTagMapper;
	@Resource
	MiddleTagDao middleTagDao;
	@Resource
	LowerTagDao lowerTagDao;
	
	
	@Override
	public UpperTag getUpperTagByName(String uppertag) {
		// TODO Auto-generated method stub
		return upperTagMapper.getUpperTagByTagName(uppertag);
	}

	@Override
	public MiddleTag getMiddleTagByName(String middletag) {
		// TODO Auto-generated method stub
		return middleTagDao.getMiddleTagByTagName(middletag);
	}

	@Override
	public LowerTag getLowerTagByName(String lowertag) {
		// TODO Auto-generated method stub
		return lowerTagDao.getLowerTagByTagName(lowertag);
	}

}
