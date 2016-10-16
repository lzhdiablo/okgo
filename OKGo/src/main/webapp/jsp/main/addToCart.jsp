<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>
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
		<img src="/OKGo/image/icons/right.png" style="top:7px;position: relative;"><span class="hint-content">商品已成功加入购物车！</span>
		<a href="/OKGo/main/getCartContent.do?method=noajax" class="forwardToCart-link">去购物车结算</a>
	</div>
	<div id="hotGoods" style="top: 80px; position: relative;">
		<label class="label-hotGoods">热卖推荐</label>
		<table class="tab-goodsList">
			<c:forEach var="i" begin="0" end="${fn:length(hotGoods)/5}">
			<tr>
				<c:forEach var="j" begin="${i*5}" end="${i*5+4}">
					<c:choose>
						<c:when test="${empty hotGoods[j]}"></c:when>
						<c:otherwise>
							<td>
								<div class="div-goodsList" onmouseover="glHightligth(this)" onmouseout="glNormal(this)">
									<a href="/OKGo/main/goodsDetail.do?id=${hotGoods[j].id}" class="goodsList-link">
										<img src="/OKGo/${hotGoods[j].image }" class="goodsList-img"><br>
										<label class="goodsList-priceTag">￥${hotGoods[j].price }</label><br>
										<span class="goodsList-title" style="word-break: break all;">${hotGoods[j].fullname }</span>
									</a>
								</div>
							</td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
		</c:forEach>
		</table>
	</div>
	
	<script type="text/javascript">
		function glHightligth(obj){
			$(obj).css("border-color", "#c10000");
		}
		function glNormal(obj){
			$(obj).css("border-color", "white");
		}
	</script>
</body>
</html>