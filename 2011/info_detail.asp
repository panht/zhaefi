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
	<title><%=art_title%> - �麣����Ͷ����ҵЭ��</title>
	<meta name="keywords" content="<%=art_title%> - �麣����Ͷ����ҵЭ��">
	<meta name="description" content="<%=art_title%> - �麣����Ͷ����ҵЭ��">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1">
<!--ͷ��-->
<!--#include file="uc/top.asp" -->


<!--�в���ʼ-->
<div class="ma w980">
<!--������ʼ-->
<div class="ma w730 fl">

<!--��Ѷ���㿪ʼ-->
<div class="article mtop10">
    <div class="article_line">
    </div>
	<div class="article_content">
        <h1>
            <span><font style="font-weight: normal; font-style: normal;">
                <%=art_title%></font></span>
        </h1>
        <div class="article_info">
            ����ʱ�䣺<%=art_time%>
        </div>
        <!--���ݿ�ʼ-->
        <div class="article_content_list" id="fontzoom">
            <div id="articleContnet">
                <%=replace(art_content,chr(13),"<br/>")%>
            </div>
        </div>
        <!--���ݽ���-->
        <div class="artilcle_tool">
            ��<a href="javascript:window.external.AddFavorite(document.location.href,document.title)">�ղ�</a>��
            ��<a href="javascript:window.print();">��ӡ</a>��<span id="content_AdminEdit"></span> 
        </div>
        <!--��һƪ-
        <div class="article_page">
            <ul>
                <li><span>��һƪ��</span>
                    
                    <a href="http://www.zhaefi.org/info/2011-05-23-49.aspx" target="_self">
                        ȫʡ����ȫ����ȱ�� �麣�ƶ���...</a>
                </li>
                <li class="next"><span>��һƪ��</span>
                    
                    <a href="http://www.zhaefi.org/aboutus/2011-05-17-47.aspx" target="_self">
                        ��������</a>
                </li>
            </ul>
        </div>
        <!--��һƪ-->
    </div>
</div>
<!--��Ѷ�������-->

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