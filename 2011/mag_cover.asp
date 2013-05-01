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

<div class="article_list mt10">
    <h3><span><em>会刊封面</em></span></h3>
<%
sql="select * from article where sort_2=96 order by art_time desc"
rs.open sql, conn, 1, 1
rowcount = 10
%>
<!--#include file="uc/page.asp"-->
<%
If Not rs.eof Then
	i = 0
	rs.move (page - 1) * rowcount
	do while not rs.eof and rowcount > 0
		If i Mod 4 = 0then
%>
			<div style="height:260px; border-left:solid 1px #E1E1E1; border-right:solid 1px #E1E1E1; padding-top:10px">
		<%End if%>
				<span class="fl ml10 c" style="height:260px">
					<a href="article.asp?id=<%=rs("art_id")%>"><img <%=Replace(Replace(replace(RegExp_Execute(rs("art_content")),chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", Chr(39))%> width="170px"/><br><%=rs("art_title")%></a>
				</span>
		<%If i Mod 4 = 3 Or i = rs.recordcount-1 then%>
			</div>
			<div class="clear"></div>
<%		End If
	rs.movenext
	If rs.eof Then Exit Do
	rowcount = rowcount - 1
	i = i + 1
Loop
End If 
rs.close
%>
	<%call pageSplit("")%>
    <div class="underline_left">
    </div>
</div>
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