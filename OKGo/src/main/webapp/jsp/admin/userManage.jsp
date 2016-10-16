<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="/OKGo/easyui/jquery.min.js"></script>   
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
<link rel="stylesheet" type="text/css"  href="/OKGo/easyui/themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="/OKGo/easyui/themes/icon.css">   
<link rel="stylesheet" type="text/css" href="/OKGo/easyui/demo/demo.css">    
<script type="text/javascript"  src="/OKGo/easyui/jquery.easyui.min.js"></script>     
<script type="text/javascript"  src="/OKGo/easyui/locale/easyui-lang-zh_CN.js"></script> 	
</head>
<body>
	<div id="tb-user">
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="edit()">修改</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-delete" onclick="del()">删除</a>
		<div >
			<span>用户名：</span>
			<input type="text" id="nickname">
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search2" onclick="doUserSearch()"></a>
		</div>
	</div>
	
	
	<div id="w-add" class="easyui-window" closed="true" title="添加用户" data-options="iconCls:'icon-save',minimizable:false,tools:'#tt'" style="width:500px;height:500px;padding:10px;">
		<form  id="form-add">
			<table class="tb-addUser">
				<tr>
					<td><label for="add-nickname">用户名：</label>
					<td><input id="add-nickname" name="nickname" class="easyui-validatebox" data-options="required:true, validType:['nickname_format', 'nickname_usable']" type="text" maxlength="20">
				</tr>
				<tr>
					<td><label for="add-password">设置密码：</label>
					<td><input id="add-password" name="password" class="easyui-validatebox" data-options="required:true, validType:['password_format']" type="password" maxlength="20">
				</tr>
				<tr>
					<td><label for="add-passwordRepeat">确认密码：</label>
					<td><input id="add-passwordRepeat" name="passwordRepeat" class="easyui-validatebox" data-options="required:true" validType="password_repeat['#add-password']" type="password" maxlength="20">
				</tr>
				<tr>
					<td><label for="add-realname">真实姓名：</label>
					<td><input id="add-realname" name="realname" >
				</tr>
				<tr>
					<td><label for="add-phone">手机：</label>
					<td><input id="add-phone" name="phone" class="easyui-validatebox" data-options="required:true, validType:['phone_format', 'phone_usable']" type="text" maxlength="11">
				</tr>
				<tr>
					<td><label for="add-gender">性别：</label>
					<td><input id="add-gender" name="gender"  required="required"  type="radio" value="男">男
						<input id="gender" name="gender"  required="required"  type="radio" value="女">女
				</tr>
				<tr>
					<td><label for="add-birthday">生日：</label>
					<td><input id="add-birthday" name="birthday" class="easyui-datebox" >
				</tr>
				<tr>
					<td><label for="add-email">邮箱：</label>
					<td><input id="add-email" type="text" name="email" class="easyui-validatebox" data-options="required:true, validType:['email', 'email_usable']">
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="提交">&nbsp;<input type="reset" value="重置">
				</tr>
			</table>
		</form>
	</div>	
	
	
	<div id="w-edit" class="easyui-window" closed="true" title="修改用户" data-options="iconCls:'icon-save',minimizable:false,tools:'#tt'" style="width:500px;height:500px;padding:10px;">
		<form  id="form-edit">
			<table class="tb-addUser">
				<tr>
					<td><label for="edit-nickname">用户名：</label>
					<td><input id="edit-nickname" name="nickname" class="easyui-validatebox" data-options="required:true, validType:['nickname_format', 'nickname_usable']" type="text" maxlength="20">
				</tr>
				<tr>
					<td><label for="edit-password">设置密码：</label>
					<td><input id="edit-password" name="password" class="easyui-validatebox" data-options="required:true, validType:['password_format']" type="password" maxlength="20">
				</tr>
				<tr>
					<td><label for="edit-passwordRepeat">确认密码：</label>
					<td><input id="edit-passwordRepeat" name="passwordRepeat" class="easyui-validatebox" data-options="required:true" validType="password_repeat['#edit-password']" type="password" maxlength="20">
				</tr>
				<tr>
					<td><label for="edit-realname">真实姓名：</label>
					<td><input id="edit-realname" name="realname" >
				</tr>
				<tr>
					<td><label for="edit-phone">手机：</label>
					<td><input id="edit-phone" name="phone" class="easyui-validatebox" data-options="required:true, validType:['phone_format', 'phone_usable']" type="text" maxlength="11">
				</tr>
				<tr>
					<td><label for="edit-gender">性别：</label>
					<td><input id="edit-gender" name="gender"  required="required"  type="radio" value="男">男
						<input id="edit-gender" name="gender"  required="required"  type="radio" value="女">女
				</tr>
				<tr>
					<td><label for="edit-birthday">生日：</label>
					<td><input id="edit-birthday" name="birthday" class="easyui-datebox">
				</tr>
				<tr>
					<td><label for="edit-email">邮箱：</label>
					<td><input id="edit-email" type="text" name="email" class="easyui-validatebox" data-options="required:true, validType:['email', 'email_usable']">
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="更新"><input type="reset" value="重置">
				</tr>
				<tr><td><input type="hidden" id="edit-id" name="id">
			</table>
		</form>
	</div>
	
	<div id="w-addresses" class="easyui-window" closed="true" title="收货地址" data-options="minimizable:false,tools:'#tt'" style="width:500px;height:500px;padding:10px;">
		<div>
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="addAddress()">添加</a>
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="editAddress()">修改</a>
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-delete" onclick="delAddress()">删除</a>
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-refresh" onclick="refreshAddress()">刷新</a>
		</div>
		<div id="d-addresses"></div>
		<input hidden="true" id="userid">
	</div>
	
	<div id="w-edit-address" class="easyui-window" closed="true" title="编辑收货地址" data-options="minimizable:false,tools:'#tt'" style="width:500px;height:300px;padding:10px;">
		<form  id="form-edit-address">
			<table class="tb-editAddress">
				<tr>
					<td><label for="edit-recipient">收货人：</label>
					<td><input id="edit-recipient" name="recipient" class="easyui-validatebox" data-options="required:true" type="text" maxlength="10">
				</tr>
				<tr>
					<td><label for="edit-address">详细地址：</label>
					<td><input id="edit-address" name="address" class="easyui-validatebox" data-options="required:true" type=text maxlength="120" style="width: 400px;">
				</tr>
				<tr>
					<td><label for="edit-addr-phone">手机：</label>
					<td><input id="edit-addr-phone" name="phone" class="easyui-validatebox" data-options="required:true" validType="phone_format" type="text" maxlength="11">
				</tr>
				<tr>
					<td><label for="edit-addr-email">邮箱：</label>
					<td><input id="edit-addr-email" name="email" type="text" class="easyui-validatebox" validType="email">
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="更新"><input type="reset" value="重置">
				</tr>
				<tr><td><input type="hidden" id="edit-addr-id" name="id" >
			</table>
		</form>
	</div>
	
	<div id="w-add-address" class="easyui-window" closed="true" title="增加收货地址" data-options="minimizable:false,tools:'#tt'" style="width:500px;height:300px;padding:10px;">
		<form  id="form-add-address">
			<table class="tb-editAddress">
				<tr>
					<td><label for="add-recipient">收货人：</label>
					<td><input id="add-recipient" name="recipient" class="easyui-validatebox" data-options="required:true" type="text" maxlength="10">
				</tr>
				<tr>
					<td><label for="add-address">详细地址：</label>
					<td><input id="add-address" name="address" class="easyui-validatebox" data-options="required:true" type=text maxlength="40" style="width: 400px;">
				</tr>
				<tr>
					<td><label for="add-addr-phone">手机：</label>
					<td><input id="add-addr-phone" name="phone" class="easyui-validatebox" data-options="required:true" validType="phone_format" type="text" maxlength="11">
				</tr>
				<tr>
					<td><label for="add-addr-email">邮箱：</label>
					<td><input id="add-addr-email" name="email" type="text" class="easyui-validatebox" validType="email">
				</tr>
				<tr><td><input id="add-addr-userid" hidden="true" name="userid">
				<tr>
					<td colspan="2" align="center"><input type="submit" value="提交"><input type="reset" value="重置">
				</tr>
			</table>
		</form>
	</div>
	
	
	
	
	<table id="tab-user" class="easyui-datagrid" fit="true"  title="用户管理" iconCls="icon-edit"
			url="/OKGo/user/userManage.do" toolbar="#tb-user"   selectOnCheck="true" checkOnSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
				<th field="ck" checkbox="true"></th>
				<th field="id" width="80" align="center">编号</th>
				<th field="nickname" width="100" align="center">用户名</th>
				<th field="password" width="100" align="center">密码</th>
				<th field="realname" width="80" align="center">真实姓名</th>
				<th field="phone" width="100" align="center">手机</th>
				<th field="gender" width="60" align="center">性别</th>
				<th field="birthday" width="100" align="center">生日</th>
				<th field="email" width="200" align="center">邮箱</th>
				<th field="checkAddresses" width="100" align="center" formatter="check" >收货地址</th>
			</tr>
		</thead>
	</table>
	
	<script type="text/javascript">
	
	function doUserSearch(){
		$("#tab-user").datagrid("load",{
			pagination: true,
			nickname:$("#nickname").val()
		});
	}
	function check(val, row, index){
		return "<a href='#' onclick='checkAddresses(this)' style='color: blue;'>查看</a>";		
	}
	function add(){
		$("#w-add").window("open");
		
	}
	function edit(){
		var row = $("#tab-user").datagrid("getSelected");
		if (row){
			$("#edit-id").val(row.id);
			$("#edit-nickname").val(row.nickname) ;
			$("#edit-password").val(row.password);
			$("#edit-realname").val(row.realname);
			$("#edit-phone").val(row.phone);
			if (row.gender == '男'){
				$("#edit-gender[value='男']").attr("checked", "checked");
			}
			else if (row.gender == '女'){
				$("#edit-gender[value='女']").attr("checked", "checked");
			}
			$("#edit-email").val(row.email);
			$("#w-edit").window("open");
		}
	}
	$.extend($.fn.validatebox.defaults.rules, {
		
	    nickname_format: { 
			validator: function(value, param){
				return (/^\w[a-zA-Z0-9_-]{4,20}$/).test(value);
			},
			message: '格式错误，仅支持中文、字母、数字、“-”“_”的组合，4-20个字符'
	    },
		nickname_usable: { 
			validator: function(value, param){
				var row = $("#tab-user").datagrid("getSelected");
				if (row != null && row.nickname == value) {
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
	    password_format: {
	    	validator: function(value, param){
				return (/^.{6,20}$/).test(value);
			},
			message: '长度只能在6-20个字符之间'
	    },
	    password_repeat: {
	    	validator: function(value, param){
				return value == $(param[0]).val();
			},
			message: '两次密码输入不一致'
	    },
	    phone_format: {
	    	validator: function(value, param){
				return (/^1[34578]\d{9}$/).test(value);
			},
			message: '格式有误'
	    },
	    phone_usable: { 
			validator: function(value, param){
				var row = $("#tab-user").datagrid("getSelected");
				if (row != null && row.phone == value) {
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
	    		var row = $("#tab-user").datagrid("getSelected");
				if (row != null && row.email == value) {
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
	
	$('#form-add').form({
		url:'/OKGo/admin/add.do',
		onSubmit:function(){
			return $(this).form('validate');
		},
		success:function(data){
			alert("用户信息保存成功！");
			document.getElementById("form-add").reset();
		}
	});
	
	$('#form-edit').form({
		url:'/OKGo/admin/edit.do',
		onSubmit:function(){
			return $(this).form('validate');
		},
		success:function(data){
			alert("用户信息更新成功！");
			document.getElementById("form-edit").reset();
		}
	});
	
	function del(){
		var row = $("#tab-user").datagrid("getSelected");
		if (row != null){
			if(confirm("确定要删除此用户？")) {
				$.ajax({
					url:"/OKGo/admin/delete.do",
					type: "post",
					data: {
						"id": row.id
					},
					success:function(){
						alert("成功删除用户！");
						doSearch();
					}
				});
			}
		}
	}
	
	function checkAddresses(obj){
		var userid = $(obj).parents("tr").children("td:eq(1)").text();
		$("#w-addresses").children("input#userid").val(userid);
		$("#w-addresses").window("open");
		$.ajax({
			type:"post",
			url: "/OKGo/admin/getAddresses.do",
			data: {
				"userid": userid
			},
			success: function(data){
				var object = eval("("+data+")");
				for (var i=0; i<object.length; i++) {
					$("#d-addresses").append("<div class='checkAddresses' onclick='addressHighlight(this)' ondblclick='editAddress(this)' >\
													<table>\
															<tr><td>收货人："+object[i].recipient+"\
															<tr><td>详细地址："+object[i].address+"\
															<tr><td>手机："+object[i].phone+"\
															<tr><td>邮箱："+object[i].email+"\
													</table>\
													<input hidden='true' value='"+object[i].id+"'>\
												</div><br>");
				}
			}
		})
	}
	function addressHighlight(obj){
		$(obj).css("background-color", "yellow");
		$(obj).attr("id", "checked");
		$(obj).siblings("div").attr("id", "");
		$(obj).siblings("div").css("background-color", "transparent");
	}
	function addressBackToNormal(obj){
		$(obj).css("background-color", "transparent");
	}
	$("#w-addresses").dialog({
		onClose:function(){
			$("#d-addresses").empty();
		}
	})
	function editAddress(){
		var obj = $("#d-addresses").children("div#checked");
		var id = obj.children("input").val();
		if (id != null){
			
			$.ajax({
				type: "post",
				url: "/OKGo/admin/getAddress.do",
				data: {
					"id": id
				},
				success: function(data){
					var object = eval("("+data+")");
					$("#w-edit-address").window("open");
					$("#edit-addr-id").val(id);
					$("#edit-recipient").val(object.recipient);
					$("#edit-address").val(object.address);
					$("#edit-addr-phone").val(object.phone);
					$("#edit-addr-email").val(object.email);
				}
			})
		}
	}
	function addAddress(){
		$("input#add-addr-userid").val($("#w-addresses").children("input#userid").val());
		$("#w-add-address").window("open");
	}
	function delAddress(){
		var obj = $("#d-addresses").children("div#checked");
		if (obj != null){
			var id = obj.children("input").val();
			if (confirm("确定要删除这条收货地址？")) {
				$.ajax({
					type: "post",
					url: "/OKGo/admin/delAddress.do",
					data: {
						"id": id
					},
					success: function(data){
						alert("删除成功！");
						refreshAddress();
					}
				});
			}
		}
	}
	function refreshAddress(){
		var userid = $("#w-addresses").children("input#userid").val();
		$("#d-addresses").empty();
		$.ajax({
			type:"post",
			url: "/OKGo/admin/getAddresses.do",
			data: {
				"userid": userid
			},
			success: function(data){
				var object = eval("("+data+")");
				for (var i=0; i<object.length; i++) {
					$("#d-addresses").append("<div class='checkAddresses' onclick='addressHighlight(this)' ondblclick='editAddress(this)' >\
													<table>\
															<tr><td>收货人："+object[i].recipient+"\
															<tr><td>详细地址："+object[i].address+"\
															<tr><td>手机："+object[i].phone+"\
															<tr><td>邮箱："+object[i].email+"\
													</table>\
													<input hidden='true' value='"+object[i].id+"'>\
												</div><br>");
				}
			}
		});
	}
	$('#form-edit-address').form({
		url:'/OKGo/admin/updateAddress.do',
		onSubmit:function(){
			return $(this).form('validate');
		},
		success:function(data){
			alert("收货地址更新成功！");
			document.getElementById("form-edit-address").reset();
			refreshAddress();
		}
	});
	$('#form-add-address').form({
		url:'/OKGo/admin/addAddress.do',
		onSubmit:function(){
			return $(this).form('validate');
		},
		success:function(data){
			alert("收货地址增加成功！");
			document.getElementById("form-add-address").reset();
			refreshAddress();
		}
	});
   
</script>
</body>
</html>