package com.lzh.test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.comparator.InvertibleComparator;

import com.lzh.entity.Inventory;
import com.lzh.entity.UpperTag;
import com.lzh.entity.User;
import com.lzh.service.HomePageService;
import com.lzh.service.InventoryService;
import com.lzh.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})
public class Test {
	
	@Resource
	UserService userService;
	@Resource
	InventoryService inventoryService;
	
	
	@org.junit.Test
	public void test1() {
		Integer userid = 1;
		List<Inventory> inventories = inventoryService.getAllOrdersByUserid(userid);
		System.out.println(inventories);
		System.out.println(inventories.get(0).getAddress().getAddress());
	}
	
	
	
}
