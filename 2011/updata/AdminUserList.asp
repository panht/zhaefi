<!--#include file="../uc/conn.asp"-->
<%strModuleName="�ʺŹ���"%>
<!--#include file="uc/userright.asp"-->
<%
keyword=request("keyword")
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>�麣����Ͷ����ҵЭ��</title>
<!--#include file="uc/static.asp" -->
</head>
<body> 
<form method="post" name="form1">
<!--�˵�-->
<!--#include file="uc/menu.asp" -->

<!--������-->
<div id="mainpanel" class="fl mt10 ml10 wmain">
	<div class="c c2 fs18">�ʺŹ���</div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="��ѯ" onClick="window.location.href='?keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="ȫ��" onClick="window.location.href='?'" />
	<input type="button" name="ButtonNew" value="����" onClick="window.location.href='adminuserdetail.asp?action=new'" />
	<table cellspacing="0" cellpadding="0" border="0" class="tlist">
	<thead>
		<tr>
			<th><div>�ʺ�</div></th>
			<th><div>����</div></th>
			<th><div>Ȩ��</div></th>
			<th><div>����</div></th>
		</tr>
	</thead>
<%
sqltext="select * from admin where (username like '%"&keyword&"%') and username<>'ZHAEFI'"
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof then
	rs.move (page - 1) * rowcount
	i = 0
	do while not rs.eof and rowcount > 0
		i= i+ 1
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><%=rs("username")%></td>
			<td><%=rs("password")%></td>
			<td class="c"><a href="adminuserright.asp?action=edit&id=<%=rs("username")%>">Ȩ��</a></td>
			<td class="c"><a href="adminuserdetail.asp?action=edit&id=<%=rs("username")%>">�޸�</a> | <a href="adminuserdetail.asp?action=del&id=<%=rs("username")%>">ɾ��</a></td>
		</tr>
<%
IF rs.eof THEN exit do
	rowcount = rowcount - 1
	rs.movenext
	loop
end if
rs.close
%>
		<tr> 
		  <td colspan="3"> 
			<%call pageSplit("keyword")%>
		  </td>
		</tr>
	</tbody>
</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 2 });
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->