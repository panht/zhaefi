<!--#include file="uc/conn.asp"-->
<%
c=request("c")
m=request("m")
If c = 93 Then
	strTitle="资讯焦点"
ElseIf c = 87 Then
	strTitle="协会动态"
ElseIf c = 91 Then
	strTitle="会员报道"
ElseIf c = 92 Then
	strTitle="会刊"
ElseIf c = 89 Then
	strTitle="专题"
ElseIf c = 90 Then
	strTitle="专栏"
ElseIf c = 83 Then
	strTitle="政策法规"
ElseIf c = 86 Then
	strTitle="重点"
ElseIf c = 85 Then
	strTitle="网站信息"
End If
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