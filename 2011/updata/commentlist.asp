<!--#include file="../uc/conn.asp"-->
<%
strModuleName="Э�ᶯ̬"
%>
<!--#include file="uc/userright.asp"-->

<%
id=request("id")
CurrentPage = request("Page")
keyword=request("keyword")
action=request("action")

if action="del" Then
	sql="delete from comment where id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "commentlist.asp?page="&CurrentPage&"&keyword="&keyword
elseif action="delmulti" Then
	sql="delete from comment where id in (" & request("chkValue") & ")"
	'response.write sql
	'response.end
	conn.execute(sql)
	conn.close
	response.redirect "commentlist.asp?page="&CurrentPage&"&keyword="&keyword
elseif action="flagaudit" Then
	sql="update comment set flagaudit = not flagaudit where id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "commentlist.asp?page="&CurrentPage&"&keyword="&keyword
end If
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

<!--���-->
<div class="fl mt10 ml10 wmain">
	<div class="c c2 fs18">���۹���</div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="��ѯ" onClick="window.location.href='?keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="ȫ��" onClick="window.location.href='?'" />
	<input type="button" name="ButtonBatchDelete" value="����ɾ��" onclick="javascript:delmulti();"/>
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th width="15px">ȫѡ<input type="checkbox" value="0"  onclick="javascript:doCheck();" /></th>
			<th width="100px"><div>���±���</div></th> 
			<th><div>�ǳ�</div></th>
			<th><div>����ʱ��</div></th>
			<th><div>��������</div></th>
			<th width="60px"><div>����</div></th>
		</tr>
	</thead>
<%
keyword=request("keyword")
sqltext="select c.*, a.art_title as subjecta from comment c, article a where a.art_id=c.refid and (c.content like '%"&keyword&"%' or c.nickname like '%"&keyword&"%') order by c.timecomment desc"
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
		flagaudit = rs("flagaudit")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><input type="checkbox" value="<%=id%>" /></td>
			<td><a href="../article.asp?id=<%=rs("refid")%>" target="_blank" title="<%=rs("subjecta")%>"><%=Left(rs("subjecta"),20)%></a></td>
			<td><%=rs("nickname")%></td>
			<td class="c"><%=FormatDateTime(rs("timecomment"), vbShortDate)%></td>
			<td><%=replace(rs("content"),chr(13),"<br/>")%></td>
			<td class="c">
				<%If flagaudit<>true then%>
					<span class="c1">��</span><a href="?action=flagaudit&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">��ʾ</a> 
				<%else%>
					<span class="c1">��</span><a href="?action=flagaudit&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">����</a>
				<%End If%>
				<a href="javascript:if (confirm('ȷ��Ҫɾ����?')){window.location.href='?action=del&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>'}">ɾ��</a>
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
		  <td colspan="6"> 
			<%call pageSplit("keyword")%>
		  </td>
		</tr>
	</tbody>
</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 0 });
});

function delmulti(){
	chkValue = "";

	$(":checkbox").each(function(i){
		if($(this).attr("checked")) {
			if (chkValue != ""){
				chkValue += ",";
			}
			chkValue += $(this).attr("value");
		}
	});

	window.location.href='?action=delmulti&chkValue=' + chkValue + '&page=<%=page%>&keyword=<%=keyword%>';
}

function doCheck(){
	$(":checkbox").each(function(i){
		if ($(this).attr("value") != 0){
			$(this).attr("checked", !$(this).attr("checked"));
		}
	});
}
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->