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
	<div class="c c2 fs18"><%=strModuleName%> - ���� - <%=term_name%></div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="��ѯ" onClick="window.location.href='?keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="ȫ��" onClick="window.location.href='?'" />
	<input type="button" name="ButtonNew" value="����" onClick="window.location.href='surveyoptiondetail.asp?action=new&id=<%=id%>&term_name=<%=term_name%>'" />
	<input type="button" name="ButtonReturn" value="����" onClick="window.location.href='surveylist.asp'" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>���</div></th> 
			<th><div>��Ŀ</div></th>
			<th><div>�鿴ͳ��</div></th>
			<th><div>����</div></th>
		</tr>
	</thead>
<%
keyword=request("keyword")
sqltext="select * from research where term_id="&id
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof Then
	i = 0
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
		i = i + 1
		sno=rs("sno")
		id_option=rs("id")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><%=sno%></td>
			<td><%=rs("subject")%></td>
			<td class="c"><a href="surveyoptionstat.asp?id=<%=id_option%>">�鿴ͳ��</a></td>
			<td class="c">
				<%If rs("isdisp")<>true then%>
					<span class="c1">��</span><a href="surveyoptiondetail.asp?action=flagdisplay&id=<%=id%>&term_name=<%=term_name%>&id_option=<%=id_option%>&page=<%=page%>&keyword=<%=keyword%>">��ʾ</a> 
				<%else%>
					<span class="c1">��</span><a href="surveyoptiondetail.asp?action=flagdisplay&id=<%=id%>&term_name=<%=term_name%>&id_option=<%=id_option%>&page=<%=page%>&keyword=<%=keyword%>">����</a>
				<%End If%> | 
				<a href="surveyoptiondetail.asp?action=edit&id=<%=id%>&term_name=<%=term_name%>&id_option=<%=id_option%>&page=<%=page%>&keyword=<%=keyword%>">�༭</a> | 
				<a href="javascript:if (confirm('ȷ��Ҫɾ����?')){window.location.href='surveyoptiondetail.asp?action=del&id=<%=id%>&term_name=<%=term_name%>&id_option=<%=id_option%>&page=<%=page%>&keyword=<%=keyword%>'}">ɾ��</a>
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
			<%call pageSplit("keyword,id,term_name")%>
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