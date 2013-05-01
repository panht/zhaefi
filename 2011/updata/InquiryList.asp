<!--#include file="../uc/conn.asp"-->
<%strModuleName="热点调查"%>
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
	<input type="button" name="ButtonNew" value="新增" onClick="window.location.href='inquirydetail.asp?action=new'" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>题目</div></th> 
			<th><div>查看统计</div></th>
			<th><div>操作</div></th>
		</tr>
	</thead>
<%
sqltext="select * from research_index order by isdisp desc" 
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof Then
	i = 0
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
		i= i+ 1
		id = rs("id")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><%=rs("Subject")%></td>
			<td class="c"><a href="inquirystat.asp?id=<%=id%>">查看统计</td>
			<td class="c">
				<%If rs("isdisp")<>true then%>
					<span class="c1">×</span><a href="inquirydetail.asp?action=flagdisplay&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">显示</a> 
				<%else%>
					<span class="c1">√</span><a href="inquirydetail.asp?action=flagdisplay&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">隐藏</a>
				<%End If%> | 
				<a href="inquirydetail.asp?action=edit&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">编辑</a> | 
				<a href="javascript:if (confirm('确定要删除吗?')){window.location.href='inquirydetail.asp?action=del&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>'}">删除</a>
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
			<%call pageSplit("")%>
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