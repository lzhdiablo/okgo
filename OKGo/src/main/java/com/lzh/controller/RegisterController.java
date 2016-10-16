package com.lzh.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzh.entity.User;
import com.lzh.service.UserService;

@Controller
public class RegisterController {
	@Resource
	UserService userService;
	
	@RequestMapping("/register.do")
	public void logIn(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		User user = new User();
		user.setNickname((String)request.getParameter("nickname"));
		user.setPassword((String)request.getParameter("password"));
		user.setPhone((String)request.getParameter("phone"));
		user.setEmail((String)request.getParameter("email"));
		userService.registerUser(user);
		try {
			request.getRequestDispatcher("/jsp/user/registerSuccess.jsp").forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
}
