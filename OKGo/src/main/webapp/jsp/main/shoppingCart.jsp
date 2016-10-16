<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body style="width: 1350px;">
	<div id="home-cart" >
		<label><img src="/OKGo/image/icons/cart.png" class="icon-cart"></label>
		<a href="/OKGo/main/getCartContent.do?method=noajax" id="cart-link" onmouseover="cartHighlight(this)" onmouseout="cartNormal(this)">我的购物车</a>
		<div class="goodsNumInCart" id="goodsNumInCart">${fn:length(sessionScope.shoppingCart) }</div>
	</div>
	<div id="cartContent" >
		<label>最新加入的商品</label>
		<table id="tab-cart-overlook">
			
		</table>
	</div>
	
	<script type="text/javascript">
		$("#home-cart, #cartContent").hover(
		  function () {
			showCartContent();
		  },
		  function () {
			 hideCartContent();
		  }
		);
	
		function cartHighlight(obj){
			$(obj).css("color", "red");
		}
		function cartNormal(obj){
			$(obj).css("color", "black");
		}
		function showCartContent(e){
			$("#cartContent").show();
			if ($("#goodsNumInCart").text() != 0){
				$.ajax({
					type: "post",
					url: "/OKGo/main/getCartContent.do",
					success: function(data){
						var obj = eval("("+data+")");
						for (var i = 0; i < obj.goodsList.length; i++) {
							for (var j = 0; j < obj.purchaseUnits.length; j++) {
								if (obj.purchaseUnits[j].goodsid == obj.goodsList[i].id) {
									$("#tab-cart-overlook").append("<tr class='cart-rows'><td class='cart-goodsunit'><img class='cart-img' src='/OKGo/"+obj.goodsList[i].image+"'></img>\
																	<span class='cart-goodsname'>"+obj.goodsList[i].fullname+"<span>\
																	<td class='cart-attrunit'>￥"+obj.goodsList[i].price+"x"+obj.purchaseUnits[j].amount+"\
																	<br><a href='#' onmouseover='cartDelHightlight(this)' onmouseout='cartDelNormal(this)' onclick='delFromCart(this)'>删除</a>\
																	<input type='hidden' value='"+obj.goodsList[i].id+"'>")
								}
							}
						}
					}
				});
			}
		}
		function hideCartContent(obj){
			$("#cartContent").hide();
			$("#cartContent").children("table").empty();
			
		}
		function cartDelHightlight(obj){
			$(obj).css("color", "red");
		}
		function cartDelNormal(obj){
			$(obj).css("color", "grey");
		}
		function delFromCart(obj){
			$.ajax({
				type: "post",
				url: "/OKGo/main/delFromCart.do",
				data: {
					"goodsid": $(obj).siblings("input").val()
				},
				success: function(){
					window.location.reload();
				}
			})
		}
	</script>
</body>
</html>