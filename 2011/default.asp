<!--#include file="uc/conn.asp"--><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>�麣����Ͷ����ҵЭ��</title>
	<meta name="keywords" content="�麣����Ͷ����ҵЭ��" />
	<meta name="description" content="�麣����Ͷ����ҵЭ��" />
	<link href="static/css/Style.css" type="text/css" rel="stylesheet" />	
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon" /> 
</head>
<body> 
<form method="post" name="form1">
<!--ͷ��-->
<!--#include file="uc/top.asp" -->


<!--�в���ʼ-->
<div class="ma w980">

<!--�в�������ʼ-->
<div class="ma w730 fl">
<!--<a href=http://www.zhaefi.org/article.asp?id=4389 target=_blank><IMG SRC="/plus/2012happynewyear.jpg" WIDTH="730" HEIGHT="127" BORDER="0" ALT=""></a>
<CENTER><a href=http://www.zhaefi.org/Lecture.asp?id=133 target=_blank><IMG SRC="/plus/image/forum2012.jpg" BORDER="0"></a></CENTER>-->
<!--֪ͨ���濪ʼ-->
<div class="article_list mt10">
    <h3><a title="����" href="channel.asp?c=86"><span><em>�ص�</em></span></a></h3>
    <ul>
<%'����
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
<!--֪ͨ�������-->
<div class="clear"></div>
<!--��Ѷ���㿪ʼ-->
<div class="article_list mt10">
    <h3><a title="����" href="channel.asp?c=93"><span><em>��Ѷ����</em></span></a></h3>
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
<!--��Ѷ�������-->
<!--Э�ᶯ̬��ʼ-->
<div class="article_list mt10">
    <h3><a title="����" href="channel.asp?c=87"><span><em>Э�ᶯ̬</em></span></a></h3>
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
<!--Э�ᶯ̬����-->
<!--���߷��濪ʼ-->
<div class="article_list mt10">
    <h3><a title="����" href="channel.asp?c=83"><span><em>���߷���</em></span></a></h3>
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
<!--���߷������-->
<!--ר�ⱨ����ʼ-->
<div class="article_list mt10">
    <h3><a title="����" href="channel.asp?c=92&m=105&t=ר�ⱨ��"><span><em>ר�ⱨ��</em></span></a></h3>
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
<!--ר�ⱨ������-->
<div class="clear"></div>
<!--ר����ʼ-->
 <div class="area fl w360">
    <h3>
        <a title="����" href="channel.asp?c=92&m=101&t=ר��"><span><em>ר��</em></span>	
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
<!--ר������-->
<!--��Ա������ʼ-->
 <div class="area fl w360 ml10">
    <h3><a title="����" href="channel.asp?c=91"><span><em>��Ա����</em></span></a></h3>
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
<!--��Ա��������-->
<div class="clear"></div>
</div>
<!--�в���������-->



<!--�в�����-->
<!--#include file="uc/sidebar.asp" -->

<div class="clear"></div>
</div>
<!--�в�����-->



<!--�ײ�-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->