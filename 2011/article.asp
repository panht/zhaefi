<!--#include file="uc/conn.asp"-->
<%
id=request("id")

'保存评论
If request.Form("nickname") <> "" And request.Form("content") <> "" and request.Form("hidPost") = "发表"  Then
	refid = request.Form("refid")
	nickname = request.Form("nickname")
	content = request.Form("content")
	
	if TestCaptcha("ASPCAPTCHA", Request.Form("captchacode")) = True Then
		sql="insert into comment(refid, nickname, content) values ("& refid & ", '" & nickname & "', '" & content & "')"
		conn.execute(sql)
		
		If InStr(URLCurrent, "&c=ps") > 0 Then 
			response.redirect request.ServerVariables("HTTP_REFERER")
		Else
			response.redirect request.ServerVariables("HTTP_REFERER") & "&c=ps"
		End If
	Else
%>
		<script>
			window.onload = function() {
				alert("验证码错误，请重新输入");
				//window.location.reload();
				document.form1.nickname.value = "<%=nickname%>";
				document.form1.content.value = "<%=content%>";
				RefreshImage('imgCaptcha');
				document.form1.captchacode.focus();
			}
		</script>
<%		
	End If
End If


sql="select * from article where art_id = " & id
rs.open sql,conn,1,1
If Not rs.eof Then
	art_time=rs("art_time")
	art_title=rs("art_title")
	art_content=rs("art_content")
	art_info_id=rs("art_info_id")

	'如果内容中包含表格，暂时只匹配第一个表格
	If InStr(art_content, "<table") > 0 Then 
		art_content_table_before = Left(art_content, InStr(art_content, "<table") - 1)
		art_content = Replace(art_content, art_content_table_before, "")
		Set re = New RegExp
		re.Pattern = "<table{1}([\s\S]*)/table>{1}"
		're.Global = True
		re.IgnoreCase = True
		re.MultiLine = True
		Set colMatches = re.Execute(art_content)
		For Each match In colMatches
			 art_content_table = art_content_table & match.Value
		Next
		'art_content_table = re.test(art_content)
		art_content_table_after = re.Replace(art_content, "")
		art_content_table_before = Replace(Replace(Replace(Replace(art_content_table_before, "&quot;", chr(34)), "&#39;", Chr(39)), "><br/>", ">"), "<br/><", "<")
		art_content_table_after = replace(art_content_table_after,chr(10),"<br/>")
		art_content_table_after = Replace(Replace(Replace(Replace(art_content_table_after, "&quot;", chr(34)), "&#39;", Chr(39)), "><br/>", ">"), "<br/><", "<")
		art_content_table = Replace(art_content_table, "&quot;", chr(34))
		art_content = art_content_table_before + art_content_table + art_content_table_after
	Else
		art_content = replace(art_content,chr(10),"<br/>")
		art_content = Replace(Replace(Replace(Replace(art_content, "&quot;", chr(34)), "&#39;", Chr(39)), "><br/>", ">"), "<br/><", "<")
	End if 

	If InStr(art_content, "　　 ") <= 0 Then
		art_content = "　　 " & art_content
		art_content = Replace(Replace(art_content, "<BR>", "<br/><br/>"), "<br/>", "<br/>　　 ")
		art_content = Replace(art_content, "<div align=""center""><br>", "<p>")
		art_content = Replace(Replace(art_content, "　　 　　", "　　 "), "<P>　　", "<p>")
		art_content = Replace(art_content, "</div>", "</p>")
		art_content = Replace(art_content, "<div", "<p")		
		'art_content = Replace(art_content, "<div style=""text-align: left;"">", "<p style=""text-align:left"">")
		'art_content = ReplaceHtml("</?div*>", "", art_content)   
	End If 
End If
rs.close

' 验证码
function TestCaptcha(byval valSession, byval valCaptcha)
	dim tmpSession
	valSession = Trim(valSession)
	valCaptcha = Trim(valCaptcha)
	if (valSession = vbNullString) or (valCaptcha = vbNullString) then
		TestCaptcha = false
	else
		tmpSession = valSession
		valSession = Trim(Session(valSession))
		Session(tmpSession) = vbNullString
		if valSession = vbNullString then
			TestCaptcha = false
		else
			valCaptcha = Replace(valCaptcha,"i","I")
			if StrComp(valSession,valCaptcha,1) = 0 then
				TestCaptcha = true
			else
				TestCaptcha = false
			end if
		end if		
	end if
end function
'Function ReplaceHtml(patrn, trng, content)  
'	IF IsNull(content)   Then  
'		content=""  
'	End IF  
'	Set regEx  = New RegExp '   建立正则表达式。  
'	regEx.Pattern = patrn '   设置模式。  
'	regEx.IgnoreCase = true             '   设置忽略字符大小写。  
'	regEx.Global = True '   设置全局可用性。  
'	ReplaceHtml = regEx.Replace(content,strng) '   执行正则匹配  
'End   Function   
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

<!--文章详细开始-->
<div class="article mtop10">
    <div class="article_line">
    </div>
	<div class="article_content">
        <h1>
            <span><%=Replace(Replace(replace(art_title,chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", Chr(39))%></span>
        </h1>
        <div class="article_info">
            发布时间：<%=art_time%>
        </div>
        <!--内容开始-->
        <div class="article_content_list" id="fontzoom">
            <div id="articleContnet">
                <%=art_content%>
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
	<div class="underline_left">
	</div>
</div>
<!--文章详细结束-->

<%
'协会动态和资讯焦点和会刊可评论
If art_info_id = 93 Or art_info_id = 87 Or art_info_id = 92  then%>
<!--评论开始-->
 <div class="article_list mt10">
    <h3><span><em>文章评论</em></span></h3>
	<div>
<%
sql="select * from comment where refid=" & id & " and flagaudit=true order by timecomment desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
		<div class="fwb commentdiv1"><%=rs("nickname")%> 于 <%=rs("timecomment")%> 发表评论：</div><div class="commentdiv2"><%=replace(rs("content"),chr(13),"<br/>")%><hr /></div>
<% If rs.eof Then Exit Do
	rs.movenext
Loop
rs.close
%>
	</div>
	<div class="commentdiv1">
		<span class="fwb">发表评论</span></br></br>
		<input type="hidden" name="refid" value="<%=id%>" />
		昵称：<input name="nickname" size="20" maxlength="20" value="<%=nickname%>" /></br></br>
		内容：<textarea name="content" cols="70" rows="10" value="<%=content%>"></textarea></br></br>
		验证码：<input name="captchacode" type="text" id="captchacode" size="10" /><img id="imgCaptcha" src="uc/captcha.asp" /><a href="javascript:void(0);" onclick="RefreshImage('imgCaptcha');">看不清，换一个</a></br></br>
		<div class="c"><input type="button" name="post" value="发表" class="search_button ch" onclick="javascript:chkpost()"/><input type="hidden" name="hidPost" value=""/></div>
	</div>
	<script>
		function chkpost(){
			if (document.form1.nickname.value==""){
				alert("请输入昵称");
				document.form1.nickname.focus();
				return;
			}
			if (document.form1.content.value==""){
				alert("请输入评论内容");
				document.form1.content.focus();
				return;
			}
			if (document.form1.captchacode.value==""){
				alert("请输入验证码");
				document.form1.captchacode.focus();
				return;
			}
			document.form1.hidPost.value = "发表";
			document.form1.action = 'article.asp?id=<%=id%>';
			document.form1.submit();
		}
		
		function RefreshImage(valImageId) {
			var objImage = document.images[valImageId];
			if (objImage == undefined) {
				return;
			}
			var now = new Date();
			objImage.src = objImage.src.split('?')[0] + '?x=' + now.toUTCString();
		}

		<%if request("c")="ps" then%>
			alert("发表成功");
		<%end if%>
	</script>
	<div class="underline_left">
	</div>
</div>
<!--评论结束-->
<%End if%>

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