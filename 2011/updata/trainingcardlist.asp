<!--#include file="../uc/conn.asp"-->
<%
strModuleName="ѧϰ��"
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
	<div class="c c2 fs18"><%=strModuleName%></div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="��ѯ" onClick="window.location.href='?keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="ȫ��" onClick="window.location.href='?'" />
	<input type="button" name="ButtonNew" value="����" onClick="window.location.href='trainingcarddetail.asp?action=new'" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>��ҵ����</div></th> 
			<th><div>���</div></th>
			<th><div>����</div></th>
			<th><div>���</div></th>
			<th><div>����ʱ��</div></th>
			<th><div>����</div></th>
		</tr>
	</thead>
<%
keyword=request("keyword")
sqltext="select * from trainingcard where (companyName like '%"&keyword&"%') order by CreateDate desc" 
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof then
	rs.move (page - 1) * rowcount
	i = 0
	do while not rs.eof and rowcount > 0
		i= i+ 1
		id = rs("id")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><%=rs("companyName")%></td>
			<td>
				<%if (rs("CardType") = 1) then
					response.write "��Ա��" 
				elseif (rs("CardType") = 2) then
					response.write "�ǻ�Ա��"
				end if %>
			</td>
			<td><%=rs("CardNo")%></td>
			<td><%=rs("Balance")%></td>
			<td class="c"><%if not isnull(rs("CreateDate")) Then response.write FormatDateTime(rs("CreateDate"), vbShortDate)%></td>
			<td class="c">
				<a href="trainingcarddetail.asp?action=edit&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">�༭</a> | 
				<a href="trainingcardcharge.asp?action=charge&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">��ֵ</a> | 
				<a href="trainingcardhistory.asp?id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">��¼</a> | 
				<a href="javascript:if (confirm('ȷ��Ҫɾ����?')){window.location.href='trainingcarddetail.asp?action=del&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>'}">ɾ��</a>
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
	$( "#accordion" ).accordion({ active: 1 });
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->