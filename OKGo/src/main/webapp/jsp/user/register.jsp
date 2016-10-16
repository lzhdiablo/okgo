<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>
<title>OK购免费注册</title>
</head>
<body style="width: 1350px;">
	<jsp:include page="../main/head.jsp"></jsp:include>
	<jsp:include page="../main/search.jsp"></jsp:include>
	<div class="div_category_frame">
		<div class="div_category">
		</div>
	</div>
	<div id="register-frame">
		<div id="register-head">欢迎注册</div>
			<form action="/OKGo/register.do" id="form1" method="get">
				<div class="form-item-account" id="form-item-account">
					<label>用	户	名</label>
					<input id="nickname" type="text" name="nickname" class="field" maxlength="20" 
					placeholder="您的账户名和登录名" onblur="nicknameValidate(this)" onkeyup="inputBackToNormal(this)"/>
				</div>
				 <div class="input-tip">
				 	<label><img src="/OKGo/image/icons/error.png" class="icon-error"></label>
                    <span class="error-message"></span>
                </div>
				<div class="form-item-password" id="form-item-password">
					<label>设置密码</label>
					<input id="password" type="password" name="password" class="field" maxlength="20" autocomplete="off" 
					placeholder="建议至少使用两种字符组合" onblur="passwordValidate(this)" onkeyup="inputBackToNormal(this)"/>
				</div>
				 <div class="input-tip">
				 	<label><img src="/OKGo/image/icons/error.png" class="icon-error"></label>
                   <span class="error-message"></span>
                </div>
				<div class="form-item-password" >
					<label>确认密码</label>
					<input id="passwordRepeat" type="password" class="field" maxlength="20" autocomplete="off"  
					placeholder="请再次输入密码" onblur="repeatValidate(this)" onkeyup="inputBackToNormal(this)"/>
				</div>
				 <div class="input-tip">
				 	<label><img src="/OKGo/image/icons/error.png" class="icon-error"></label>
                   <span class="error-message"></span>
                </div>
                <div class="form-item-password" >
					<label>手机号码</label>
					<input id="phone" type="text" name="phone" class="field" maxlength="11" autocomplete="off"  
					placeholder="建议使用常用手机" onblur="phoneValidate(this)" onkeyup="inputBackToNormal(this)"/>
				</div>
				 <div class="input-tip">
                    <label><img src="/OKGo/image/icons/error.png" class="icon-error"></label>
                   <span class="error-message"></span>
                </div>
                <div class="form-item-password" >
					<label>邮箱地址</label>
					<input id="email" type="text" name="email" class="field"  autocomplete="off"  
					placeholder="建议使用常用邮箱" onblur="emailValidate(this)" onkeyup="inputBackToNormal(this)"/>
				</div>
				 <div class="input-tip">
                    <label><img src="/OKGo/image/icons/error.png" class="icon-error"></label>
                   <span class="error-message"></span>
                </div>
				<div class="form-item-captcha" id="form-item-captcha">
					<label>验	证	码</label>
					<input id="captcha" type="text" class="field-captcha" maxlength="6" autocomplete="off"  placeholder="请输入验证码"/>
					<img class="img-captcha" src="/OKGo/captcha?"+Math.random()+"" onclick="nextPic()" id="img-captcha">
				</div>
				<div class="input-tip">
                    <label><img src="/OKGo/image/icons/error.png" class="icon-error"></label>
                   <span class="error-message"></span>
                </div>
			</form>
			<div>
				 <button id="register" class="btn-register" onmouseover="highlight(this)" onmouseout="backToNormal(this)">立即注册</button>
			</div>
	</div>
	
	
	<script type="text/javascript">
		function highlight(obj){
			$(obj).css("background-color", "red");
		}
		function backToNormal(obj){
			$(obj).css("background-color", "#a80000");
		}
		function nextPic(){
			$("#img-captcha").attr("src", "/OKGo/captcha?"+Math.random()+"");
		}
		function inputBackToNormal(obj){
			$(obj).parent().css("border-color", "#dedede");
			$(obj).parent().next("div").css("opacity", "0");
		}
		function nicknameValidate(obj){
			var flag = true;
			var nickname = $("#nickname").val();
			if (nickname.length > 0) {
				if ((/^\w[a-zA-Z0-9_-]{4,20}$/).test(nickname)) {
					$.ajax({
						type: "post",
						url: "http://localhost:8080/OKGo/registerValidate.do",
						async: false,
						data: {
							"index": 1,
							"nickname": nickname
						},
						success: function(data) {
							if (data == "false") {
								$(obj).parent().css("border-color", "red");
								$(obj).parent().next("div").css("opacity", "1");
								$(obj).parent().next("div").children("span").text("该用户名已被使用，请重新输入");
								flag = false;
							}
							if ( data == "true"){
								flag = true;
							}
						}	
					});
				}
				else {
					$(obj).parent().css("border-color", "red");
					$(obj).parent().next("div").css("opacity", "1");
					$(obj).parent().next("div").children("span").text("格式错误，仅支持中文、字母、数字、“-”“_”的组合，4-20个字符");
					flag = false;
				}
			}
			else {
				flag = null;
			}
			return flag;
		}
		
		function passwordValidate(obj){
			var flag = true;
			var password = $("#password").val();
			if (password.length > 0) {
				if (!(/^.{6,20}$/).test(password)) {
					$(obj).parent().css("border-color", "red");
					$(obj).parent().next("div").css("opacity", "1");
					$(obj).parent().next("div").children("span").text("长度只能在6-20个字符之间");
					flag = false;
				}
			}
			else {
				flag = null;
			}
			return flag;
		}
		
		function repeatValidate(obj){
			var flag = true;
			var passwordRepeat = $("#passwordRepeat").val();
			if (passwordRepeat.length > 0) {
				if (passwordRepeat != $("#password").val()) {
					$(obj).parent().css("border-color", "red");
					$(obj).parent().next("div").css("opacity", "1");
					$(obj).parent().next("div").children("span").text("两次密码输入不一致");
					flag = false;
				}
			}
			else {
				flag = null;
			}
			return flag;
		}
		
		function phoneValidate(obj){
			var flag = true;
			var phone = $("#phone").val();
			if (phone.length > 0) {
				if ((/^1[34578]\d{9}$/).test(phone)) {
					$.ajax({
						type: "post",
						url: "http://localhost:8080/OKGo/registerValidate.do",
						async: false,
						data: {
							"index": 2,
							"phone": phone
						},
						success: function(data) {
							if (data == "false") {
								$(obj).parent().css("border-color", "red");
								$(obj).parent().next("div").css("opacity", "1");
								$(obj).parent().next("div").children("span").text("该手机号码已被注册");
								flag = false;
							}
							flag = true;
						}	
					})
				}
				else {
					$(obj).parent().css("border-color", "red");
					$(obj).parent().next("div").css("opacity", "1");
					$(obj).parent().next("div").children("span").text("格式有误");
					flag = false;
				}
			}
			else {
				flag = null;
			}
			return flag;
		}
		
		function emailValidate(obj){
			var flag = true;
			var email = $("#email").val();
			if (email.length > 0) {
				if ((/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/).test(email)) {
					$.ajax({
						type: "post",
						url: "http://localhost:8080/OKGo/registerValidate.do",
						async: false,
						data: {
							"index": 3,
							"email": email
						},
						success: function(data) {
							if (data == "false") {
								$(obj).parent().css("border-color", "red");
								$(obj).parent().next("div").css("opacity", "1");
								$(obj).parent().next("div").children("span").text("该邮箱已被注册");
								flag = false;
							}
							flag = true;
						}	
					})
				}
				else {
					$(obj).parent().css("border-color", "red");
					$(obj).parent().next("div").css("opacity", "1");
					$(obj).parent().next("div").children("span").text("格式有误");
					flag = false;
				}
			}
			else {
				flag = null;
			}
			return flag;
		}
		
		$("#register").click(function(){
			var flag = nicknameValidate($("#nickname"));
			if (flag == null) {
				$("#nickname").parent().css("border-color", "red");
				$("#nickname").parent().next("div").css("opacity", "1");
				$("#nickname").parent().next("div").children("span").text("请输入用户名");
			}
			else if (flag == true) {
				flag = passwordValidate($("#password"));
				if (flag == null) {
					$("#password").parent().css("border-color", "red");
					$("#password").parent().next("div").css("opacity", "1");
					$("#password").parent().next("div").children("span").text("请输入密码");
				}
				else if (flag == true) {
					flag = repeatValidate($("#passwordRepeat"));
					if (flag == null) {
						$("#passwordRepeat").parent().css("border-color", "red");
						$("#passwordRepeat").parent().next("div").css("opacity", "1");
						$("#passwordRepeat").parent().next("div").children("span").text("请再次输入密码");
					}
					else if (flag == true) {
						flag = phoneValidate($("#phone"));
						if (flag == null) {
							$("#phone").parent().css("border-color", "red");
							$("#phone").parent().next("div").css("opacity", "1");
							$("#phone").parent().next("div").children("span").text("请输入手机号码");
						}
						else if (flag == true) {
							flag = emailValidate("#email");
							if (flag == null) {
								$("#email").parent().css("border-color", "red");
								$("#email").parent().next("div").css("opacity", "1");
								$("#email").parent().next("div").children("span").text("请输入邮箱地址");
							}
							else if (flag == true) {
								$.ajax({
									type: "post",
									url: "http://localhost:8080/OKGo/registerValidate.do",
									data: {
										"index": 4,
										"captcha": $("#captcha").val()
									},
									success: function(data){
										if (data == "notpass"){
											$("#captcha").parent().css("border-color", "red");
											$("#captcha").parent().next("div").css("opacity", "1");
											$("#captcha").parent().next("div").children("span").text("验证码不正确");
										}
										if (data == "pass") {
											$("#form1").submit();
										}
									}
								})
							}
						}
					}
				}
			}
		})
		
	
	</script>
	
	
	
</body>
</html>