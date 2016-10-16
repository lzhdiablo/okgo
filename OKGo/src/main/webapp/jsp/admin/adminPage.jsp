<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>      
<link rel="stylesheet" type="text/css"  href="/OKGo/easyui/themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="/OKGo/easyui/themes/icon.css">   
<link rel="stylesheet" type="text/css" href="/OKGo/easyui/demo/demo.css">    
<script type="text/javascript"  src="/OKGo/easyui/jquery.easyui.min.js"></script>     
<script type="text/javascript"  src="/OKGo/easyui/locale/easyui-lang-zh_CN.js"></script> 	

<title>OK购后台管理系统</title>
</head>
<body class="easyui-layout">
	<div id="adminPage-head" region="north">
		
	
	</div>
	<div region="west" title="导航菜单" style="width:220px;">
		<div class="easyui-accordion" style="width:auto;height:500px;">
			<div title="用户管理" iconCls="icon-user" style="overflow:auto;padding:10px;">
				<a href="#" class="easyui-linkbutton" style="font-family: MicroSoft YaHei;" plain="true" iconCls="icon-userManage" onclick="addTab('用户管理', 'userManage.jsp', 'icon-userManage')">管理用户</a>	
			</div>
			<div title="商品管理" iconCls="icon-goods"  style="padding:10px;">
				<a href="#" class="easyui-linkbutton" style="font-family: MicroSoft YaHei;" plain="true" iconCls="icon-goodsManage" onclick="addTab('商品管理', 'goodsManage.jsp', 'icon-userManage')">管理商品</a>
			</div>
			<div title="订单管理" iconCls="icon-inventory"  style="padding:10px;">
				<a href="#" class="easyui-linkbutton" style="font-family: MicroSoft YaHei;" plain="true" iconCls="icon-orderManage" onclick="addTab('订单管理', 'orderMange.jsp', 'icon-userManage')">管理订单</a>
			</div>
			<div title="系统管理" iconCls="icon-system"  style="padding:10px;">
				<a href="#" class="easyui-linkbutton" style="font-family: MicroSoft YaHei;" plain="true" iconCls="icon-changePsw" onclick="changePsw()">修改密码</a><br>
				<a href="/OKGo/adminLogOut.do" class="easyui-linkbutton" style="font-family: MicroSoft YaHei;" plain="true" iconCls="icon-logOut" onclick="quit()">安全退出</a>
			</div>
		</div>
	</div>
	
	<div id="w-changePsw" class="easyui-window" closed="true" title="修改密码">
		<form>
		<table cellpadding="10">
			<tr><td>输入原密码：<td><input type="password" id="oripsw" class="easyui-validatebox" data-options="required:true, validType:['checkOripsw']" >
			<tr><td>输入新密码：<td><input name="password" type="password" id="newpsw" class="easyui-validatebox" data-options="required:true, validType:['password_format', 'password_usable']" maxlength="20">
			<tr><td>新密码确认：<td><input type="password" id="repsw" class="easyui-validatebox" data-options="required:true" validType="password_repeat['#newpsw']" maxlength="20">
			<tr><td colspan="2" align="center"><input type="submit" value="确认修改">
		</table>
	</form>
	</div>
	
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" iconCls="icon-home" style="padding:10px;">
				欢迎使用OK购后台管理系统
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function addTab(title, url, icon){
			if ($('#tabs').tabs('exists', title)){
				$('#tabs').tabs('select', title);
			} else {
				var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
				$('#tabs').tabs('add',{
					title:title,
					content:content,
					closable:true,
					iconCls: icon
				});
			}
		}
		function changePsw(){
			$("#w-changePsw").window('open');
		}
		$.extend($.fn.validatebox.defaults.rules, {
			
		    
			checkOripsw: { 
				validator: function(value, param){
					var response = $.ajax({
						type: "post",
						url: "/OKGo/admin/checkOripsw.do",
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
						url: "/OKGo/admin/checkNewpsw.do",
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
			url:'/OKGo/admin/updatePsw.do',
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