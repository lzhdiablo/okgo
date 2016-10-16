<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>OKGo.com--OK就购吧！</title>
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
</head>
<body style="width: 1350px;">
	<jsp:include page="head.jsp"></jsp:include>
	<jsp:include page="search.jsp"></jsp:include>
	<jsp:include page="shoppingCart.jsp"></jsp:include>
	<div class="div_category_frame">
		<div class="div_category">
			<ul>
				<li class="li_category_title">全部商品分类
				<c:forEach items="${upperTags }" var="upperTag">
					<li class="li_category" id="${upperTag.id }" onmouseover="showTagList(this)" onmouseout="backToNormal(this)">${upperTag.tagName }
				</c:forEach>
			</ul>
		</div>
	</div>
	<div id="showTags" class="showTags">
		<table id="tb_tags" cellpadding="10" onmouseover="tb_display(this)" onmouseout="tb_hidden(this)"></table>
		<jsp:include page="slideImg.jsp"></jsp:include>
	</div>
	
	<div id="recentlyBrowse" style="float: left; position: relative;">
		<ul>
			<li class="li_category_title">最近浏览
			<li class="li_history">
			<table>
				<c:forEach items="${historyList }" var="historyGoods">
					<tr><td><a href="/OKGo/main/goodsDetail.do?id=${historyGoods.id }" class="historyLink"><img src="/OKGo/${historyGoods.image }" class="historyImg"><br>${historyGoods.fullname }</a>
				</c:forEach>
			</table>
			</li>
		</ul>
	</div>
	
	<div id="hotGoods" style="position: relative; float: left; left: 40px; ">
		<label class="label-hotGoods">热卖推荐</label>
		<table class="tab-goodsList">
			<tr>
			<c:forEach var="i" begin="0" end="${fn:length(hotGoods)}">
				<c:choose>
					<c:when test="${empty hotGoods[i]}"></c:when>
					<c:otherwise>
						<td>
							<div class="div-goodsList" onmouseover="glHightligth(this)" onmouseout="glNormal(this)">
								<a href="/OKGo/main/goodsDetail.do?id=${hotGoods[i].id}" class="goodsList-link">
									<img src="/OKGo/${hotGoods[i].image }" class="goodsList-img"><br>
									<label class="goodsList-priceTag">￥${hotGoods[i].price }</label><br>
									<span class="goodsList-title" style="word-break: break all;">${hotGoods[i].fullname }</span>
								</a>
							</div>
						</td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</table>
	</div>
	
	<div id="specialGoods" style="position: relative; float: left; left: 40px; ">
		<label class="label-specialGoods">今日特价</label>
		<table class="tab-goodsList">
			<tr>
			<c:forEach var="i" begin="0" end="${fn:length(specialGoods)}">
				<c:choose>
					<c:when test="${empty specialGoods[i]}"></c:when>
					<c:otherwise>
						<td>
							<div class="div-goodsList" onmouseover="glHightligth(this)" onmouseout="glNormal(this)">
								<a href="/OKGo/main/goodsDetail.do?id=${specialGoods[i].id}" class="goodsList-link">
									<img src="/OKGo/${specialGoods[i].image }" class="goodsList-img"><br>
									<label class="goodsList-priceTag">￥${specialGoods[i].price }</label><br>
									<span class="goodsList-title" style="word-break: break all;">${specialGoods[i].fullname }</span>
								</a>
							</div>
						</td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</table>
	</div>
</body>
<!-- 直接用$(this)貌似取不到调用函数的元素本身，因此在调用函数值传一个this给函数，也就是将本元素以object的形式
	传给函数，然后在函数体中即可获取到这个元素。
 -->
<script type="text/javascript">
	function showTagList(obj){
		$(document).ready(function(){
			$(obj).attr("class", "hightlight");
			$("#tb_tags").show();
			var uppertagid = $(obj).attr("id");
			$("#tb_tags").empty();			
			$.ajax({
				type: "get",
				url: "/OKGo/main/homePage.do",
				data: {
					"method": "getTags",
					"uppertagid" : uppertagid 
				},
				success: function(data){
					var object = eval("("+data+")");
					for (var i=0; i<object.length; i++) {
						$("#tb_tags").append("<tr><td class='mtags'>"+object[i].tagName+"  > </td><td>");
						for (var j=0; j<object[i].lowerTags.length; j++) {
							$("#tb_tags td:last").append("<a href='/OKGo/main/showGoods.do?lowertag="+object[i].lowerTags[j].tagName+"' style='color: #616161' onmouseover='ltHighlight(this)' onmouseout='ltNormal(this)' onclick='showGoods(this)'>"+object[i].lowerTags[j].tagName+" &nbsp;</a>")
						}
					}
				}
			});
		});
	}
	function ltHighlight(obj){
		$(obj).css("color", "#ff0080");
	}
	function ltNormal(obj){
		$(obj).css("color", "#616161");
	}
	function backToNormal(obj){
		$(document).ready(function(){
			$(obj).attr("class", "li_category");
			$("#tb_tags").hide();
		});
	}
	function tb_display(obj){
		$("#tb_tags").show();
	}
	function tb_hidden(obj){
		$("#tb_tags").hide();
	}
	function glHightligth(obj){
		$(obj).css("border-color", "#c10000");
	}
	function glNormal(obj){
		$(obj).css("border-color", "white");
	}
	
</script>
</html>