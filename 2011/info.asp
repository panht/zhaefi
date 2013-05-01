<!--#include file="uc/conn.asp"-->
<%
flag=request("c")
pink=request("pink")

if flag="news" then
	infotitle = "协会动态"
elseif flag="article" then
	infotitle = "实用文萃"
elseif flag="info" then
	infotitle = "资讯｜焦点"
end If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=infotitle%> - 珠海外商投资企业协会</title>
	<meta name="keywords" content="<%=infotitle%> - 珠海外商投资企业协会">
	<meta name="description" content="<%=infotitle%> - 珠海外商投资企业协会">
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
keyword=Trim(request("keyword"))
if isnull(keyword) then keyword=""
if flag="info" then
	sql="select * from article where art_info_id = 2 and (art_title like '%"& keyword &"%' or art_content like '%"& keyword &"%') order by flag, art_time desc"
ElseIf flag="article" Then
	sql="select * from article where art_info_id = 2 and pink=1 and (art_title like '%"& keyword &"%' or art_content like '%"& keyword &"%') order by flag, art_time desc"
elseif flag="news" then
	sql="select * from article where art_info_id = 0 and (art_title like '%"& keyword &"%' or art_content like '%"& keyword &"%') order by flag, art_time desc"
end if
rs.open sql,conn,1,1
%>
<!--#include file="uc/page.asp"-->
<div class="article_list mtop10">
    <h3><span><em><%=infotitle%></em></span></h3>
    <ul>
<%
if not rs.eof then
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
		art_id = rs("art_id")
		art_title = rs("art_title")
%>
        <li>
			<a href="info_detail.asp?id=<%=art_id%>"><%=art_title%></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime">[<%=formatdatetime(cdate(rs("art_time")), 2)%>]</span>
		</li>
<%
		IF rs.eof THEN exit do
		rowcount = rowcount - 1
		rs.movenext
	loop
end if
rs.close
%>
    </ul>
	<%call pageSplit("keyword,c")%>
	
    <div class="underline_left">
    </div>
</div>
<!--列表结束-->
</div>
<!--左栏结束-->



<!--右栏-->
<!--#include file="uc/sidebar.asp" -->
<div style="clear:both; height:0;"></div>
</div>
<!--中部结束-->



<!--底部-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->