<!--#include file="uc/conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=art_title%> - 珠海外商投资企业协会</title>
	<meta name="keywords" content="<%=art_title%> - 珠海外商投资企业协会">
	<meta name="description" content="<%=art_title%> - 珠海外商投资企业协会">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1" id="form1" onSubmit="return chk()">
<!--头部-->
<!--#include file="uc/top.asp" -->


<!--中部开始-->
<div class="ma w980">
<TABLE cellSpacing=0 cellPadding=0 width="900" border=0 align="center"><TBODY>
  <tr> 
	<td> 
<%
keyword=Trim(request("keyword"))
if isnull(keyword) then keyword=""
if keyword<>"" then
	sql="select * from member where (c_name like '%"& keyword &"%' or product like '%"& keyword &"%' or industry like '%"& keyword &"%' or c_country like '%"& keyword &"%') order by comment_flag, id desc"
else
	sql="select * from member where comment_flag=true"
end if
rs.open sql,conn,1,1
%>
<!--#include file="uc/page.asp"-->
<%
if not rs.eof Then	
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
%>
		<div class="bd1 w360 ml10 mt10 fl">
			<table width="100%" border="0" cellspacing="2" cellpadding="5">
				<tr><td class="pl10">编号：<%=rs("login_name")%></td></tr>
				<tr><td class="pl10">行业：<%=rs("industry")%></td></tr>
				<tr><td class="pl10">名称：
				<%If len(session("Username")) > 0 Then %>
					<a href="member_detail.asp?id=<%=rs("id")%>"><%=rs("c_name")%></a>
				<%Else %>
					<%=rs("c_name")%>
				<%End If %>
				</td></tr>
				<tr><td class="pl10">地址：<%=rs("address")%></td></tr>
				<tr><td class="pl10">电话：<%=rs("tel1")%></td></tr>
				<tr><td class="pl10">
				<%If len(session("Username")) > 0 Then %>
					&gt;&gt; <a href="member_detail.asp?id=<%=rs("id")%>">详细信息</a>
				<%Else %>
					<FONT COLOR="#006600">(会员登录后可查看详细信息)</FONT>
				<%End If %>
					</td></tr>
			</table>
		</div>
<%
		rs.movenext
		rowcount = rowcount - 1
		If rs.eof Then Exit Do
%>
		<div class="bd1 w360 ml10 mt10 fl">
			<table width="100%" border="0" cellspacing="2" cellpadding="5">
				<tr><td class="pl10">编号：<%=rs("login_name")%></td></tr>
				<tr><td class="pl10">行业：<%=rs("industry")%></td></tr>
				<tr><td class="pl10">名称：
				<%If len(session("Username")) > 0 Then %>
					<a href="member_detail.asp?id=<%=rs("id")%>"><%=rs("c_name")%></a>
				<%Else %>
					<%=rs("c_name")%>
				<%End If %>
				</td></tr>
				<tr><td class="pl10">地址：<%=rs("address")%></td></tr>
				<tr><td class="pl10">电话：<%=rs("tel1")%></td></tr>
				<tr><td class="pl10">
				<%If len(session("Username")) > 0 Then %>
					&gt;&gt; <a href="member_detail.asp?id=<%=rs("id")%>">详细信息</a>
				<%Else %>
					<FONT COLOR="#006600">(会员登录后可查看详细信息)</FONT>
				<%End If %>
					</td></tr>
			</table>
		</div>
		<div class="clear"></div>
	
<%
		rs.movenext
		rowcount = rowcount - 1
		IF rs.eof THEN exit do
	loop
end if
rs.close
%>
	</TD></TR>
	  <tr> 
		<td bgcolor="#FFFFFF"> 
			<%call pageSplit("keyword")%>
		</td>
	  </tr>
</TBODY></TABLE>
<div class="clear"></div>
</div>
<!--中部结束-->

<!--底部-->
<!--#include file="uc/bottom.asp" -->
</form>
<script src="static/js/jquery.js"></script>
<script>
$(document).ready(function(){
	$(".page_css").removeClass("page_line");
})
</script>
</body></html>
<!--#include file="uc/connfree.asp"-->