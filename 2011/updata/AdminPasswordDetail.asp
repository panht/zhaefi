<!--#include file="../uc/conn.asp"-->
<%strModuleName="修改密码"%>
<!--#include file="uc/userright.asp"-->
<%
'保存操作
If request.Form("save") = "保存" Then 
	passwordnew=request("passwordnew")
	passwordold=request("passwordold")

	sql="select  * from admin where username='"&session("AdminUsername")&"'"

	rs.open sql,conn,1,1
	If Not rs.eof Then
		pwd = rs("password")
	End If 	
	rs.close

	if pwd <> passwordold Then
		conn.close
%>
		<script>
			alert("旧密码错误，请重新输入！")
			history.back()
		</script>
<%		response.end
	else
		sql="update admin set [password]='"&passwordnew&"' where username='"&session("AdminUsername")&"'"
		conn.execute(sql)
		conn.close
%>
		<script>
			alert("修改成功！")
			history.back()
		</script>
<%
	end if
End If 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>珠海外商投资企业协会</title>	
	<link rel="stylesheet" href="../static/js/ufvalidator/ufvalidator.css" />
<!--#include file="uc/static.asp" -->
	<script src="../static/js/ufvalidator/jquery.ufvalidator.js" type="text/javascript"></script>
</head>
<body> 
<form method="post" name="form1" id="form1" class="">
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--主界面-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 mt10 fs18">修改密码</div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>旧密码</td>
			<td><input type="password" name="passwordold" size="30" maxlength="30" class="input req-string" /></td>
		</tr>
		<tr>
			<td>新密码</td>
			<td><input type="password" name="passwordnew" size="30" maxlength="30" class="input req-same" rel="passwordnew" /></td>
		</tr>
		<tr>
			<td>新密码确认</td>
			<td><input type="password" name="passwordnew2" size="30" maxlength="30" class="input req-same" rel="passwordnew" /></td>
		</tr>
		<tr>
			<td colspan="2" class="c">
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" /> 
				<input type="hidden" value="<%=action%>" name="action" /> 
				<div id="errorDiv" class="error-div"></div>
			</td>
		</tr>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 2 });

	//表单验证及提交
	$('#btnsave').formValidator({
		scope : '#form1',
		errorDiv : '#errorDiv'
	});

	$('#btnreturn').click( function(){
		history.back();
	});
})
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->