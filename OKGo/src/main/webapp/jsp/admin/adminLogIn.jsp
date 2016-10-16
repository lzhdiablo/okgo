<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
<title>Insert title here</title>
</head>
<body>
	<div id="admin-logo">
		<a href="/OKGo/main/homePage.do"><img  src="/OKGo/image/logo.jpg"></a>
	</div>
	<div class="admin-logIn-head"></div>
	
	<div id="logIn-frame">
		<div id="logIn-head">管理员登录</div>
		<div id="logIn-status" class="logIn-status">
			<label><img src="/OKGo/image/icons/error.png" class="icon-error"></label>
			<span class="error-message" id="error-message"></span>
		</div>
		<div class="logIn-account" align="center">
			<label><img src="/OKGo/image/icons/account.png" class="icon-logIn"></label>
			<input type="text" id="name" autocomplete="off" onfocus="inputHighlight(this)" onblur="inputBackToNormal(this)" placeholder="用户名">
		</div>
		<div class="logIn-psw" align="center">
			<label><img alt="" src="/OKGo/image/icons/psw.png" class="icon-logIn"></label>
			<input type="password" id="password" autocomplete="off"  onfocus="inputHighlight(this)" onblur="inputBackToNormal(this)" placeholder="密码">
		</div>
		<button id="btn-logIn" class="btn-logIn" onmouseover="btnHighlight(this)" onmouseout="btnBackToNormal(this)">登录</button>
	</div>
</body>

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
			var name = $("#name").val().trim();
			var password = $("#password").val().trim();
			
			if (name == "" && password == "") {
				$("#error-message").text("请输入用户名和密码");
				$("#logIn-status").show();
			}
			else if(name == "") {
				$("#error-message").text("请输入用户名");
				$("#logIn-status").show();
			}
			else if(password == "") {
				$("#error-message").text("请输入密码");
				$("#logIn-status").show();
			}
			else {
				$.ajax({
					url: "/OKGo/adminLogIn.do",
					type: "post",
					data: {
						"name": name,
						"password": password
					},
					success: function(data) {
						if (data == "false") {
							$("#error-message").text("用户名与密码不匹配，请重新输入");
							$("#logIn-status").show();
						}
						else if (data == "true") {
							location.href = "/OKGo/jsp/admin/adminPage.jsp";
						}
					}
				})
			}
		})
	</script>
	

</html>