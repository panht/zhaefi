<!--#include file="uc/conn.asp"--><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>珠海外商投资企业协会</title>
	<meta name="keywords" content="珠海外商投资企业协会" />
	<meta name="description" content="珠海外商投资企业协会" />
	<link href="static/css/Style.css" type="text/css" rel="stylesheet" />	
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon" /> 
</head>
<body> 
<form method="post" name="form1">
<!--头部-->
<!--#include file="uc/top.asp" -->


<!--中部开始-->
<div class="ma w980">

<!--中部左栏开始-->
<div class="ma w730 fl">

<!--会刊封面开始-->
<div class="article_list mt10">
    <h3><a title="更多" href="mag_cover.asp"><span><em>会刊封面</em></span></a></h3>
    <div style="height:260px; border-left:solid 1px #E1E1E1; border-right:solid 1px #E1E1E1; padding-top:10px">
<%
sql="select top 4 * from article where sort_2=96 order by art_time desc"
rs.open sql, conn, 1, 1
If Not rs.eof Then
	Do While Not rs.eof
%>
    <span class="fl ml10 c" style="height:260px">
        <a href="article.asp?id=<%=rs("art_id")%>"><img <%=Replace(Replace(replace(RegExp_Execute(rs("art_content")),chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", Chr(39))%> width="170px"/><br><%=rs("art_title")%></a>
	</span>
<% 
	rs.movenext
	If rs.eof Then Exit Do
Loop
End If 
rs.close
%>
    </div>
    <div class="underline_left">
    </div>
</div>
<div class="clear"></div>
<!--会刊封面结束-->

<%
'获取所有父栏目为会刊的二级栏目，增加新栏目时页面自动添加
Set rs1 = server.CreateObject("adodb.recordset")
sql1 = "select * from moduletree where parentmodule=92 and modulelevel=2 and id<>96 order by seqno"
rs1.open sql1, conn, 1, 1
Do While Not rs1.eof
	moduleid = rs1("id")
	modulename = rs1("modulename")
%>

<!--左栏开始-->
 <div class="area fl w360">
    <h3>
        <a title="更多" href="channel.asp?c=92&m=<%=moduleid%>&t=<%=modulename%>"><span><em><%=modulename%></em></span>
		</a>
	</h3>
    <ul>
<%
sql="select top 8 * from article where sort_2=" & moduleid & " order by art_time desc, art_id desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><%=FormatArtTitle(rs("art_title"), 20)%></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime"><%=rs("art_time")%></span></li>
<% 
	rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close
%>
    </ul>
    <div class="underline_area">
    </div>
</div>
<!--左栏结束-->
<%
	rs1.movenext
	If rs1.eof Then Exit Do
	
	moduleid = rs1("id")
	modulename = rs1("modulename")
%>
<!--右栏开始-->
 <div class="area fl w360 ml10">
    <h3>
        <a title="更多" href="channel.asp?c=92&m=<%=moduleid%>&t=<%=modulename%>"><span><em><%=modulename%></em></span>
		</a>
	</h3>
    <ul>
<%
sql="select top 8 * from article where sort_2=" & moduleid & " order by art_time desc, art_id desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><%=FormatArtTitle(rs("art_title"), 20)%></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime"><%=rs("art_time")%></span></li>
<% 
	rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close
%>
    </ul>
    <div class="underline_area">
    </div>
</div>
<!--右栏结束-->
<div class="clear"></div>

<%
	rs1.movenext
Loop
rs1.close
%>
</div>
<!--中部左栏结束-->



<!--中部右栏-->
<!--#include file="uc/sidebar.asp" -->

<div class="clear"></div>
</div>
<!--中部结束-->



<!--底部-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->