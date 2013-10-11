<!--#include file="uc/conn.asp"-->
<%
If isnull(session("CardNo")) or session("CardNo")="" Then
	response.redirect "default.asp"
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=strTitle%> - 珠海外商投资企业协会</title>
	<meta name="keywords" content="<%=strTitle%> - 珠海外商投资企业协会">
	<meta name="description" content="<%=strTitle%> - 珠海外商投资企业协会">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1">
<!--头部-->
<!--#include file="uc/top.asp" -->


<!--中部开始-->
<div class="ma w980">

<!--中部左栏开始-->
<div class="ma w730 fl">

<!--列表开始-->
<%
sqltext="select * from trainingcard where cardno='" & session("CardNo") & "'"
rs.open sqltext,conn,1,1
if not rs.eof then
trainingcardid =  rs("id")
%>
<table cellspacing="5px" cellpadding="0" border="0" width="100%">
	<tr><td colspan="8" >
        <div class="article_content" style="border:0;padding:5px;">
			<h1>学习卡管理</h1>
		</div>
	</td></tr>
	<tr>
		<td><strong>企业名称</strong>：</td><td><%=rs("companyName")%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;<strong>学习卡号</strong>：</td><td><%=rs("cardno")%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;<strong>学习卡类别</strong>：</td><td>
				<%
				response.write rs("cardtype")
				%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;<strong>余额</strong>：</td><td><span style="color:red"><%=rs("balance")%></span></td>
	</tr>
</table>
<%
end if
rs.close
%>
<div class="article_list mtop10">
    <table cellspacing="0" cellpadding="5px" border="0" id="example" width="100%">
	<thead>
		<tr style="line-height:30px">
			<th width="50px" style="border:solid 1px #CCC"><div>类别</div></th>
			<th width="100px" style="border:solid 1px #CCC"><div>金额</div></th>
			<th width="120px" style="border:solid 1px #CCC"><div>时间</div></th>
			<th style="border:solid 1px #CCC"><div>备注</div></th>
		</tr>
	</thead>
<%
sqltext="select * from trainingcardrecord where trainingcardid=" & trainingcardid & " order by RecordTime desc" 
rs.open sqltext,conn,1,1
%>
<!--#include file="uc/page.asp"-->
<%
if not rs.eof then
	rs.move (page - 1) * rowcount
	i = 0
	do while not rs.eof and rowcount > 0
		i= i+ 1
		id = rs("id")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%> style="line-height:30px">
			<td style="text-align:center">
				<%if (rs("RecordType") = 1) then
					response.write "<span style='color:darkgreen'>充值</span>" 
				elseif (rs("RecordType") = 2) then
					response.write "<span style='color:red'>支付</span>" 
				end if %>
			</td>
			<td style="text-align:right"><%=rs("Amount")%></td>
			<td style="text-align:center"><%if not isnull(rs("RecordTime")) Then response.write FormatDateTime(rs("RecordTime"), vbShortDate)%></td>
			<td><%=rs("Remark")%></td>
		</tr>
<%
		IF rs.eof THEN exit do
		rowcount = rowcount - 1
		rs.movenext
	loop
end if
rs.close
%>
		<tr style="line-height:30px"> 
		  <td colspan="4"> 
			<%call pageSplit("keyword")%>
		  </td>
		</tr>
	</tbody>
</table>
	
    <div class="underline_left">
    </div>
</div>
<!--列表结束-->
</div>
<!--左栏结束-->

<!--右栏-->
<!--#include file="userzonemenu.asp" -->
<div style="clear:both; height:0;"></div>
</div>
<!--中部结束-->



<!--底部-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->