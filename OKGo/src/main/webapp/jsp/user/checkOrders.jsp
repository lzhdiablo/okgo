<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach items="${inventories }" var="inventory">
		<div class="orders-frame">
			<div class="order-title">
				<span><fmt:formatDate value="${inventory.createdTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>&nbsp;&nbsp;
				订单号：<span id="invid">${inventory.id }</span>&nbsp;&nbsp;
				状态：<span style="color: red;">${inventory.status }</span>&nbsp;&nbsp;
				总金额：<span>￥${inventory.totalPrice }</span>&nbsp;&nbsp;
				收货人：<a href="#" onmouseover="showData()" onmouseout="closeData()">${inventory.address.recipient }</a>
				<div  id="recieveInfo">
					${inventory.address.recipient }<br>
					${inventory.address.address }<br>
					${inventory.address.phone }<br>
				</div>
				<c:choose>
					<c:when test="${inventory.status eq '交易完成' }">
						<a href="#" onclick="delInventory(this)" style="float: right;">删除</a>
					</c:when>
					<c:when test="${inventory.status eq '卖家已发货' }">
						<a href="#" onclick="recieveConfirm(this)" style="float: right;">确认收货</a>
					</c:when>
				</c:choose>
			</div>
			<table style="border-collapse: collapse;width: 100%;">
				<c:forEach items="${inventory.purchaseUnits }" var="purchaseUnit">
					<tr class="purchaserows">
						<td class="purchase-word" align="left" style="width: 550px;"><img src="/OKGo/${purchaseUnit.goods.image }" class="purchase-img"><label style="top:-27px;position: relative;">${purchaseUnit.goods.fullname }</label>
						<td class="purchase-word">￥${purchaseUnit.goods.price } 
						<td class="purchase-word">x${purchaseUnit.amount }
						<td class="purchase-subtotal" >￥<label>${purchaseUnit.totalprice }</label>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:forEach>
	
	<script type="text/javascript">
		function delInventory(obj){
			var id = $(obj).siblings("span#invid").text();
			if (confirm("确定要删除该条订单信息？")) {
				$.ajax({
					type:"post",
					url: "/OKGo/user/delInventory.do",
					data: {
						"id": id
					},
					success: function(){
						alert("订单信息删除成功！");
						window.location.reload();
					}
				});
			}
		}
		function showData()
		{ 
			$("#recieveInfo").css("display", "block");
			$("#recieveInfo").css("left", event.clientX + 30);
			$("#recieveInfo").css("top", event.clientY + 10);
			$("#recieveInfo").css("position", "fixed");
		}
		function closeData(arg)
		{ 
			$("#recieveInfo").css("display", "none");
		}
		function recieveConfirm(obj){
			var id = $(obj).siblings("span#invid").text();
			if (confirm("请再次确认已收到货物？")) {
				$.ajax({
					type:"post",
					url: "/OKGo/user/recieveConfirm.do",
					data: {
						"id": id
					},
					success: function(){
						alert("交易完成！");
						window.location.reload();
					}
				});
			}
		}
	</script>
</body>
</html>