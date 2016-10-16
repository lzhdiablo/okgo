package com.lzh.controller;

import static org.hamcrest.CoreMatchers.describedAs;

import java.io.IOException;
import java.net.URI;
import java.sql.Date;
import java.text.DateFormat;
import java.util.List;

import javax.annotation.Resource;
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
import com.lzh.entity.Admin;
import com.lzh.entity.User;
import com.lzh.service.AddressService;
import com.lzh.service.AdminService;
import com.lzh.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Resource
	UserService userService;
	
	@Resource
	AddressService addressService;
	@Resource
	AdminService adminService;
	
	@RequestMapping("/add.do")
	public void addUser(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		User user = new User();
		user.setNickname(request.getParameter("nickname"));
		user.setPassword(request.getParameter("password"));
		user.setPhone(request.getParameter("phone"));
		user.setEmail(request.getParameter("email"));
		user.setGender(request.getParameter("gender"));
		user.setBirthday(Date.valueOf(request.getParameter("birthday")));
		user.setRealname(request.getParameter("realname"));
		userService.registerUser(user);
	}
	
	@RequestMapping("/edit.do")
	public void editUser(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		User user = new User();
		user.setId(Integer.parseInt(request.getParameter("id")));
		user.setNickname(request.getParameter("nickname"));
		user.setPassword(request.getParameter("password"));
		user.setPhone(request.getParameter("phone"));
		user.setEmail(request.getParameter("email"));
		user.setGender(request.getParameter("gender"));
		user.setBirthday(Date.valueOf(request.getParameter("birthday")));
		user.setRealname(request.getParameter("realname"));
		userService.updateUser(user);
	}
	
	@RequestMapping("/delete.do")
	public void delUser(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		Integer id = Integer.parseInt(request.getParameter("id"));
		userService.delUserById(id);
	}
	
	@RequestMapping("/getAddresses.do")
	public void getAddresses(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");;
		Integer userid = Integer.parseInt(request.getParameter("userid"));
		List<Address> addresses = addressService.getAddressesByUserId(userid);
		ObjectMapper mapper = new ObjectMapper();
		try {
			mapper.writeValue(response.getWriter(), addresses);
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
	
	@RequestMapping("/getAddress.do")
	public void getAddress(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		response.setCharacterEncoding("utf-8");;
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
	
	@RequestMapping("/updateAddress.do")
	public void updateAddress(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		Address address = new Address();
		address.setAddress(request.getParameter("address"));
		address.setId(Integer.parseInt(request.getParameter("id")));
		address.setRecipient(request.getParameter("recipient"));
		address.setPhone(request.getParameter("phone"));
		address.setEmail(request.getParameter("email"));
		addressService.updateAddress(address);
	}
	
	@RequestMapping("/addAddress.do")
	public void addAddress(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		Address address = new Address();
		address.setUserid(request.getParameter("userid"));
		address.setAddress(request.getParameter("address"));
		address.setRecipient(request.getParameter("recipient"));
		address.setPhone(request.getParameter("phone"));
		address.setEmail(request.getParameter("email"));
		addressService.saveAddress(address);
	}
	
	@RequestMapping("/delAddress.do")
	public void delAddress(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		Integer id = Integer.parseInt(request.getParameter("id"));
		addressService.delAddressById(id);
	}
	@RequestMapping("/checkOripsw.do")
	public void checkOripsw(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		if (request.getParameter("oripsw") != null) {
			String oripsw = request.getParameter("oripsw");
			Admin admin = (Admin) session.getAttribute("admin");
			if (oripsw.equals(admin.getPassword())) {
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
			Admin admin = (Admin) session.getAttribute("admin");
			if (!newpsw.equals(admin.getPassword())) {
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
		Admin admin = (Admin) session.getAttribute("admin");
		if (request.getParameter("password") != null) {
			admin.setPassword(request.getParameter("password"));
		}
		adminService.updateAdmin(admin);
		
	}
}
