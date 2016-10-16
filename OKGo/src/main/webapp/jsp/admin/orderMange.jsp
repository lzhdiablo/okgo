<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/OKGo/css/style.css">
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
	<div id="tb-order">
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-detail" onclick="checkOrder()">查看订单详情</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-pass" onclick="pass()">审核通过</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-send" onclick="delivery()">卖家已发货</a>
		<br>
		<div>
			<span>订单号:</span>
			<input type="text" id="orderid">
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search2" onclick="searchById()"></a>
			&nbsp;
			<span>订单用户名：</span>
			<input type="text" id="usernickname">
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search2" onclick="searchByUserNickname()"></a>
		</div>
		<div >
			
		</div>
	</div>
	
	<div id="w-orderDetail" class="easyui-window" closed="true" title="订单详情" data-options="minimizable:false" style="width:800px;height:400px;padding:10px;">
		<table id="tab-order" style="border-collapse: collapse;width: 100%;">
		</table>
	</div>
	<div id="w-recieveInfo" class="easyui-window" closed="true" title="收货人信息" data-options="minimizable:false" style="width:300px;height:150px;padding:20px;">
	</div>
	
	
	
	<table id="tab-orders" class="easyui-datagrid" fit="true" title="订单管理" iconCls="icon-edit" 
			url="/OKGo/orderManage/selectOrders.do" toolbar="#tb-order"   
			selectOnCheck="true" checkOnSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
				<th field="ck" checkbox="true"></th>
				<th field="id" width="200" align="center">订单号</th>
				<th field="user.nickname" width="200" align="center" formatter="formatUserNickName">订单用户名</th>
				<th field="createdTime" width="200" align="center" formatter="formatTime">创建时间</th>
				<th field="totalPrice" width="100" align="center">总金额</th>
				<th field="address.recipient" width="200" align="center" formatter="formatRecipient">收货人</th>
				<th field="status" width="200" align="center">订单状态</th>
			</tr>
		</thead>
	</table>
	
	<script type="text/javascript">
		function searchById(){
			$("#tab-orders").datagrid("load",{
				orderid: $("#orderid").val()
			});
		}
		function searchByUserNickname(){
			$("#tab-orders").datagrid("load",{
				nickname: $("#usernickname").val()
			});
		}
		function formatUserNickName(val,row){
			return row.user.nickname;
		}
		function formatRecipient(val,row){
			return "<a href='#' onclick='recieveInfo("+row.address.id+")'>"+row.address.recipient+"</a>"
		}
		function formatterDateTime(date) {
		        var datetime = date.getFullYear()
		                + "-"
		                + ((date.getMonth() + 1) > 10 ? (date.getMonth() + 1) : "0"
		                        + (date.getMonth() + 1))
		                + "-"
		                + (date.getDate() < 10 ? "0" + date.getDate() : date
		                        .getDate())
		                + " "
		                + (date.getHours() < 10 ? "0" + date.getHours() : date
		                        .getHours())
		                + ":"
		                + (date.getMinutes() < 10 ? "0" + date.getMinutes() : date
		                        .getMinutes())
		                + ":"
		                + (date.getSeconds() < 10 ? "0" + date.getSeconds() : date
		                        .getSeconds());
		        return datetime;
		}
		function formatTime(val,row){
			var date = new Date(val);
			return formatterDateTime(date);
		}
		function checkOrder(){
			$("#tab-order").empty();
			var row = $("#tab-orders").datagrid("getSelected");
			if (row != null){
				$.ajax({
					type:"post",
					url: "/OKGo/orderManage/checkOrder.do",
					data: {
						"id": row.id
					},
					success: function(data){
						var object = eval("("+data+")");
						for (var i = 0; i < object.length; i++) {
							$("#tab-order").append("<tr>\
									<td class='column-name'>商品名称\
									<td class='filedrow'>商品单价\
									<td class='filedrow'>购买数量\
									<td class='filedrow'>小计\
									<tr class='purchaserows'>\
									<td class='purchase-word' align='left' style='width: 550px;'><img src='/OKGo/"+object[i].goods.image+"' class='purchase-img'><label style='top:-27px;position: relative;'>"+object[i].goods.fullname+"</label>\
									<td class='purchase-word'>￥"+object[i].goods.price+"\
									<td class='purchase-word'>x"+object[i].amount+"\
									<td class='purchase-subtotal'>￥<label>"+object[i].totalprice+"</label>");
						}
						$("#w-orderDetail").window("open");
					}
				});
			}
		}
		function recieveInfo(id){
			$.ajax({
				type: "post",
				url: "/OKGo/orderManage/getAddressDetail.do",
				data: {
					"id": id
				},
				success: function(data){
					var object = eval("("+data+")");
					$("#w-recieveInfo").empty();
					$("#w-recieveInfo").window("open");
					$("#w-recieveInfo").append(""+object.recipient+"<br>"+object.address+"<br>"+object.phone+"<br>"+object.email+"")
				}
			})
		}
		function pass(){
			var row = $("#tab-orders").datagrid("getSelected");
			if (row != null && row.status == '待审核'){
				if (confirm("确定审核通过此订单？")) {
					$.ajax({
						type:"post",
						url: "/OKGo/orderManage/passOrder.do",
						data: {
							"id": row.id
						},
						success: function(){
							alert("订单审核通过！");
							searchById();
						}
					});
				}
			}
		}
		function delivery(){
			var row = $("#tab-orders").datagrid("getSelected");
			if (row != null && row.status == '审核通过'){
				if (confirm("确定修改此订单状态为“卖家已发货”？")) {
					$.ajax({
						type:"post",
						url: "/OKGo/orderManage/delivery.do",
						data: {
							"id": row.id
						},
						success: function(){
							alert("订单状态修改成功！");
							searchById();
						}
					});
				}
			}
			
		}
		
	</script>
</body>
</html>