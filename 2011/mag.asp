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

<!--�`���濪ʼ-->
<div class="article_list mt10">
    <h3><a title="����" href="mag_cover.asp"><span><em>�`����</em></span></a></h3>
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
<!--�`�������-->

<%
'��ȡ���и���ĿΪ�`�Ķ�����Ŀ����������Ŀʱҳ���Զ����
Set rs1 = server.CreateObject("adodb.recordset")
sql1 = "select * from moduletree where parentmodule=92 and modulelevel=2 and id<>96 order by seqno"
rs1.open sql1, conn, 1, 1
Do While Not rs1.eof
	moduleid = rs1("id")
	modulename = rs1("modulename")
%>

<!--������ʼ-->
 <div class="area fl w360">
    <h3>
        <a title="����" href="channel.asp?c=92&m=<%=moduleid%>&t=<%=modulename%>"><span><em><%=modulename%></em></span>
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
<!--��������-->
<%
	rs1.movenext
	If rs1.eof Then Exit Do
	
	moduleid = rs1("id")
	modulename = rs1("modulename")
%>
<!--������ʼ-->
 <div class="area fl w360 ml10">
    <h3>
        <a title="����" href="channel.asp?c=92&m=<%=moduleid%>&t=<%=modulename%>"><span><em><%=modulename%></em></span>
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
<!--��������-->
<div class="clear"></div>

<%
	rs1.movenext
Loop
rs1.close
%>
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