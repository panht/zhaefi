<!--#include file="uc/conn.asp"-->
<%
id=request("id")

sql="select * from article where art_id = " & id
rs.open sql,conn,1,1
If Not rs.eof Then
	art_time=rs("art_time")
	art_title=rs("art_title")
	art_content=rs("art_content")
End If
rs.close
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=art_title%> - 珠海外商投资企业协会</title>
	<meta name="keywords" content="<%=art_title%> - 珠海外商投资企业协会">
	<meta name="description" content="<%=art_title%> - 珠海外商投资企业协会">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1">
<!--头部-->
<!--#include file="uc/top.asp" -->


<!--中部开始-->
<div class="ma w980">
<!--左栏开始-->
<div class="ma w730 fl">

<!--资讯焦点开始-->
<div class="article mtop10">
    <div class="article_line">
    </div>
	<div class="article_content">
        <h1>
            <span><font style="font-weight: normal; font-style: normal;">
                <%=art_title%></font></span>
        </h1>
        <div class="article_info">
            发布时间：<%=art_time%>
        </div>
        <!--内容开始-->
        <div class="article_content_list" id="fontzoom">
            <div id="articleContnet">
                <%=replace(art_content,chr(13),"<br/>")%>
            </div>
        </div>
        <!--内容结束-->
        <div class="artilcle_tool">
            【<a href="javascript:window.external.AddFavorite(document.location.href,document.title)">收藏</a>】
            【<a href="javascript:window.print();">打印</a>】<span id="content_AdminEdit"></span> 
        </div>
        <!--上一篇-
        <div class="article_page">
            <ul>
                <li><span>上一篇：</span>
                    
                    <a href="http://www.zhaefi.org/info/2011-05-23-49.aspx" target="_self">
                        全省将现全年性缺电 珠海制定错...</a>
                </li>
                <li class="next"><span>下一篇：</span>
                    
                    <a href="http://www.zhaefi.org/aboutus/2011-05-17-47.aspx" target="_self">
                        关于我们</a>
                </li>
            </ul>
        </div>
        <!--下一篇-->
    </div>
</div>
<!--资讯焦点结束-->

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