<!--#include file="../uc/conn.asp"-->
<%
If request("c")="q" Then
	session("AdminUsername") = ""
End If

If request.Form("signin") = "进入管理区" Then
	username = request.Form("username")
	password = request.Form("password")
	sql="select * from admin where UserName='" & username & "' and [PassWord]='" & password & "'"

	rs.open sql,conn,1,1
	If Not rs.eof Then
		session("AdminUsername") = LCase(username)
		'Session.Timeout [ = nMinutes]
		rs.close
		response.redirect "welcome.asp"
	Else
%>
		<script>
			alert("您输入了错误的帐号或口令，请再次输入！" )
			history.back()
		</script>
<%
		rs.close
		response.end
	end If
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
<form method="post" name="form1" id="form1">
<!--表格-->
<div class="ma c" style="margin-top:150px; width:600px;">
	<table cellspacing="0" cellpadding="0" border="0" class="tlist c form">
	<thead>
		<tr>
			<th colspan="2">
			<img src="/plus/image/emblem_left.jpg"/>
			<div class="c2 fs18" style="padding-top:10px">管理员登录</div>
			</th>
		</tr>
	</thead>	
	<tbody>
		<tr>
			<td width="300px;" style="text-align:right">管理员帐号</td>
			<td><input type="input" name="username" maxlength="20" size="20" class="input req-string" /></td>
		</tr>
		<tr>
			<td style="text-align:right">管理员密码</td>
			<td><input type="password" name="password" maxlength="20" size="20" class="input req-string" /></td>
		</tr>
		<tr>
			<td colspan="2" class="c">
				<input type="submit" name="signin" id="signin" value="进入管理区" /><br/>
				<div id="errorDiv" class="error-div"></div>
			</td>
		</tr>
	</tbody>
</table>
</div>
</form>
<script>
$(document).ready(function(){	
	//表单验证及提交
	$('#signin').formValidator({
		scope : '#form1',
		errorDiv : '#errorDiv'
	});
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->