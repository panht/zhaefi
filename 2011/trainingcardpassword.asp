<!--#include file="uc/conn.asp"-->
<%
If isnull(session("CardNo")) or session("CardNo")="" Then
	response.redirect "default.asp"
end if

'修改密码
if request.form("passwordnew1") <> "" then
	passwordold = request("passwordold")
	passwordnew = request("passwordnew1")
	sql = "select * from trainingcard where cardno='" & session("cardno") & "' and [password]='" & passwordold & "'"
	rs.open sql, conn, 1, 1
	if rs.eof then
	%>
		<script>
			alert("旧密码错误，请重新输入");
		</script>
	<%
		rs.close
	else
		sql = "update trainingcard set [password] = '" & passwordnew & "' where cardno = '" & session("CardNo") & "'"
		conn.execute(sql)
	%>
		<script>
			alert("密码修改成功");
		</script>
	<%
	end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=strTitle%> - 珠海外商投资企业协会</title>
	<meta name="keywords" content="<%=strTitle%> - 珠海外商投资企业协会">
	<meta name="description" content="<%=strTitle%> - 珠海外商投资企业协会">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1" id="form1">
<!--头部-->
<!--#include file="uc/top.asp" -->

<!--中部开始-->
<div class="ma w980">

<!--中部左栏开始-->
<div class="ma w730 fl">
<!--列表开始-->
<div class="article_list mtop10">
    <table cellspacing="0" cellpadding="5px" border="0" id="example" width="100%">
		<tbody>
			<tr><td colspan="2" >
				<div class="article_content" style="border:0;padding:5px;">
					<h1>修改密码</h1>
				</div>
			</td></tr>
			<tr style="line-height:30px"> 
			  <td style="text-align:right">请输入原密码：</td>
			  <td><input type="password" name="passwordold" id="passwordold" /></td>
			</tr>
			<tr style="line-height:30px"> 
			  <td style="text-align:right">请输入新密码：</td>
			  <td><input type="password" name="passwordnew1" id="passwordnew1" /></td>
			</tr>
			<tr style="line-height:30px"> 
			  <td style="text-align:right">请再次输入新密码：</td>
			  <td><input type="password" name="passwordnew2" id="passwordnew2" /></td>
			</tr>
			<tr><td colspan="2" style="text-align:center">
				<input type="button" name="btnChangePassword" id="btnChangePassword" value="确定" />
			</td></tr>
		</tbody>
	</table>
<script>
$(document).ready(function() {
	$("#btnChangePassword").click(function() {
		var passwordold = $("#passwordold").val();
		var passwordnew1 = $("#passwordnew1").val();
		var passwordnew2 = $("#passwordnew2").val();
		
		if (passwordold == "") {
			alert("请输入原密码");
			$("#passwordold")[0].focus();
			return;
		}
		if (passwordnew1 == "") {
			alert("请输入新密码");
			$("#passwordnew1")[0].focus();
			return;
		}
		if (passwordnew2 == "") {
			alert("请再次输入新密码");
			$("#passwordnew2")[0].focus();
			return;
		}
		if (passwordnew1 != passwordnew2) {
			alert("两次新密码必须相同");
			$("#passwordnew1")[0].focus();
			return;
		}
		
		$("#form1").submit();
	});
});
</script>
    <div class="underline_left">
    </div>
</div>
<!--列表结束-->
</div>
<!--左栏结束-->

<!--右栏-->
<!--#include file="userzonemenu.asp" -->
<div style="clear:both; height:0;"></div>
</div>
<!--中部结束-->

<!--底部-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->