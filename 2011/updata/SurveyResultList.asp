<!--#include file="../uc/conn.asp"-->
<%
strModuleName="�ʾ����"
id=request("id")
term_name=request("term_name")
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
	<div class="c c2 fs18">�鿴������ - <%=term_name%></div>
	<input type="button" name="ButtonReturn" value="����" onClick="window.location.href='surveylist.asp'" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>��Ա����</div></th> 
			<th><div>��д��</div></th>
			<th><div>��дʱ��</div></th>
			<th><div>�鿴</div></th>
		</tr>
	</thead>
<%
sqltext="select * from research_result_main where term_id = "&id&" order by answer_date"
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof Then
	i = 0
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
		i = i + 1
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><%=rs("company")%></td>
			<td><%=rs("name")%></td>
			<td><%=rs("answer_date")%></td>
			<td class="c">
				<a href="surveyresultdetail.asp?action=view&id=<%=id%>&term_name=<%=term_name%>&answer_id=<%=rs("id")%>&answer_date=<%=rs("answer_date")%>">�鿴</a>
			</td>
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
		  <td colspan="4"> 
			<%call pageSplit("id,term_name")%>
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