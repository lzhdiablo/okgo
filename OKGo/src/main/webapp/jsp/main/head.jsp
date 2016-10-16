<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
</head>
<body style="width: 1350px;">
	<div id="div_head" align="right">
			<img alt="" src="/OKGo/image/icons/homepage.png" style="top:3px;position: relative;">
			<a href="/OKGo/main/homePage.do">首页</a>
			<strong class="welcome">欢迎来到OK购!</strong>
			<c:choose>
				<c:when test="${empty sessionScope.user }">
					<a href="/OKGo/jsp/user/userLogIn.jsp">请登录</a>
					<a href="/OKGo/jsp/user/register.jsp">免费注册</a>
				</c:when>
				<c:otherwise>
					${sessionScope.user.nickname }
					<a href="/OKGo/userlogOut.do">退出</a>
				</c:otherwise>
			</c:choose>
			<a href="/OKGo/user/checkOrders.do">我的订单</a>
			<a href="/OKGo/myAccount.do">我的账户</a>
			<div class="logo">
				<img src="/OKGo/image/logo.jpg">
			</div>
			
	</div>
</body>
</html>