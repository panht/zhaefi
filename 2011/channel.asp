<!--#include file="uc/conn.asp"-->
<%
c=request("c")
m=request("m")
If c = 93 Then
	strTitle="��Ѷ����"
ElseIf c = 87 Then
	strTitle="Э�ᶯ̬"
ElseIf c = 91 Then
	strTitle="��Ա����"
ElseIf c = 92 Then
	strTitle="�`"
ElseIf c = 89 Then
	strTitle="ר��"
ElseIf c = 90 Then
	strTitle="ר��"
ElseIf c = 83 Then
	strTitle="���߷���"
ElseIf c = 86 Then
	strTitle="�ص�"
ElseIf c = 85 Then
	strTitle="��վ��Ϣ"
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=strTitle%> - �麣����Ͷ����ҵЭ��</title>
	<meta name="keywords" content="<%=strTitle%> - �麣����Ͷ����ҵЭ��">
	<meta name="description" content="<%=strTitle%> - �麣����Ͷ����ҵЭ��">
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
sql="select * from article where art_info_id = " & c & " and (art_title like '%"& keyword &"%' or art_content like '%"& keyword &"%') order by flag, art_time desc"
If c=83 And m > 0 Then
	sql = "select * from article where art_info_id = " & c & " and (art_title like '%"& keyword &"%' or art_content like '%"& keyword &"%') and (sort_2=" & m & " or sort_3 = " & m & ") order by flag, art_time desc" 
ElseIf c=92 And m > 0 Then
	sql = "select * from article where art_info_id = " & c & " and (art_title like '%"& keyword &"%' or art_content like '%"& keyword &"%') and (sort_2=" & m & ") order by flag, art_time desc" 
	strTitle = request("t")
End if
rs.open sql,conn,1,1

%>
<!--#include file="uc/page.asp"-->
<div class="article_list mtop10">
    <h3><span><em><%=strTitle%></em></span></h3>
    <ul>
<%
if not rs.eof then
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
		art_id = rs("art_id")
		art_title = rs("art_title")
%>
        <li>
			<a href="article.asp?id=<%=art_id%>"><span class="<%If rs("art_title_b")="b" Then response.write "fwb "%> <%=rs("art_title_color")%>"><%=rs("art_title")%><span></a>
			<%if rs("is_new")=true then%>
				<img src="static/images/new.gif" /> 
			<%end if%>
			<span class="datetime fwn c2">[<%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%>]</span>
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