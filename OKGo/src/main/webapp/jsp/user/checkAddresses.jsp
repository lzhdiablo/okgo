<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="/OKGo/easyui/jquery-3.1.0.min.js"></script>
<script type="text/javascript"  src="/OKGo/easyui/jquery.easyui.min.js"></script>   
<link rel="stylesheet" type="text/css"  href="/OKGo/easyui/themes/default/easyui.css">   
<script type="text/javascript"  src="/OKGo/easyui/locale/easyui-lang-zh_CN.js"></script> 
</head>
<body>
	
	<a href="#" onclick="addAddress()" class="a-addAddress">添加新地址</a>
	<table style="width: 1000px;">
		<c:forEach var="i" begin="0" end="${fn:length(addresses)/3}">
			<tr>
				<c:forEach var="j" begin="${i*3}" end="${i*3+2}">
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
									<a href="#" onclick="delAddress(this)" class="delAddrTitle">删除</a>
								</div>
							</td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
	
	
	<script type="text/javascript">
		function editAddress(obj){
			$(".popup-title").children("span").text("修改地址");	
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
			$(".popup-title").children("span").text("创建新地址");	
			$("form#address").children("a").attr("onclick", "insertAddress()");
			$("#mask").css("height", $(document).height());
			$("#mask").css("width", $(document).width());
			$(".popup").show();
		}
		function delAddress(obj){
			if (confirm("确定要删除该地址条目？")) {
				var id = $(obj).siblings("a").children("input#addressid").val();
				$.ajax({
					type:"post",
					url: "/OKGo/user/delAddress.do",
					data: {
						"id": id
					},
					success: function(){
						alert("地址条目删除成功！");
						window.location.reload();
					}
				});
			}
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
	</script>
</body>
</html>