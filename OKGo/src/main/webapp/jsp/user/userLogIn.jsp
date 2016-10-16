<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
<title>登录OK购</title>
</head>
<body style="width: 1350px;">
	<jsp:include page="../main/head.jsp"></jsp:include>
	<jsp:include page="../main/search.jsp"></jsp:include>
	<div class="div_category_frame">
		<div class="div_category">
		</div>
	</div>
	
	<div id="logIn-frame">
		<div id="logIn-head">欢迎登录OK购</div>
		<div id="logIn-status" class="logIn-status">
			<label><img src="/OKGo/image/icons/error.png" class="icon-error"></label>
			<span class="error-message" id="error-message">请输入账户名</span>
		</div>
		<div class="logIn-account" align="center">
			<label><img src="/OKGo/image/icons/account.png" class="icon-logIn"></label>
			<input type="text" id="account" autocomplete="off" onfocus="inputHighlight(this)" onblur="inputBackToNormal(this)" placeholder="邮箱/用户名/手机号">
		</div>
		<div class="logIn-psw" align="center">
			<label><img alt="" src="/OKGo/image/icons/psw.png" class="icon-logIn"></label>
			<input type="password" id="password" autocomplete="off"  onfocus="inputHighlight(this)" onblur="inputBackToNormal(this)" placeholder="密码">
		</div>
		<button id="btn-logIn" class="btn-logIn" onmouseover="btnHighlight(this)" onmouseout="btnBackToNormal(this)">登录</button>
	</div>
	<input id="forwardTarget" value="${target}" type="hidden">
	<script type="text/javascript">
		function inputHighlight(obj){
			$(obj).css("border-left-color", "#00ffff");
			$(obj).parent().css("border-color", "#00ffff");
		}
		function inputBackToNormal(obj){
			$(obj).css("border-left-color", "#ccc");
			$(obj).parent().css("border-color", "#ccc");
		}
		function btnHighlight(obj){
			$(obj).css("background-color", "red");
		}
		function btnBackToNormal(obj){
			$(obj).css("background-color", "#a80000");
		}
		
		$("#btn-logIn").click(function(){
			var account = $("#account").val().trim();
			var password = $("#password").val().trim();
			
			if (account == "" && password == "") {
				$("#error-message").text("请输入账户名和密码");
				$("#logIn-status").show();
			}
			else if(account == "") {
				$("#error-message").text("请输入账户名");
				$("#logIn-status").show();
			}
			else if(password == "") {
				$("#error-message").text("请输入密码");
				$("#logIn-status").show();
			}
			else {
				$.ajax({
					url: "http://localhost:8080/OKGo/userlogIn.do",
					type: "post",
					data: {
						"account": account,
						"password": password,
						"target": $("input#forwardTarget").val()
					},
					success: function(data) {
						if (data == "false") {
							$("#error-message").text("账户名与密码不匹配，请重新输入");
							$("#logIn-status").show();
						}
						else {
							location.href = ""+data+"";
						}
					}
				})
			}
		})
		
		
	</script>
	
	
</body>
</html>