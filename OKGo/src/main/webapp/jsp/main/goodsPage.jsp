<%@page import="java.util.HashMap"%>
<%@page import="org.apache.ibatis.annotations.ResultMap"%>
<%@page import="com.lzh.entity.Goods"%>
<%@page import="java.util.List"%>
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
</head>
<body style="width: 1350px;">
	<jsp:include page="head.jsp"></jsp:include>
	<jsp:include page="search.jsp"></jsp:include>
	<jsp:include page="shoppingCart.jsp"></jsp:include>
	<div style="height: 1px;background-color: grey;top:30px;position: relative;"></div>
	<div style="float: right; top: 30px; position: relative;">
		<span style="color: #8c8c8c">${resultMap.currentPage}/${resultMap.pageNum}</span>
		<c:choose>
			<c:when test="${resultMap.currentPage eq 1}">
				<a id="prePage" style="color: gray;" class="link-pagination">&lt;</a>
			</c:when>
			<c:otherwise>
				<a id="prePage" class="link-pagination" style="color: #0080ff;" href="/OKGo/main/showGoods.do?lowertag=${resultMap.goodsList[0].lowerTag}&currentPage=${resultMap.currentPage-1}">&lt;</a>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${resultMap.currentPage eq resultMap.pageNum}">
				<a id="nextPage" class="link-pagination" style="color: gray;">></a>
			</c:when>
			<c:otherwise>
				<a id="nextPage" class="link-pagination" style="color: #0080ff;" href="/OKGo/main/showGoods.do?lowertag=${resultMap.goodsList[0].lowerTag}&currentPage=${resultMap.currentPage+1}">></a>
			</c:otherwise>
		</c:choose>
	</div>
	<table class="tab-goodsList">
		<c:forEach var="i" begin="0" end="${fn:length(resultMap.goodsList)/5}">
			<tr>
				<c:forEach var="j" begin="${i*5}" end="${i*5+4}">
					<c:choose>
						<c:when test="${empty resultMap.goodsList[j]}"></c:when>
						<c:otherwise>
							<td>
								<div class="div-goodsList" onmouseover="glHightligth(this)" onmouseout="glNormal(this)">
									<a href="/OKGo/main/goodsDetail.do?id=${resultMap.goodsList[j].id}" class="goodsList-link">
										<img src="/OKGo/${resultMap.goodsList[j].image }" class="goodsList-img"><br>
										<label class="goodsList-priceTag">￥${resultMap.goodsList[j].price }</label><br>
										<span class="goodsList-title" style="word-break: break all;">${resultMap.goodsList[j].fullname }</span>
									</a>
								</div>
							</td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
	<br>
	<div align="center" style="color: #8c8c8c">
		<c:choose>
			<c:when test="${resultMap.currentPage eq 1}">
				<a id="firstPage" style="color: gray;">首页</a>
				<a id="prePage" style="color: gray;">&lt;&lt;上一页</a>
			</c:when>
			<c:otherwise>
				<a id="firstPage" style="color: #0080ff;" href="/OKGo/main/showGoods.do?lowertag=${resultMap.goodsList[0].lowerTag}&currentPage=1">首页</a>
				<a id="prePage" style="color: #0080ff;" href="/OKGo/main/showGoods.do?lowertag=${resultMap.goodsList[0].lowerTag}&currentPage=${resultMap.currentPage-1}">&lt;&lt;上一页</a>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${resultMap.currentPage eq resultMap.pageNum}">
				<a id="nextPage" style="color: gray;">下一页>></a>
				<a id="lastPage" style="color: gray;">末页</a>	
			</c:when>
			<c:otherwise>
				<a id="nextPage" style="color: #0080ff;" href="/OKGo/main/showGoods.do?lowertag=${resultMap.goodsList[0].lowerTag}&currentPage=${resultMap.currentPage+1}">下一页>></a>
				<a id="lastPage" style="color: #0080ff;" href="/OKGo/main/showGoods.do?lowertag=${resultMap.goodsList[0].lowerTag}&currentPage=${resultMap.pageNum}">末页</a>	
			</c:otherwise>
		</c:choose>
			共<span id="pageNum">${resultMap.pageNum}</span>页，到第<input  id="currentPage" value="${resultMap.currentPage}" style="width: 35px;text-align: center"><button  onclick="skipTo(this)" value="${resultMap.pageNum}">确定</button>
	</div>
	<br><br>
	<div style="height: 1px;background-color: grey;"></div>
	<div id="hotGoods">
		<label class="label-hotGoods">热卖商品</label>
		<table class="tab-goodsList">
			<tr>
				<c:forEach var="i" begin="0" end="${fn:length(resultMap.hotGoods)}">
					<c:choose>
						<c:when test="${empty resultMap.hotGoods[i]}"></c:when>
						<c:otherwise>
							<td>
								<div class="div-goodsList" onmouseover="glHightligth(this)" onmouseout="glNormal(this)">
									<a href="/OKGo/main/goodsDetail.do?id=${resultMap.hotGoods[i].id}" class="goodsList-link">
										<img src="/OKGo/${resultMap.hotGoods[i].image }" class="goodsList-img"><br>
										<label class="goodsList-priceTag">￥${resultMap.hotGoods[i].price }</label><br>
										<span class="goodsList-title" style="word-break: break all;">${resultMap.hotGoods[i].fullname }</span>
									</a>
								</div>
							</td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">
		function glHightligth(obj){
			$(obj).css("border-color", "#c10000");
		}
		function glNormal(obj){
			$(obj).css("border-color", "white");
		}
		function skipTo(obj){
			var currentPage = $(obj).siblings("input#currentPage").val();
			var pageNum = $(obj).val();
			if (currentPage > pageNum){
				currentPage = pageNum;
			}
			else if (currentPage < 1){
				currentPage = 1;
			}
			location.href = "/OKGo/main/showGoods.do?lowertag=${resultMap.goodsList[0].lowerTag}&currentPage="+currentPage+"";
		}		
		
	
	</script>
	
</body>
</html>