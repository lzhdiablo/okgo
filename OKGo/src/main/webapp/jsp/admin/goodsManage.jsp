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
	<div id="tb-goods">
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="addGoods()">添加</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="editGoods()">修改</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-delete" onclick="delGoods()">删除</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-hot" onclick="setHot()">设置/取消热卖</a>
		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-special" onclick="setSpecial()">设置/取消特价</a>
		<br>
		<div>
			<span>按类查找:</span>
			<select id="select-goods-uppertag" name="uppertag"  class="easyui-validatebox"  onchange="getMiddleTags(this)"><option value="">请选择...</select>
			<select id="select-goods-middletag" name="middletag" class="easyui-validatebox"  onchange="getLowerTags(this)"><option value="">请选择...</select>
			<select id="select-goods-lowertag" name="lowertag" class="easyui-validatebox" ><option value="">请选择...</select>
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search2" onclick="doGoodsSearch()"></a>
			&nbsp;
			<span>商品名称：</span>
			<input type="text" id="goodsname">
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search2" onclick="doGoodsSearch()"></a>
		</div>
		<div >
			
		</div>
	</div>
	
	<div id="w-add-goods" class="easyui-window" closed="true" title="增加商品" data-options="minimizable:false,tools:'#tt'" style="width:500px;height:300px;padding:10px;">
		<form  id="form-add-goods" method="post"  enctype="multipart/form-data">
			<table class="tab-addGoods">
				<tr>
					<td><label for="add-fullname">商品名称：</label>
					<td><input id="add-fullname" name="fullname" class="easyui-validatebox" data-options="required:true" type="text" maxlength="30" style="width: 400px;">
				</tr>
				<tr>
					<td><label for="add-price">价格：</label>
					<td><input id="add-price" name="price" class="easyui-validatebox" data-options="required:true" type=text maxlength="10" >
				</tr>
				<tr>
					<td><label for="add-stock">库存：</label>
					<td><input id="add-stock" name="stock" class="easyui-validatebox" data-options="required:true" type="text" maxlength="5">
				</tr>
				<tr>
					<td><label for="add-image">商品图片：</label>
					<td><input id="add-image" name="image" type="file" class="easyui-validatebox" data-options="required:true">
				</tr>
				<tr>
					<td><label>所属类：</label>
					<td><select id="add-goods-uppertag" name="uppertag"  class="easyui-validatebox" data-options="required:true" onchange="getMiddleTags(this)"><option value="">请选择...</select>
						<select id="add-goods-middletag" name="middletag" class="easyui-validatebox" data-options="required:true" onchange="getLowerTags(this)"><option value="">请选择...</select>
						<select id="add-goods-lowertag" name="lowertag" class="easyui-validatebox" data-options="required:true"><option value="">请选择...</select>
				</tr>
				<br>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="提交"><input type="reset" value="重置">
				</tr>
			</table>
		</form>
	</div>
	
	<div id="w-edit-goods" class="easyui-window" closed="true" title="修改商品" data-options="minimizable:false,tools:'#tt'" style="width:500px;height:300px;padding:10px;">
		<form  id="form-edit-goods" method="post"  enctype="multipart/form-data">
			<table class="tab-addGoods">
				<tr>
					<td><label for="edit-fullname">商品名称：</label>
					<td><input id="edit-fullname" name="fullname" class="easyui-validatebox" data-options="required:true" type="text" maxlength="30" style="width: 400px;">
				</tr>
				<tr>
					<td><label for="edit-price">价格：</label>
					<td><input id="edit-price" name="price" class="easyui-validatebox" data-options="required:true" type=text maxlength="10" >
				</tr>
				<tr>
					<td><label for="edit-stock">库存：</label>
					<td><input id="edit-stock" name="stock" class="easyui-validatebox" data-options="required:true" type="text" maxlength="5">
				</tr>
				<tr>
					<td><label for="edit-image">商品图片：</label>
					<td><input id="edit-image" name="image" type="file" class="easyui-validatebox" data-options="required:true">
				</tr>
				<tr>
					<td><label>所属类：</label>
					<td><select id="edit-goods-uppertag" name="uppertag"  class="easyui-validatebox" data-options="required:true" onchange="getMiddleTags(this)"><option value="">请选择...</select>
						<select id="edit-goods-middletag" name="middletag" class="easyui-validatebox" data-options="required:true" onchange="getLowerTags(this)"><option value="">请选择...</select>
						<select id="edit-goods-lowertag" name="lowertag" class="easyui-validatebox" data-options="required:true"><option value="">请选择...</select>
				</tr>
				<br>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="更新"><input type="reset" value="重置">
				</tr>
				<tr><td><input type="hidden" id="edit-goods-id" name="id">
			</table>
		</form>
	</div>
	
	
	
	<table id="tab-goods" class="easyui-datagrid" fit="true" title="商品管理" iconCls="icon-edit" 
			url="/OKGo/goodsManage/selectGoods.do" toolbar="#tb-goods"   
			selectOnCheck="true" checkOnSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
				<th field="ck" checkbox="true"></th>
				<th field="id" width="60" align="center">编号</th>
				<th field="image" width="270" align="center" formatter="imgType">商品图片</th>
				<th field="fullname" width="300">商品名称</th>
				<th field="price" width="60" align="center">价格</th>
				<th field="stock" width="60" align="center">库存</th>
				<th field="lowerTag" width="60" align="center">所属小类</th>
				<th field="middleTag" width="60" align="center">所属中类</th>
				<th field="upperTag" width="60" align="center">所属大类</th>
				<th field="hot" width="60" align="center">是否热卖</th>
				<th field="special" width="60" align="center">是否特价</th>
			</tr>
		</thead>
	</table>
<script type="text/javascript">
	getUpperTags();
	function doGoodsSearch(){
		$("#tab-goods").datagrid("load",{
			pagination: true,
			goodsname: $("#goodsname").val(),
			uppertag: $("#select-goods-uppertag").val(),
			middletag: $("#select-goods-middletag").val(),
			lowertag: $("#select-goods-lowertag").val()
			
		});
	}
	function imgType(val, row, index){
		return "<img src='/OKGo/"+val+"'></img>";		
	}
	function addGoods(){
		$("#w-add-goods").window("open");
		
	}
	function getUpperTags(){
		$("select[name='uppertag']").html("<option value=''>请选择...");
		$.ajax({
			type: "post",
			url: "/OKGo/goodsManage/getUppertags.do",
			success: function(data){
				var object = eval("("+data+")");
				for (var i = 0; i < object.length; i++) {
					$("select[name='uppertag']").append("<option value='"+object[i].tagName+"'>"+object[i].tagName+"</option>");
				}
			}
		})
	}
	function getMiddleTags(obj){
		var uppertag = $(obj).val();
		$(obj).siblings("select[name='lowertag']").html("<option value=''>请选择...");
		$(obj).siblings("select[name='middletag']").html("<option value=''>请选择...");
		if (uppertag != ''){
			$.ajax({
				type: "post",
				url: "/OKGo/goodsManage/getMiddleTags.do",
				data:{
					"uppertag": uppertag
				},
				success: function(data){
					var object = eval("("+data+")");
					for (var i = 0; i < object.length; i++) {
						$(obj).siblings("select[name='middletag']").append("<option value='"+object[i].tagName+"'>"+object[i].tagName+"</option>");
					}
				}
			})
		}
		
	}
	function getLowerTags(obj){
		var middletag = $(obj).val();
		$(obj).siblings("select[name='lowertag']").html("<option value=''>请选择...");
		if (middletag != ''){
			$.ajax({
				type: "post",
				url: "/OKGo/goodsManage/getLowerTags.do",
				data:{
					"middletag": middletag
				},
				success: function(data){
					var object = eval("("+data+")");
					for (var i = 0; i < object.length; i++) {
						$(obj).siblings("select[name='lowertag']").append("<option value='"+object[i].tagName+"'>"+object[i].tagName+"</option>");
					}
				}
			})
		}
	}
	
	$('#form-add-goods').form({
		url:'/OKGo/goodsManage/addGoods.do',
		onSubmit:function(){
			return $(this).form('validate');
		},
		success:function(data){
			alert("商品增加成功！");
			document.getElementById("form-add-goods").reset();
			doGoodsSearch();
		}
	});
	
	function editGoods(){
		var row = $("#tab-goods").datagrid("getSelected");
		if (row){
			$("#edit-goods-id").val(row.id);
			$("#edit-fullname").val(row.fullname) ;
			$("#edit-price").val(row.price);
			$("#edit-stock").val(row.stock);
			$("#w-edit-goods").window("open");
		}
	}
	$('#form-edit-goods').form({
		url:'/OKGo/goodsManage/editGoods.do',
		onSubmit:function(){
			return $(this).form('validate');
		},
		success:function(data){
			alert("商品信息更新成功！");
			document.getElementById("form-edit-goods").reset();
			doGoodsSearch();
		}
	});
	function delGoods(){
		var row = $("#tab-goods").datagrid("getSelected");
		if (row != null){
			if(confirm("确定要删除此商品？")) {
				$.ajax({
					url:"/OKGo/goodsManage/delGoods.do",
					type: "post",
					data: {
						"id": row.id
					},
					success:function(){
						alert("成功删除商品！");
						doGoodsSearch();
					}
				});
			}
		}
	}
	function setHot(){
		var row = $("#tab-goods").datagrid("getSelected");
		if (row != null){
			var hot = row.hot;
			if (hot == true){
				if (confirm("是否取消热卖？")){
					$.ajax({
						url:"/OKGo/goodsManage/setHot.do",
						type: "post",
						data: {
							"id": row.id,
							"hot": hot
						},
						success:function(){
							alert("成功取消热卖！");
							doGoodsSearch();
						}
					});
				}
			}
			if (hot == false){
				if (confirm("是否设置为热卖？")){
					$.ajax({
						url:"/OKGo/goodsManage/setHot.do",
						type: "post",
						data: {
							"id": row.id,
							"hot": hot
						},
						success:function(){
							alert("成功设置为热卖！");
							doGoodsSearch();
						}
					});
				}
			}
		}
		
	}
	function setSpecial(){
		var row = $("#tab-goods").datagrid("getSelected");
		if (row != null){
			var special = row.special;
			if (special == true){
				if (confirm("是否取消特价？")){
					$.ajax({
						url:"/OKGo/goodsManage/setSpecial.do",
						type: "post",
						data: {
							"id": row.id,
							"special": special
						},
						success:function(){
							alert("成功取消特价！");
							doGoodsSearch();
						}
					});
				}
			}
			if (special == false){
				if (confirm("是否设置为特价？")){
					$.ajax({
						url:"/OKGo/goodsManage/setSpecial.do",
						type: "post",
						data: {
							"id": row.id,
							"special": special
						},
						success:function(){
							alert("成功设置为特价商品！");
							doGoodsSearch();
						}
					});
				}
			}
		}
		
	}
</script>
	

	
</body>
</html>