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
<!--<a href=http://www.zhaefi.org/article.asp?id=4389 target=_blank><IMG SRC="/plus/2012happynewyear.jpg" WIDTH="730" HEIGHT="127" BORDER="0" ALT=""></a>
<CENTER><a href=http://www.zhaefi.org/Lecture.asp?id=133 target=_blank><IMG SRC="/plus/image/forum2012.jpg" BORDER="0"></a></CENTER>-->
<!--通知公告开始-->
<div class="article_list mt10">
    <h3><a title="更多" href="channel.asp?c=86"><span><em>重点</em></span></a></h3>
    <ul>
<%'讲座
	sql="select lectureid, subject, adddate from Lecture where flagdisplay=true order by adddate desc"
rs.open sql,conn,1,1
if rs.recordcount > 0 then
	do while not rs.eof
		subject=rs("subject")
		lectureid=rs("lectureid")
		AddDate=rs("AddDate")
%>
		<li><a href="Lecture.asp?id=<%=cstr(lectureid)%>"><%=subject%></a>
			<span class="datetime fwn c2">[<%=(Year(rs("AddDate")) & "-" & Right("0" & Month(rs("AddDate")), 2) & "-" & Right("0" & Day(rs("AddDate")), 2))%>]</span></li>
<%		rs.movenext
		If rs.eof Then Exit Do
	loop
end if
rs.close

sql="select top 6 * from article where art_info_id=86 order by flag asc, art_time desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><span class="<%If rs("art_title_b")="b" Then response.write "fwb "%> <%=rs("art_title_color")%>"><%=FormatArtTitle(rs("art_title"), 35)%><span></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime fwn c2">[<%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%>]</span></li>
<% rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close
%>
    </ul>
    <div class="underline_left">
    </div>
</div>
<!--通知公告结束-->
<div class="clear"></div>
<!--资讯焦点开始-->
<div class="article_list mt10">
    <h3><a title="更多" href="channel.asp?c=93"><span><em>资讯焦点</em></span></a></h3>
    <ul>
<%
sql="select top 8 * from article where art_info_id=93 order by flag asc, art_time desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><span class="<%If rs("art_title_b")="b" Then response.write "fwb "%> <%=rs("art_title_color")%>"><%=FormatArtTitle(rs("art_title"), 35)%><span></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime fwn c2">[<%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%>]</span></li>
<% rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close
%>
    </ul>
    <div class="underline_left">
    </div>
</div>
<!--资讯焦点结束-->
<!--协会动态开始-->
<div class="article_list mt10">
    <h3><a title="更多" href="channel.asp?c=87"><span><em>协会动态</em></span></a></h3>
    <ul>
<%
sql="select top 5 * from article where art_info_id=87 order by flag asc, art_time desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><span class="<%If rs("art_title_b")="b" Then response.write "fwb "%> <%=rs("art_title_color")%>"><%=FormatArtTitle(rs("art_title"), 40)%><span></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime fwn c2">[<%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%>]</span></li>
<% rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close
%>
    </ul>
    <div class="underline_left">
    </div>
</div>
<!--协会动态结束-->
<!--政策法规开始-->
<div class="article_list mt10">
    <h3><a title="更多" href="channel.asp?c=83"><span><em>政策法规</em></span></a></h3>
    <ul>
<%
sql="select top 8 * from article where art_info_id=83 order by flag asc, art_time desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><span class="<%If rs("art_title_b")="b" Then response.write "fwb "%> <%=rs("art_title_color")%>"><%=FormatArtTitle(rs("art_title"), 40)%><span></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime fwn c2">[<%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%>]</span></li>
<% rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close
%>
    </ul>
    <div class="underline_left">
    </div>
</div>
<!--政策法规结束-->
<!--专题报道开始-->
<div class="article_list mt10">
    <h3><a title="更多" href="channel.asp?c=92&m=105&t=专题报道"><span><em>专题报道</em></span></a></h3>
    <ul style="height:150px;">
<%
sql="select top 2 * from article where sort_2=105 order by flag asc, art_time desc"
rs.open sql, conn, 1, 1
i=0
Do While Not rs.eof
	i=i+1
%>        
        <li class="fl" style="height:180px; width:320px; <%If i=2 Then response.write "margin-left:10px;"%>"><a href="article.asp?id=<%=rs("art_id")%>"><span class="fs_18 fwb"><%=rs("art_title")%></span><br/><span class="fwn"><%=FormatArtTitle(RegExp_FilterHtml(rs("art_content")), 180)%></span></a></li>
<% 
	rs.movenext
	If rs.eof  Or i=2 Then Exit Do
Loop
rs.close
%>
    </ul>
    <div class="underline_left">
    </div>
</div>
<!--专题报道结束-->
<div class="clear"></div>
<!--专栏开始-->
 <div class="area fl w360">
    <h3>
        <a title="更多" href="channel.asp?c=92&m=101&t=专栏"><span><em>专栏</em></span>	
		</a>
	</h3>
    <ul>
<%
sql="select top 8 * from article where sort_2=101 order by flag asc, art_time desc, art_id desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><span class="<%If rs("art_title_b")="b" Then response.write "fwb "%> <%=rs("art_title_color")%>"><%=FormatArtTitle(rs("art_title"), 20)%><span></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime fwn c2"><%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%></span></li>
<% rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close
%>
	</ul>
    <div class="underline_area">
    </div>
</div>
<!--专栏结束-->
<!--会员报道开始-->
 <div class="area fl w360 ml10">
    <h3><a title="更多" href="channel.asp?c=91"><span><em>会员报道</em></span></a></h3>
    <ul>
<%
sql="select top 8 * from article where art_info_id=91 order by flag asc, art_time desc, art_id desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><span class="<%If rs("art_title_b")="b" Then response.write "fwb "%> <%=rs("art_title_color")%>"><%=FormatArtTitle(rs("art_title"), 20)%><span></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime fwn c2"><%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%></span></li>
<% rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close
%>
    </ul>
    <div class="underline_area">
    </div>
</div>
<!--会员报道结束-->
<div class="clear"></div>
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