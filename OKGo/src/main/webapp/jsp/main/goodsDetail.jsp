<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>
<script type="text/javascript"  src="/OKGo/easyui/jquery.easyui.min.js"></script>   
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
</head>
<body style="width: 1350px;">
	<jsp:include page="head.jsp"></jsp:include>
	<jsp:include page="search.jsp"></jsp:include>
	<jsp:include page="shoppingCart.jsp"></jsp:include>
	<div style="height: 1px;background-color: grey;top:30px;position: relative;"></div>
	<div class="goodsFrame">
		<img alt="" src="/OKGo/${goods.image }" class="goodsImage">
		<div>
			<label class="goodsName">${goods.fullname }</label><br><br>
			<label class="goodsPrice">价格：<span class="priceTag">￥${goods.price}</span></label><br><br>
			<label class="goodsStock">库存：<span>${goods.stock }</span>件</label>
			<input type="hidden" id="goodsid" value="${goods.id }">
		</div>
	</div>
	
	<div id="div-pnds">
		<form  method="post">
			<a href="#" onclick="subtract()" class="pnds"><img alt="" src="/OKGo/image/icons/subtract.png"></a>
			<input class="input-pnds" id="pnds" maxlength="2" value="1" name="amount">
			<a href="#" onclick="plus()" class="pnds"><img alt="" src="/OKGo/image/icons/plus.png"></a>
			<input type="hidden" value="${goods.id }" name="goodsid">
		</form>
	</div>
	<a id="purchase" href="#" onclick="purchase()">立即购买</a>
	<a id="toCart" href="#" onclick="addToCart()">加入购物车</a>
	
	<script type="text/javascript">
		function plus(){
			var amount = parseInt($("input#pnds").val());
			$("input#pnds").val(amount + 1);
		}
		function subtract(){
			var amount = parseInt($("input#pnds").val());
			if (amount > 1){
				$("input#pnds").val(amount - 1);
			}
		}
		function purchase(){
			$("form").attr("action", "/OKGo/main/buyNow.do")
			$("form").submit();
		}
		function addToCart(){
			$("form").attr("action", "/OKGo/main/addToCart.do")
			$("form").submit();
		}	
		
	</script>
</body>
</html>