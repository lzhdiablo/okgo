<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<div id="div_search" align="center" class="div_search">
		<input id="input_search" type="text" class="search"><a href="#" class="link-search" onclick="searchKeyWord()">搜索</a>
	</div>
	
	<script type="text/javascript">
		function searchKeyWord(){
			var keyword = document.getElementById("input_search").value;
			location.href = "/OKGo/main/search.do?keyword="+keyword+"";
		}
	</script>
</body>
</html>