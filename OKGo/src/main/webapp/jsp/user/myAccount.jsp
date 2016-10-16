<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
<script type="text/javascript" src="/OKGo/easyui/jquery-3.1.0.min.js"></script>
<title>Insert title here</title>
</head>
<body style="width: 1350px;">
	<div class="mask" id="mask"></div>
	<div class="popup">
		<div class="popup-title"><span></span><a href="#" style="float: right;" onclick="closeAddress()"><img src="/OKGo/image/icons/close.png"></a></div><br><br><br><br>
		<form  id="address" style="padding-left: 20px; text-align: left;">
			<table>
				<tr><td>收货人姓名：<br><br>
					<td><input style="height: 25px;width: 400px;" class="easyui-validatebox" data-options="required:true" name="recipient" placeholder="长度不超过20字符" maxlength="20" >
				<br><br>
				<tr><td>详细地址：<br><br>
					<td><textarea style="height: 50px; width: 400px;" name="address" class="easyui-validatebox" data-options="required:true"  placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息" ></textarea>
				<br><br>
				<tr><td>手机号码：<br><br>
					<td><input style="height: 25px; width: 400px;" class="easyui-validatebox" data-options="required:true" validType="phone_format" name="phone" maxlength="11" >
				<br><br>
				<tr><td>邮箱：<br><br>
					<td><input style="height: 25px; width: 400px;" name="email" class="easyui-validatebox" validType="email">
			</table>
			<input name="id" type="hidden">
			<input name="userid" value="${user.id }" type="hidden">
			<br><br>
			<a href="#" class="a-saveAddress">保存</a>
		</form>
	</div>
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
		<div class="logo2">
			<img src="/OKGo/image/logo2.jpg">
		</div>
	</div>
	<div id="account-head">
		<div style="float: left;line-height: normal;top: 15px;position: relative;">
			<table>
				<tr><td><label id="account-label">我的账户</label>
				<tr><td><a href="/OKGo/main/homePage.do" class="toHomePage-link" onmouseover="linkHighlight(this)" onmouseout="linkNormal(this)">返回商城首页</a>
			</table>
		</div>
		<input id="account-input-search" type="text" class="account-search"><a href="#" id="account-link-search" class="account-search" onclick="searchKeyWord()">搜索</a>
		<div id="account-cart" >
			<label><img src="/OKGo/image/icons/cart.png" class="icon-cart"></label>
			<a href="/OKGo/main/getCartContent.do?method=noajax" id="cart-link" onmouseover="cartHighlight(this)" onmouseout="cartNormal(this)">我的购物车</a>
			<div class="goodsNumInCart" id="goodsNumInCart" style="position: relative; top: -40px;">${fn:length(sessionScope.shoppingCart) }</div>
		</div>
	</div>
	<div class="background">
		<div id="menu">
			<ul>
				<li class="firsttitle">用户管理<br><br>
				<li class="secondtitle"><a href="#" onclick="editAccountInfo()">个人信息管理</a>
				<li class="secondtitle"><a href="#" onclick="changePsw()">账户安全</a>
				<li class="secondtitle"><a href="#" onclick="checkAddresses()">收货地址管理</a>
			</ul>
			<ul>
				<li class="firsttitle">订单中心<br><br>
				<li class="secondtitle"><a href="/OKGo/user/checkOrders.do" onclick="checkOrders()">我的订单</a>
			</ul>
		</div>
		<div id="title">
			${title }
		</div>
		<div id="content">
			<jsp:include page="${containedjsp }"></jsp:include>
		</div>
	</div>
	<script type="text/javascript">
		$(".background").css("height", document.body.scrollHeight);
		function linkHighlight(obj){
			$(obj).css("background-color", "white");			
		}
		function linkNormal(obj){
			$(obj).css("background-color", "#ff4d4d");			
		}
		function cartHighlight(obj){
			$(obj).css("color", "red");
		}
		function cartNormal(obj){
			$(obj).css("color", "black");
		}
		function editAccountInfo(){
			location.href = "/OKGo/user/editAccountInfo.do";
		}
		function changePsw(){
			location.href = "/OKGo/user/changePsw.do";
		}
		function checkAddresses(){
			location.href = "/OKGo/user/checkAddresses.do";
		}
		function checkOrders(){
			location.href = "/OKGo/user/checkOrders.do";
		}
		function searchKeyWord(){
			var keyword = document.getElementById("account-input-search").value;
			location.href = "/OKGo/main/search.do?keyword="+keyword+"";
		}
	</script>
	
</body>
</html>