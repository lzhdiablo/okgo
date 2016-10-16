<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
<script type="text/javascript" src="/OKGo/easyui/jquery-3.1.0.min.js"></script>
<script type="text/javascript"  src="/OKGo/easyui/jquery.easyui.min.js"></script>   
<link rel="stylesheet" type="text/css"  href="/OKGo/easyui/themes/default/easyui.css">   
<script type="text/javascript"  src="/OKGo/easyui/locale/easyui-lang-zh_CN.js"></script> 
</head>
<body style="height: 1500px;width: 1350px;">
	<div class="mask" id="mask"></div>
	<div class="popup">
		<div class="popup-title">修改地址<a href="#" style="float: right;" onclick="closeAddress()"><img src="/OKGo/image/icons/close.png"></a></div><br><br><br><br>
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
	<jsp:include page="../main/head.jsp"></jsp:include>
	<jsp:include page="search.jsp"></jsp:include>
	<div id="balance-content">
		<div id="pickAddress">
			<label class="balance-titles">选择收货地址</label>
			<table id="tab-addressList" >
				<c:forEach var="i" begin="0" end="${fn:length(addresses)/4}">
					<tr>
						<c:forEach var="j" begin="${i*4}" end="${i*4+3}">
							<c:choose>
								<c:when test="${empty addresses[j]}"></c:when>
								<c:otherwise>
									<td>
										<div class="unit-address" onclick="selectAddress(this)">
											<a href="#" class="addressList-link" >
												<input id="addressid" type="hidden" value="${addresses[j].id}">
												收货人：<span id="recipient">${addresses[j].recipient}</span><br>
												详细地址：<span id="address" style="word-break:break-all;">${addresses[j].address}</span><br>
												手机：<span id="phone">${addresses[j].phone}</span><br>
												邮箱：<span id="email">${addresses[j].email}</span><br>
											</a>	
											<a href="#" onclick="editAddress(this)" class="editAddrTitle">修改</a>
										</div>
									</td>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</tr>
				</c:forEach>
			</table>
			<a href="#" onclick="addAddress()" class="a-addAddress">使用新地址</a>
		</div>
		
		<div id="purchaseList">
			<label class="balance-titles">确认订单信息</label>
			<table id="tab-Invconfirm" style="border-collapse: collapse;">
				<tr>
					<td class="column-name">商品名称
					<td class="filedrow">商品单价
					<td class="filedrow">购买数量
					<td class="filedrow">小计
				</tr>
				<c:forEach items="${purchaseConfirm.goodsList }" var="goods">
					<tr class="purchaserows">
						<td class="purchase-word" align="left"><img src="/OKGo/${goods.image }" class="purchase-img"><label style="top:-27px;position: relative;">${goods.fullname }</label>
						<td class="purchase-word">￥${goods.price } 
						<c:forEach items="${purchaseConfirm.purchaseUnits }" var="purchaseUnit">
							<c:if test="${goods.id eq purchaseUnit.goodsid }">
								<td class="purchase-word">${purchaseUnit.amount }
								<td class="purchase-subtotal" style="color: red;">￥<label>${goods.price * purchaseUnit.amount }</label>
							</c:if>
						</c:forEach>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div id="confirm" >
			合计付款:<label style="color: red;font: 25px Microsoft YaHei;">￥</label><label id="totalprice"></label><br><br>
			寄送至：<label id="address"></label><br><br>
			收货人：<label id="recipient"></label>&nbsp;<label id="phone"></label><br><br>
			<form>
				<input type="hidden" name="totalprice">
				<input type="hidden" name="addressid">
			</form>
		</div>
		<a href="#" id="invSubmit" onclick="invSubmit()">提交订单</a>
		
	</div>
	
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("div.unit-address:eq(0)").css("border-color", "red");
			$("label#address").text($("div.unit-address:eq(0)").children("a.addressList-link").children("span#address").text());
			$("label#recipient").text($("div.unit-address:eq(0)").children("a.addressList-link").children("span#recipient").text());
			$("label#phone").text($("div.unit-address:eq(0)").children("a.addressList-link").children("span#phone").text());
			$("form").children("input[name='addressid']").val($("div.unit-address:eq(0)").children("a.addressList-link").children("input").val());
			
			var totalprice = 0;
			for (var i = 0; i < $(".purchase-subtotal").length; i++) {
				totalprice = totalprice + parseInt($(".purchase-subtotal:eq("+i+")").children("label").text());
			}
			$("label#totalprice").text(totalprice);
			$("form").children("input[name='totalprice']").val(totalprice);
			
		})
		function selectAddress(obj){
			$("div.unit-address").css("border-color", "#d7d7d7");
			$(obj).css("border-color", "red");
			$("label#address").text($(obj).children("a.addressList-link").children("span#address").text());
			$("label#recipient").text($(obj).children("a.addressList-link").children("span#recipient").text());
			$("label#phone").text($(obj).children("a.addressList-link").children("span#phone").text());
			$("form").children("input[name='addressid']").val($(obj).children("a.addressList-link").children("input").val());
		}
		function editAddress(obj){
			var recipient = $(obj).siblings("a").children("span#recipient").text();
			var address = $(obj).siblings("a").children("span#address").text();
			var phone = $(obj).siblings("a").children("span#phone").text();
			var email = $(obj).siblings("a").children("span#email").text();
			var id = $(obj).siblings("a").children("input#addressid").val();
			$("input[name='recipient']").val(recipient);
			$("textarea[name='address']").val(address);
			$("input[name='phone']").val(phone);
			$("input[name='email']").val(email);
			$("input[name='id']").val(id);
			$("form#address").children("a").attr("onclick", "updateAddress()");
			
			$("#mask").css("height", $(document).height());
			$("#mask").css("width", $(document).width());
			$(".popup").show();
		}
		function addAddress(obj){
			$("form#address").children("a").attr("onclick", "insertAddress()");
			$("#mask").css("height", $(document).height());
			$("#mask").css("width", $(document).width());
			$(".popup").show();
		}
		function closeAddress(){
			$("#mask").css("height", 0);
			$("#mask").css("width", 0);
			$(".popup").hide();
			document.getElementById("address").reset();
		}
		function updateAddress(){
			$('form#address').form({
				url:'/OKGo/admin/updateAddress.do',
				onSubmit:function(){
					return $(this).form('validate');
				},
				success:function(data){
					alert("收货地址更新成功！");
					document.getElementById("address").reset();
					window.location.reload();
				}
			}).submit();
		}
		function insertAddress(){
			$('form#address').form({
				url:'/OKGo/admin/addAddress.do',
				onSubmit:function(){
					return $(this).form('validate');
				},
				success:function(data){
					alert("收货地址添加成功！");
					document.getElementById("address").reset();
					window.location.reload();
				}
			}).submit();
		}
		$.extend($.fn.validatebox.defaults.rules, {
		    phone_format: {
		    	validator: function(value, param){
					return (/^1[34578]\d{9}$/).test(value);
				},
				message: '格式有误'
		    }
		});
		function invSubmit(){
			$("form").form({
				url: "/OKGo/main/createOrder.do",
				success:function(data){
					if (data != null && data != ""){
						alert(data);
						location.href = "/OKGo/main/homePage.do";
					}
					else {
						location.href = "/OKGo/jsp/main/createOrder.jsp";
					}
					
				}
			}).submit();
		}
	</script>
</body>
</html>