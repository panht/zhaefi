<!--#include file="uc/conn.asp"-->
<%
flag=request("c")
pink=request("pink")

if flag="news" then
	infotitle = "Э�ᶯ̬"
elseif flag="article" then
	infotitle = "ʵ������"
elseif flag="info" then
	infotitle = "��Ѷ������"
end If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=infotitle%> - �麣����Ͷ����ҵЭ��</title>
	<meta name="keywords" content="<%=infotitle%> - �麣����Ͷ����ҵЭ��">
	<meta name="description" content="<%=infotitle%> - �麣����Ͷ����ҵЭ��">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1">
<!--ͷ��-->
<!--#include file="uc/top.asp" -->


<!--�в���ʼ-->
<div class="ma w980">

<!--�в�������ʼ-->
<div class="ma w730 fl">

<!--�б�ʼ-->
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
<!--�б����-->
</div>
<!--��������-->



<!--����-->
<!--#include file="uc/sidebar.asp" -->
<div style="clear:both; height:0;"></div>
</div>
<!--�в�����-->



<!--�ײ�-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->