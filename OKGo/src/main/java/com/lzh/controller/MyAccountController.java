package com.lzh.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyAccountController {
	
	
	@RequestMapping("/myAccount.do")
	public void checkMyAccount(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		try {
			if (session.getAttribute("user") == null) {
				request.getRequestDispatcher("/jsp/user/userLogIn.jsp").forward(request, response);
			}
			else {
				request.getRequestDispatcher("/jsp/user/myAccount.jsp").forward(request, response);
			}
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
