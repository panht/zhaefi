<!--#include file="../uc/conn.asp"-->
<%strModuleName="问卷调查"%>
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
	<div class="c c2 fs18"><%=strModuleName%></div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="查询" onClick="window.location.href='?keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="全部" onClick="window.location.href='?'" />
	<input type="button" name="ButtonNew" value="新增" onClick="window.location.href='surveydetail.asp?action=new'" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>主题</div></th> 
			<th><div>问卷时间</div></th>
			<th><div>出题</div></th>
			<th><div>查看结果</div></th>
			<th><div>操作</div></th>
		</tr>
	</thead>
<%
keyword=request("keyword")
sqltext="select * from  research_term where (term_name like '%"&keyword&"%' or foreword like '%"&keyword&"%') order by research_date desc" 
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof Then
	i = 0
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
		i = i + 1
		id = rs("id")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><%=rs("term_name")%></td>
			<td><%=formatdatetime(rs("research_date"),2)%></td>
			<td class="c"><a href="surveyoptionlist.asp?id=<%=id%>&term_name=<%=rs("term_name")%>">出题</a></td>
			<td class="c"><a href="surveyresultlist.asp?id=<%=id%>&term_name=<%=rs("term_name")%>">查看结果</a></td>
			<td class="c">
				<%If rs("isdisp")<>true then%>
					<span class="c1">×</span><a href="surveydetail.asp?action=flagdisplay&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">显示</a> 
				<%else%>
					<span class="c1">√</span><a href="surveydetail.asp?action=flagdisplay&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">隐藏</a>
				<%End If%> | 
				<a href="surveydetail.asp?action=edit&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">编辑</a> | 
				<a href="javascript:if (confirm('确定要删除吗?')){window.location.href='surveydetail.asp?action=del&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>'}">删除</a>
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
		  <td colspan="5"> 
			<%call pageSplit("keyword")%>
		  </td>
		</tr>
		<tr> 
		  <td colspan="5" class="c2"> 
			打勾的问卷将被显示在前台页面。只有一期问卷能被显示。
		  </td>
		</tr>	</tbody>
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