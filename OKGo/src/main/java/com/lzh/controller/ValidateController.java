package com.lzh.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzh.entity.User;
import com.lzh.service.UserService;

@Controller
public class ValidateController {
	@Resource
	UserService userService;
	
	@RequestMapping("/registerValidate.do")
	public void logIn(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		String index = request.getParameter("index");
		User user = null;
		switch (index) {
		case "1":
			String nickname = request.getParameter("nickname");
			user = userService.getUserByNickName(nickname);
			break;
		case "2":
			String phone = request.getParameter("phone");
			user = userService.getUserByPhone(phone);
			break;
		case "3":
			String email = request.getParameter("email");
			user = userService.getUserByEmail(email);
			break;
		case "4":
			String captcha = request.getParameter("captcha");
			String checkKey = (String) session.getAttribute("checkKey");
			try {
				if (!checkKey.equals(captcha)) {
					response.getWriter().print("notpass");
				}
				else {
					response.getWriter().print("pass");
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
		default:
			break;
		}
		try {
			if (user == null) {
				response.getWriter().print("true");
			}
			else {
				response.getWriter().print("false");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
