<!--#include file="../uc/conn.asp"-->
<%
module=request("module")
If module = 93 Then
	strModuleName="��Ѷ����"
	strTitle="��Ѷ����"
ElseIf module = 87 Then
	strModuleName="Э�ᶯ̬+��Ա����"
	strTitle="Э�ᶯ̬"
ElseIf module = 91 Then
	strModuleName="Э�ᶯ̬+��Ա����"
	strTitle="��Ա����"
ElseIf module = 92 Then
	strModuleName="�`+ר��+ר��"
	strTitle="�`"
ElseIf module = 89 Then
	strModuleName="�`+ר��+ר��"
	strTitle="ר��"
ElseIf module = 90 Then
	strModuleName="�`+ר��+ר��"
	strTitle="ר��"
ElseIf module = 83 Then
	strModuleName="���߷���"
	strTitle="���߷���"
ElseIf module = 86 Then
	strModuleName="�ص�"
	strTitle="�ص�"
ElseIf module = 85 Then
	strModuleName="��վ��Ϣ"
	strTitle="��վ��Ϣ"
End If

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
	<div class="c c2 fs18"><%=strTitle%></div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="��ѯ" onClick="window.location.href='?module=<%=module%>&keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="ȫ��" onClick="window.location.href='?module=<%=module%>'" />
	<input type="button" name="ButtonNew" value="����" onClick="window.location.href='articledetail.asp?module=<%=module%>&action=new'" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>����</div></th>
			<th><div>���һ</div></th>
			<th><div>����</div></th>
			<th><div>����ʱ��</div></th>
			<th><div>����</div></th>
		</tr>
	</thead>
<%
keyword=request("keyword")
sqltext="select a.*, m1.ModuleName as ModuleName1, m2.ModuleName as ModuleName2 from (article a left join ModuleTree m1 on a.sort_2=m1.id) left join ModuleTree m2 on (a.sort_3=m2.id) where (art_title like '%"&keyword&"%' or art_content like '%"&keyword&"%') and art_info_id=" & module & " order by art_time desc" 
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof then
	rs.move (page - 1) * rowcount
	i = 0
	do while not rs.eof and rowcount > 0
		i= i+ 1
		id = rs("art_id")
		art_title_b = rs("art_title_b")
		art_title_color = rs("art_title_color")
		is_new = rs("is_new")
		member_flag = rs("member_flag")
		flag = rs("flag")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><span class="<%If art_title_b="b" Then response.write "fwb "%> <%=art_title_color%>"><%=rs("art_title")%></span></td>
			<td><%=rs("ModuleName1")%></td>
			<td><%=rs("ModuleName2")%></td>
			<td class="c"><%=rs("art_time")%></td>
			<td class="c">
				<%If is_new<>true then%>
					<span class="c1">��</span><a href="articledetail.asp?action=flagnew&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">New</a> 
				<%else%>
					<span class="c1">��</span><a href="articledetail.asp?action=flagnew&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">Old</a>
				<%End If%> | 
				<%'���߷�����л�Ա�ɿ�ѡ��
				If member_flag<>True And module = 83 then%>
					<span class="c1">��</span><a href="articledetail.asp?action=flagmember&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">��Ա</a> | 
				<%ElseIf  module = 83 then%>
					<span class="c1">��</span><a href="articledetail.asp?action=flagmember&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">ȫ��</a> | 
				<%End If%>
				<%If flag<>true then%>
					<span class="c1">��</span><a href="articledetail.asp?action=flagcomment&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">�Ƽ�</a> 
				<%else%>
					<span class="c1">��</span><a href="articledetail.asp?action=flagcomment&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">ȡ��</a>
				<%End If%> | 
				<a href="articledetail.asp?action=edit&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">�༭</a> | 
				<a href="javascript:if (confirm('ȷ��Ҫɾ����?')){window.location.href='articledetail.asp?action=del&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>'}">ɾ��</a>
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
			<%call pageSplit("keyword,flag,module")%>
		  </td>
		</tr>
	</tbody>
</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion();
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->