<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
	<form>
		<table cellpadding="10">
			<tr><td>输入原密码：<td><input type="password" id="oripsw" class="easyui-validatebox" data-options="required:true, validType:['checkOripsw']" >
			<tr><td>输入新密码：<td><input name="password" type="password" id="newpsw" class="easyui-validatebox" data-options="required:true, validType:['password_format', 'password_usable']" maxlength="20">
			<tr><td>新密码确认：<td><input type="password" id="repsw" class="easyui-validatebox" data-options="required:true" validType="password_repeat['#newpsw']" maxlength="20">
			<tr><td colspan="2" align="center"><input type="submit" value="确认修改">
		</table>
	</form>
	
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {
				
			    
				checkOripsw: { 
					validator: function(value, param){
						var response = $.ajax({
							type: "post",
							url: "/OKGo/user/checkOripsw.do",
							async: false,
							data: {
								"oripsw": value
							},
							cache:false
						}).responseText;
						return response == "true";
					},
					message: '原密码输入不正确'
			    },
			    password_format: {
			    	validator: function(value, param){
						return (/^.{6,20}$/).test(value);
					},
					message: '长度只能在6-20个字符之间'
			    },
			    password_usable: {
			    	validator: function(value, param){
						var response = $.ajax({
							type: "post",
							url: "/OKGo/user/checkNewpsw.do",
							async: false,
							data: {
								"newpsw": value
							},
							cache:false
						}).responseText;
						return response == "true";
					},
					message: '新密码不能和原密码相同'
			    },
			    password_repeat: {
			    	validator: function(value, param){
						return value == $(param[0]).val();
					},
					message: '两次密码输入不一致'
			    }
		});
		
		$('form').form({
			url:'/OKGo/user/updatePsw.do',
			onSubmit:function(){
				return $(this).form('validate');
			},
			success:function(data){
				alert("登录密码修改成功！");
				window.location.reload();
			}
		});	
	</script>
</body>
</html>