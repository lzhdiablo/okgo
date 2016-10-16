<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body style="width: 1350px;">
	<jsp:include page="head.jsp"></jsp:include>
	<jsp:include page="search.jsp"></jsp:include>
	<jsp:include page="shoppingCart.jsp"></jsp:include>
	<div class="div_category_frame">
		<div class="div_category">
		</div>
	</div>
	<div id="addToCart-success-hint">
		<img src="/OKGo/image/icons/right.png" style="top:7px;position: relative;"><span class="hint-content">成功下单！</span>
		<a href="/OKGo/user/checkOrders.do">点击查看订单详情>></a>
	</div>
</body>
</html>