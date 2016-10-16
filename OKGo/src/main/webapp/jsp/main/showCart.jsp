<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
</head>
<body style="width: 1350px;">
	<jsp:include page="head.jsp"></jsp:include>
	<jsp:include page="search.jsp"></jsp:include>
	<jsp:include page="shoppingCart.jsp"></jsp:include>
	<div class="div_category_frame">
		<div class="div_category">
		</div>
	</div>
	<div style="padding-top: 30px; width: 1175px;">
		<c:choose>
			<c:when test="${empty requestScope.purchaseUnits }">
				<div class="emptyCart">
					<img  src="/OKGo/image/icons/emptycart.png" style="top: 5px; position: relative;">
					购物车内暂时没有商品<a href="/OKGo/main/homePage.do" id="emptyCart-link">去购物</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="div-cartContent" >
					<table id="tab-cartContent" style="border-collapse: collapse; ">
							<tr>
								<td class="column-name">商品名称
								<td class="filedrow">商品单价
								<td class="filedrow">购买数量
								<td class="filedrow">小计
								<td class="filedrow">操作
							</tr>
							<c:forEach items="${requestScope.goodsList }" var="goods">
								<tr class="purchaserows">
									<td class="purchase-word" align="left"><img src="/OKGo/${goods.image }" class="purchase-img"><label style="top:-27px;position: relative;">${goods.fullname }</label>
									<td class="purchase-word" id="price">￥<label>${goods.price }</label>
									<c:forEach items="${requestScope.purchaseUnits }" var="purchaseUnit">
										<c:if test="${goods.id eq purchaseUnit.goodsid }">
											<td class="purchase-word">
												<a href="#" onclick="subtract(this)" class="pnds"><img src="/OKGo/image/icons/subtract.png"></a>
												<input class="input-pnds" id="${purchaseUnit.goodsid }"  maxlength="2" value="${purchaseUnit.amount }" name="amount">
												<a href="#" onclick="plus(this)" class="pnds"><img alt="" src="/OKGo/image/icons/plus.png"></a>
											<td  class="purchase-subtotal">￥<label>${goods.price * purchaseUnit.amount }</label>
											<td class="purchase-word"><a href="#" onclick="delGoods(this)">删除</a>
										</c:if>
									</c:forEach>
								</tr>
							</c:forEach>
						</table>
				</div>
				<div style="width: 300px; float: right;padding-top: 30px;padding-left: 20px; text-align: right;">
					总计:<label style="color: red;font: 25px Microsoft YaHei;">￥</label><label id="totalprice"></label><br><br>
					<a href="/OKGo/main/cartToBalance.do" id="link-toBalance" >去结算</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var totalprice = 0;
			for (var i = 0; i < $(".purchase-subtotal").length; i++) {
				totalprice = totalprice + parseInt($(".purchase-subtotal:eq("+i+")").children("label").text());
			}
			$("label#totalprice").text(totalprice);
			
		})
		function plus(obj){
			var amount = parseInt($(obj).siblings("input").val()) + 1;
			$(obj).siblings("input").val(amount);
			var subtotal = (amount) * parseInt($(obj).parent("td").siblings("#price").children("label").text());
			$(obj).parent("td").siblings(".purchase-subtotal").children("label").text(subtotal);
			
			var totalprice = 0;
			for (var i = 0; i < $(".purchase-subtotal").length; i++) {
				totalprice = totalprice + parseInt($(".purchase-subtotal:eq("+i+")").children("label").text());
			}
			$("label#totalprice").text(totalprice);
			
			$.ajax({
				type: "post",
				url: "/OKGo/main/changeGoodsAmount.do",
				data: {
					"goodsid": $(obj).siblings("input").attr("id"),
					"amount": amount
				}				
			});
			
		}
		function subtract(obj){
			var amount = parseInt($(obj).siblings("input").val());
			if (amount > 1){
				amount = amount - 1;
				$(obj).siblings("input").val(amount);
				var subtotal = (amount) * parseInt($(obj).parent("td").siblings("#price").children("label").text());
				$(obj).parent("td").siblings(".purchase-subtotal").children("label").text(subtotal);
				
				var totalprice = 0;
				for (var i = 0; i < $(".purchase-subtotal").length; i++) {
					totalprice = totalprice + parseInt($(".purchase-subtotal:eq("+i+")").children("label").text());
				}
				$("label#totalprice").text(totalprice);
			}
			$.ajax({
				type: "post",
				url: "/OKGo/main/changeGoodsAmount.do",
				data: {
					"goodsid": $(obj).siblings("input").attr("id"),
					"amount": amount
				}				
			});
		}
		function delGoods(obj){
			$.ajax({
				type: "post",
				url: "/OKGo/main/delFromCart.do",
				data: {
					"goodsid": $(obj).parent("td").siblings("td").has("input").children("input").attr("id")
				},
				success: function(){
					location.href = "/OKGo/main/getCartContent.do?method=noajax"
				}
			})
			
		}
	</script>
</body>
</html>