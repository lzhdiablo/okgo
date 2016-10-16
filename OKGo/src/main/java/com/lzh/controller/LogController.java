package com.lzh.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.tagext.Tag;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzh.entity.Admin;
import com.lzh.entity.User;
import com.lzh.service.AdminService;
import com.lzh.service.UserService;
@Controller
public class LogController {
	
	@Resource
	UserService userService;
	
	@Resource
	AdminService adminService;
	
	@RequestMapping("/userlogIn.do")
	public void userlogIn(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		String account = request.getParameter("account");
		String password = request.getParameter("password");
		String target = "/OKGo/main/homePage.do";
		if (request.getParameter("target") != null & !"".equals(request.getParameter("target"))) {
			target = request.getParameter("target");
		}
		if (account != null && password != null) {
			User user = userService.logInCheck(account, password);
			try {
				if (user == null) {
					response.getWriter().print("false");
				}
				else {
					session.setAttribute("user", user);
					response.getWriter().print(target);
				
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/userlogOut.do")
	public void userlogOut(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		session.removeAttribute("user");
		try {
			request.getRequestDispatcher("/main/homePage.do").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/adminLogIn.do")
	public void adminlogOut(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		if (name != null && password != null) {
			Admin admin = adminService.logInCheck(name, password);
			try {
				if (admin == null) {
					response.getWriter().print("false");
				}
				else {
					session.setAttribute("admin", admin);
					response.getWriter().print("true");
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/adminLogOut.do")
	public void adminLogOut(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		session.removeAttribute("admin");
		try {
			request.getRequestDispatcher("/jsp/admin/adminLogIn.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
