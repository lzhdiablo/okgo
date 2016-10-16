package com.lzh.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.lzh.dao.UpperTagMapper;
import com.lzh.entity.UpperTag;
import com.lzh.service.HomePageService;

@Service
public class HomePageServiceImpl implements HomePageService {
	
	
	@Resource
	private UpperTagMapper UpperTagMapper;
	
	@Override
	public List<UpperTag> getAllTags() {
		// TODO Auto-generated method stub
		return UpperTagMapper.getAllTags();
	}
}
