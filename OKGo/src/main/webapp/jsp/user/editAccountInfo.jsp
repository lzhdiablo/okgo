<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
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
	<form  id="form-edit">
		<table id="tab-editUser" cellpadding="10">
			<tr>
				<td><span style="color:red">*</span><label for="edit-nickname">用户名：</label>
				<td><input id="${user.nickname }" name="nickname" class="easyui-validatebox" data-options="required:true, validType:['nickname_format', 'nickname_usable']" type="text" maxlength="20" value="${user.nickname }">
			</tr>
			<tr>
				<td><span style="color:red">*</span><label for="edit-realname">真实姓名：</label>
				<td><input id="edit-realname" name="realname"  value="${user.realname }">
			</tr>
			<tr>
				<td><label for="edit-phone">手机：</label>
				<td><input id="${user.phone }" name="phone" class="easyui-validatebox" data-options="required:true, validType:['phone_format', 'phone_usable']" type="text" maxlength="11" value="${user.phone }">
			</tr>
			<tr>
				<td><span style="color:red">*</span><label for="edit-gender">性别：</label>
				<td><input  name="gender"  required="required"  type="radio" value="男"
						<c:if test="${user.gender eq '男' }">checked="checked"</c:if>
					/>男
					<input  name="gender"  required="required"  type="radio" value="女"
						<c:if test="${user.gender eq '女' }">checked="checked"</c:if>
					/>女
			</tr>
			<tr>
				<td><label for="edit-birthday">生日：</label>
				<td><input id="edit-birthday" name="birthday" class="easyui-datebox" value="${user.birthday }" style="height: 30px;">
			</tr>
			<tr>
				<td><label for="edit-email">邮箱：</label>
				<td><input id="${user.email }" type="text" name="email" class="easyui-validatebox" data-options="required:true, validType:['email', 'email_usable']" value="${user.email }">
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="提交">
			</tr>
		</table>
	</form>
	
	<script type="text/javascript">
	$.extend($.fn.validatebox.defaults.rules, {
		    nickname_format: { 
				validator: function(value, param){
					return (/^\w[a-zA-Z0-9_-]{4,20}$/).test(value);
				},
				message: '格式错误，仅支持中文、字母、数字、“-”“_”的组合，4-20个字符'
		    },
			nickname_usable: { 
				validator: function(value, param){
					var currentNickname = $("input[name='nickname']").attr("id");
					if (value == currentNickname) {
						return true;
					}
					else {
						var response = $.ajax({
							type: "post",
							url: "http://localhost:8080/OKGo/registerValidate.do",
							async: false,
							data: {
								"index": 1,
								"nickname": value
							},
							cache:false
						}).responseText;
						return response == "true";
					}
				},
				message: '该用户名已被使用，请重新输入'
		    },
		    phone_format: {
		    	validator: function(value, param){
					return (/^1[34578]\d{9}$/).test(value);
				},
				message: '格式有误'
		    },
		    phone_usable: { 
				validator: function(value, param){
					var currentPhone = $("input[name='phone']").attr("id");
					if (value == currentPhone) {
						return true;
					}
					else {
						var response = $.ajax({
							type: "post",
							url: "http://localhost:8080/OKGo/registerValidate.do",
							async: false,
							data: {
								"index": 2,
								"phone": value
							},
							cache:false
						}).responseText;
						return response == "true";
					}
				},
				message: '该手机号码已被注册'
		    },
		    email_usable:{
		    	validator: function(value, param){
		    		var currentEmail = $("input[name='email']").attr("id");
					if (value == currentEmail) {
						return true;
					}
					else {
						var response = $.ajax({
							type: "post",
							url: "http://localhost:8080/OKGo/registerValidate.do",
							async: false,
							data: {
								"index": 3,
								"email": value
							},
							cache:false
						}).responseText;
						return response == "true";
					}
				},
				message: '该邮箱已被注册'
		    }
		});
	
	$('#form-edit').form({
		url:'/OKGo/user/updateUser.do',
		onSubmit:function(){
			return $(this).form('validate');
		},
		success:function(data){
			alert("用户信息更新成功！");
			window.location.reload();
		}
	});	
	</script>

</body>
</html>