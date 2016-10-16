package com.lzh.controller;

import static org.hamcrest.CoreMatchers.nullValue;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lzh.entity.Address;
import com.lzh.entity.Inventory;
import com.lzh.entity.User;
import com.lzh.service.AddressService;
import com.lzh.service.InventoryService;
import com.lzh.service.UserService;

@Controller
@RequestMapping("/orderManage")
public class OrderManageController {
	
	@Resource
	InventoryService inventoryService;
	@Resource
	UserService userService;
	@Resource
	AddressService addressService;
	
	@RequestMapping("/selectOrders.do")
	public void selectOrders(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> map = new HashMap<String, Object>();
		List<Inventory> inventories = new ArrayList<>();
		Integer currentPage = Integer.parseInt(request.getParameter("page"));
		Integer pageSize = Integer.parseInt(request.getParameter("rows"));
		Integer start = (currentPage - 1)*pageSize;
		Integer total = null;
		
		try {
			if (request.getParameter("orderid") != null) {
				String id = request.getParameter("orderid");
				if (id.equals("")) {
					total = inventoryService.getTotalCount();
					inventories = inventoryService.getAllOrders(start, pageSize);
					map.put("total", total);
					map.put("rows", inventories);
					mapper.writeValue(response.getWriter(), map);
				}
				else {
					inventories.add(inventoryService.getOrderById(id));
					mapper.writeValue(response.getWriter(), inventories);
				}
			}
			else if (request.getParameter("nickname") != null){
				String nickname = request.getParameter("nickname");
				if (nickname.equals("")) {
					total = inventoryService.getTotalCount();
					inventories = inventoryService.getAllOrders(start, pageSize);
					map.put("total", total);
					map.put("rows", inventories);
					mapper.writeValue(response.getWriter(), map);
				}
				else {
					Integer userid = userService.getUseridByNicname(nickname);
					if (userid != null) {
						total  = inventoryService.getCountByUserid(userid);
						inventories = inventoryService.getOrdersByUserid(userid, start, pageSize);
						map.put("total", total);
						map.put("rows", inventories);
						mapper.writeValue(response.getWriter(), map);
					}
				}
			}
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	@RequestMapping("/checkOrder.do")
	public void checkOrder(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		if (request.getParameter("id") != null) {
			String id = request.getParameter("id");
			Inventory inventory = inventoryService.getOrderDetailById(id);
			ObjectMapper mapper = new ObjectMapper();
			try {
				mapper.writeValue(response.getWriter(), inventory.getPurchaseUnits());
			} catch (JsonGenerationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	@RequestMapping("/getAddressDetail.do")
	public void getAddressDetail(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		if (request.getParameter("id") != null) {
			Integer id = Integer.parseInt(request.getParameter("id"));
			Address address = addressService.getAddressById(id);
			ObjectMapper mapper = new ObjectMapper();
			try {
				mapper.writeValue(response.getWriter(), address);
			} catch (JsonGenerationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	@RequestMapping("/passOrder.do")
	public void passOrder(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		if (request.getParameter("id") != null) {
			String id = request.getParameter("id");
			String status = "审核通过";
			inventoryService.updateOrderStatus(status, id);
		}
	}
	@RequestMapping("/delivery.do")
	public void delivery(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		if (request.getParameter("id") != null) {
			String id = request.getParameter("id");
			String status = "卖家已发货";
			inventoryService.updateOrderStatus(status, id);
		}
	}
}
