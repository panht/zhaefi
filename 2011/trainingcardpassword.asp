<!--#include file="uc/conn.asp"-->
<%
If isnull(session("CardNo")) or session("CardNo")="" Then
	response.redirect "default.asp"
end if

'�޸�����
if request.form("passwordnew1") <> "" then
	passwordold = request("passwordold")
	passwordnew = request("passwordnew1")
	sql = "select * from trainingcard where cardno='" & session("cardno") & "' and [password]='" & passwordold & "'"
	rs.open sql, conn, 1, 1
	if rs.eof then
	%>
		<script>
			alert("�������������������");
		</script>
	<%
		rs.close
	else
		sql = "update trainingcard set [password] = '" & passwordnew & "' where cardno = '" & session("CardNo") & "'"
		conn.execute(sql)
	%>
		<script>
			alert("�����޸ĳɹ�");
		</script>
	<%
	end if
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=strTitle%> - �麣����Ͷ����ҵЭ��</title>
	<meta name="keywords" content="<%=strTitle%> - �麣����Ͷ����ҵЭ��">
	<meta name="description" content="<%=strTitle%> - �麣����Ͷ����ҵЭ��">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1" id="form1">
<!--ͷ��-->
<!--#include file="uc/top.asp" -->

<!--�в���ʼ-->
<div class="ma w980">

<!--�в�������ʼ-->
<div class="ma w730 fl">
<!--�б�ʼ-->
<div class="article_list mtop10">
    <table cellspacing="0" cellpadding="5px" border="0" id="example" width="100%">
		<tbody>
			<tr><td colspan="2" >
				<div class="article_content" style="border:0;padding:5px;">
					<h1>�޸�����</h1>
				</div>
			</td></tr>
			<tr style="line-height:30px"> 
			  <td style="text-align:right">������ԭ���룺</td>
			  <td><input type="password" name="passwordold" id="passwordold" /></td>
			</tr>
			<tr style="line-height:30px"> 
			  <td style="text-align:right">�����������룺</td>
			  <td><input type="password" name="passwordnew1" id="passwordnew1" /></td>
			</tr>
			<tr style="line-height:30px"> 
			  <td style="text-align:right">���ٴ����������룺</td>
			  <td><input type="password" name="passwordnew2" id="passwordnew2" /></td>
			</tr>
			<tr><td colspan="2" style="text-align:center">
				<input type="button" name="btnChangePassword" id="btnChangePassword" value="ȷ��" />
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
			alert("������ԭ����");
			$("#passwordold")[0].focus();
			return;
		}
		if (passwordnew1 == "") {
			alert("������������");
			$("#passwordnew1")[0].focus();
			return;
		}
		if (passwordnew2 == "") {
			alert("���ٴ�����������");
			$("#passwordnew2")[0].focus();
			return;
		}
		if (passwordnew1 != passwordnew2) {
			alert("���������������ͬ");
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
<!--�б����-->
</div>
<!--��������-->

<!--����-->
<!--#include file="userzonemenu.asp" -->
<div style="clear:both; height:0;"></div>
</div>
<!--�в�����-->

<!--�ײ�-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->