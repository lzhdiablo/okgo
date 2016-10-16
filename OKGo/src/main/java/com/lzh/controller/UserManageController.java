 package com.lzh.controller;


import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.jws.soap.SOAPBinding.Use;
import javax.servlet.ServletException;
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
import com.lzh.service.PurchaseUnitService;
import com.lzh.service.UserService;

@Controller
@RequestMapping("/user")
public class UserManageController {
	@Resource
	UserService userService;
	@Resource
	AddressService addressService;
	@Resource
	InventoryService inventoryService;
	@Resource
	PurchaseUnitService purchaseUnitService;
	
	@RequestMapping("/userManage.do")
	public void adminlogOut(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setContentType("text/html; charset=utf-8");
		List<User> users = new ArrayList<>();
		String nickname = request.getParameter("nickname");
		if (nickname != null) {
			Integer currentPage = Integer.parseInt(request.getParameter("page"));
			Integer pageSize = Integer.parseInt(request.getParameter("rows"));
			Integer start = (currentPage - 1)*pageSize;
			Integer total = null;
			if (nickname.equals("")) {
				total = userService.getTotalCount();
				users = userService.getAllUsers(start, pageSize);
			}	
			else {
				total = userService.getCountByNickName(nickname);
				users.add(userService.getUserByNickName(nickname));
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("total", total);
			map.put("rows", users);
			ObjectMapper mapper = new ObjectMapper();
			try {
				mapper.writeValue(response.getWriter(), map);
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
	@RequestMapping("/editAccountInfo.do")
	public void editAccoutInfo(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		request.setAttribute("title", "个人信息管理");
		request.setAttribute("containedjsp", "editAccountInfo.jsp");
		try {
			request.getRequestDispatcher("/jsp/user/myAccount.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/updateUser.do")
	public void updateUser(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		User user = (User) session.getAttribute("user");
		user.setNickname(request.getParameter("nickname"));
		user.setPhone(request.getParameter("phone"));
		user.setEmail(request.getParameter("email"));
		user.setGender(request.getParameter("gender"));
		user.setBirthday(Date.valueOf(request.getParameter("birthday")));
		user.setRealname(request.getParameter("realname"));
		userService.updateUser(user);
	}
	@RequestMapping("/changePsw.do")
	public void changePsw(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		request.setAttribute("title", "账户安全");
		request.setAttribute("containedjsp", "changePsw.jsp");
		try {
			request.getRequestDispatcher("/jsp/user/myAccount.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/checkOripsw.do")
	public void checkOripsw(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		if (request.getParameter("oripsw") != null) {
			String oripsw = request.getParameter("oripsw");
			User user = (User) session.getAttribute("user");
			if (oripsw.equals(user.getPassword())) {
				try {
					response.getWriter().print("true");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	@RequestMapping("/checkNewpsw.do")
	public void checkNewpsw(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		if (request.getParameter("newpsw") != null) {
			String newpsw = request.getParameter("newpsw");
			User user = (User) session.getAttribute("user");
			if (!newpsw.equals(user.getPassword())) {
				try {
					response.getWriter().print("true");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	@RequestMapping("/updatePsw.do")
	public void updatePsw(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		User user = (User) session.getAttribute("user");
		if (request.getParameter("password") != null) {
			user.setPassword(request.getParameter("password"));
		}
		userService.updateUser(user);
		
	}
	@RequestMapping("/checkAddresses.do")
	public void checkAddresses(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		User user = (User) session.getAttribute("user");
		if (user != null) {
			Integer userid = user.getId();
			List<Address> addresses = addressService.getAddressesByUserId(userid);
			request.setAttribute("addresses", addresses);
			try {
				request.setAttribute("title", "收货地址管理");
				request.setAttribute("containedjsp", "checkAddresses.jsp");
				request.getRequestDispatcher("/jsp/user/myAccount.jsp").forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	@RequestMapping("/delAddress.do")
	public void delAddress(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		if (request.getParameter("id") != null) {
			Integer id = Integer.parseInt(request.getParameter("id"));
			addressService.delAddressById(id);
		}
	}
	@RequestMapping("/checkOrders.do")
	public void checkOrders(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		User user = (User) session.getAttribute("user");
		try {
			if (user != null) {
				List<Inventory> inventories = inventoryService.getAllOrdersByUserid(user.getId());
				request.setAttribute("inventories", inventories);
					request.setAttribute("title", "我的订单");
					request.setAttribute("containedjsp", "checkOrders.jsp");
					request.getRequestDispatcher("/jsp/user/myAccount.jsp").forward(request, response);
			}
			else {
					request.getRequestDispatcher("/jsp/user/userLogIn.jsp").forward(request, response);
			}
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping("/delInventory.do")
	public void delInventory(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id");
		if (id != null) {
			inventoryService.delOrderById(id);
			purchaseUnitService.delPurchaseUnitByInventoryId(id);
		}
	}
	@RequestMapping("/recieveConfirm.do")
	public void recieveConfirm(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		if (request.getParameter("id") != null) {
			String id = request.getParameter("id");
			String status = "交易完成";
			inventoryService.updateOrderStatus(status, id);
		}
	}
}
