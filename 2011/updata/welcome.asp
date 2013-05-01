<!--#include file="../uc/conn.asp"-->
<%strModuleName=""%>
<%

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>珠海外商投资企业协会</title>	
<!--#include file="uc/static.asp" -->
</head>
<body> 
<form method="post" name="form1" id="form1">
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--主界面-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 mt10 fs18">欢迎，<%=session("AdminUsername")%></div>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion();
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->