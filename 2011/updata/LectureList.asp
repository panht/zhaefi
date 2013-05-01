<!--#include file="../uc/conn.asp"-->
<%
strModuleName="讲座管理"
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
	<div class="c c2 fs18"><%=strModuleName%></div>
	<input type="text" name="keyword" value="<%=keyword%>" />
	<input type="button" name="ButtonSearch" value="查询" onClick="window.location.href='?keyword='+form1.keyword.value" />
	<input type="button" name="ButtonAll" value="全部" onClick="window.location.href='?'" />
	<input type="button" name="ButtonNew" value="新增" onClick="window.location.href='lecturedetail.asp?action=new'" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>主题</div></th> 
			<th><div>价格</div></th>
			<th><div>发布时间</div></th>
			<th><div>报名人数</div></th>
			<th><div>报名表</div></th>
			<th><div>操作</div></th>
		</tr>
	</thead>
<%
Set Rs1 = Server.CreateObject("Adodb.RecordSet")
keyword=request("keyword")
sqltext="select * from Lecture where (Subject like '%"&keyword&"%') order by AddDate desc" 
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
		sSql = "select Count(ID) From LectureSignUp Where LectureID=" & id
		rs1.open sSql, conn, 1, 1
		CountApply = rs1(0)
		rs1.close
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td><%=rs("Subject")%></td>
			<td title="会员企业一人价格 | 会员企业多人价格 | 非会员企业价格"><%=rs("PriceMember")%> | <%=rs("PriceMemberPromotion")%> | <%=rs("Price")%></td>
			<td><%=formatdatetime(rs("AddDate"),2)%></td>
			<td class="c"><%=CountApply%></td>
			<td class="c"><a href="LectureApplyList.asp?id=<%=id%>&name=<%=Server.URLEncode(rs("Subject"))%>">查看</a> | <a href="LectureDownload.asp?id=<%=id%>&Subject=<%=Server.URLEncode(rs("Subject"))%>">下载</a></td>
			<td class="c">
				<%If rs("flagDisplay")<>true then%>
					<span class="c1">×</span><a href="lecturedetail.asp?action=flagdisplay&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">显示</a> 
				<%else%>
					<span class="c1">√</span><a href="lecturedetail.asp?action=flagdisplay&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">隐藏</a>
				<%End If%> | 
				<a href="lecturedetail.asp?action=edit&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>">编辑</a> | 
				<a href="javascript:if (confirm('确定要删除吗?')){window.location.href='lecturedetail.asp?action=del&id=<%=id%>&page=<%=page%>&keyword=<%=keyword%>'}">删除</a>
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