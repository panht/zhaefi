<!--#include file="../uc/conn.asp"-->
<%strModuleName="帐号管理"%>
<!--#include file="uc/userright.asp"-->
<%
'保存操作
If request.Form("save") = "保存" Then 
	username=request("username")
	password=request("password")
	action=request("action")

	if action="new" then
		sql="insert into admin(username, [password]) values('" & username & "', '" & password & "')"
	elseif action="edit" then
		sql="update admin set [password]='" & password & "' where username='" & username & "'"
	end If
	response.write sql
	conn.execute(sql)
	conn.close
	response.redirect "adminuserlist.asp"
End If 



id=request("id")
action=request("action")
if action="new" then
	username=id
	password=""
	pagetitle="新建帐号"
elseif action="edit" then
	sql="select * from admin where username='" & id & "'"
	rs.open sql,conn,1,1
	username=rs("username")
	password=rs("password")
	pagetitle="编辑帐号"
	rs.close
elseif action="del" Then
	sql="delete from admin where username='" & id & "'"
	conn.execute(sql)
	conn.close
	response.redirect "adminuserlist.asp"
end if
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
	<div class="c c2 mt10 fs18">帐号管理 - <%=pagetitle%></div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>帐号名称</td>
			<td><input type="text" name="username" size="30" maxlength="30" class="input req-string" value="<%=username%>"<%if action="edit" then response.write " readonly"%> /></td>
		</tr>
		<tr>
			<td>帐号密码</td>
			<td><input type="text" name="password" size="30" maxlength="30" class="input req-string" value="<%=password%>" /></td>
		</tr>
		<tr>
			<td colspan="2" class="c">
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" /> 
				<input type="hidden" value="<%=action%>" name="action" /> 
				<div id="errorDiv" class="error-div"></div>
			</td>
		</tr>
	</table>
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