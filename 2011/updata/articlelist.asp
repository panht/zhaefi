<!--#include file="../uc/conn.asp"-->
<%
module=request("module")
If module = 93 Then
	strModuleName="资讯焦点"
	strTitle="资讯焦点"
ElseIf module = 87 Then
	strModuleName="协会动态+会员报道"
	strTitle="协会动态"
ElseIf module = 91 Then
	strModuleName="协会动态+会员报道"
	strTitle="会员报道"
ElseIf module = 92 Then
	strModuleName="会刊+专题+专栏"
	strTitle="会刊"
ElseIf module = 89 Then
	strModuleName="会刊+专题+专栏"
	strTitle="专题"
ElseIf module = 90 Then
	strModuleName="会刊+专题+专栏"
	strTitle="专栏"
ElseIf module = 83 Then
	strModuleName="政策法规"
	strTitle="政策法规"
ElseIf module = 86 Then
	strModuleName="重点"
	strTitle="重点"
ElseIf module = 85 Then
	strModuleName="网站信息"
	strTitle="网站信息"
End If

%>
<!--#include file="uc/userright.asp"-->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>珠海外商投资企业协会</title>
<!--#include file="uc/static.asp" -->
</head>
<body> 
<form method="post" name="form1">
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--表格-->
<div class="fl mt10 ml10 wmain">
	<div class="c c2 fs18"><%=strTitle%></div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="查询" onClick="window.location.href='?module=<%=module%>&keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="全部" onClick="window.location.href='?module=<%=module%>'" />
	<input type="button" name="ButtonNew" value="新增" onClick="window.location.href='articledetail.asp?module=<%=module%>&action=new'" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>主题</div></th>
			<th><div>类别一</div></th>
			<th><div>类别二</div></th>
			<th><div>发布时间</div></th>
			<th><div>操作</div></th>
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
					<span class="c1">×</span><a href="articledetail.asp?action=flagnew&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">New</a> 
				<%else%>
					<span class="c1">√</span><a href="articledetail.asp?action=flagnew&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">Old</a>
				<%End If%> | 
				<%'政策法规才有会员可看选项
				If member_flag<>True And module = 83 then%>
					<span class="c1">×</span><a href="articledetail.asp?action=flagmember&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">会员</a> | 
				<%ElseIf  module = 83 then%>
					<span class="c1">√</span><a href="articledetail.asp?action=flagmember&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">全部</a> | 
				<%End If%>
				<%If flag<>true then%>
					<span class="c1">×</span><a href="articledetail.asp?action=flagcomment&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">推荐</a> 
				<%else%>
					<span class="c1">√</span><a href="articledetail.asp?action=flagcomment&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">取消</a>
				<%End If%> | 
				<a href="articledetail.asp?action=edit&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">编辑</a> | 
				<a href="javascript:if (confirm('确定要删除吗?')){window.location.href='articledetail.asp?action=del&module=<%=module%>&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>'}">删除</a>
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