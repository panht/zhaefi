<!--#include file="../uc/conn.asp"-->
<%
strModuleName="��������"
id=Request("id")
name=Request("name")
%>
<!--#include file="uc/userright.asp"-->
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

<!--���-->
<div class="fl mt10 ml10 wmain">
	<div class="c c2 fs18"><%=strModuleName%> - ����������<br>�������ƣ�<%=name%></div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="��ѯ" onClick="window.location.href='?keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="ȫ��" onClick="window.location.href='?'" />
	<input type="button" name="ButtonReturn" value="����" onClick="window.location.href='lecturelist.asp'">
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>��˾</div></th> 
			<th><div>����</div></th>
			<th><div>ְ��</div></th>
			<th><div>�绰</div></th>
			<th><div>����</div></th>
			<th><div>�ֻ�</div></th> 
			<th><div>��Ӫ��</div></th> 
			<th><div>Email</div></th>
			<th><div>����</div></th>
			<th><div>ʱ��</div></th>
			<th><div>��ע</div></th>
		</tr>
	</thead>
<%
keyword=request("keyword")
sqltext="select * from LectureSignUp where LectureID=" & id & " And (company like '%"&keyword&"%') order by PostDate desc" 
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof Then
	i = 0
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
		i= i+ 1
		id = rs("LectureID")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><%=rs("Company")%></td>
			<td><%=rs("Username")%></td>
			<td><%=rs("Title")%></td>
			<td><%=rs("Tel")%></td>
			<td><%=rs("Fax")%></td>
			<td><%=rs("CellPhone")%></td>
			<td><%=rs("SP")%></td>
			<td><%=rs("Email")%></td>
			<td><%=left(rs("FeeType"),3)%></td>
			<td><%=formatdatetime(rs("PostDate"), 2)%></td>
			<td><%=rs("Remarks")%></td>
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
			<%call pageSplit("keyword,id,name")%>
		  </td>
		</tr>
	</tbody>
</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 1 });
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->