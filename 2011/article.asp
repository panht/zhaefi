<!--#include file="uc/conn.asp"-->
<%
id=request("id")

'��������
If request.Form("nickname") <> "" And request.Form("content") <> "" and request.Form("hidPost") = "����"  Then
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
				alert("��֤���������������");
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

	'��������а��������ʱֻƥ���һ�����
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

	If InStr(art_content, "���� ") <= 0 Then
		art_content = "���� " & art_content
		art_content = Replace(Replace(art_content, "<BR>", "<br/><br/>"), "<br/>", "<br/>���� ")
		art_content = Replace(art_content, "<div align=""center""><br>", "<p>")
		art_content = Replace(Replace(art_content, "���� ����", "���� "), "<P>����", "<p>")
		art_content = Replace(art_content, "</div>", "</p>")
		art_content = Replace(art_content, "<div", "<p")		
		'art_content = Replace(art_content, "<div style=""text-align: left;"">", "<p style=""text-align:left"">")
		'art_content = ReplaceHtml("</?div*>", "", art_content)   
	End If 
End If
rs.close

' ��֤��
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
'	Set regEx  = New RegExp '   ����������ʽ��  
'	regEx.Pattern = patrn '   ����ģʽ��  
'	regEx.IgnoreCase = true             '   ���ú����ַ���Сд��  
'	regEx.Global = True '   ����ȫ�ֿ����ԡ�  
'	ReplaceHtml = regEx.Replace(content,strng) '   ִ������ƥ��  
'End   Function   
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

<!--������ϸ��ʼ-->
<div class="article mtop10">
    <div class="article_line">
    </div>
	<div class="article_content">
        <h1>
            <span><%=Replace(Replace(replace(art_title,chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", Chr(39))%></span>
        </h1>
        <div class="article_info">
            ����ʱ�䣺<%=art_time%>
        </div>
        <!--���ݿ�ʼ-->
        <div class="article_content_list" id="fontzoom">
            <div id="articleContnet">
                <%=art_content%>
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
	<div class="underline_left">
	</div>
</div>
<!--������ϸ����-->

<%
'Э�ᶯ̬����Ѷ����ͻ`������
If art_info_id = 93 Or art_info_id = 87 Or art_info_id = 92  then%>
<!--���ۿ�ʼ-->
 <div class="article_list mt10">
    <h3><span><em>��������</em></span></h3>
	<div>
<%
sql="select * from comment where refid=" & id & " and flagaudit=true order by timecomment desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
		<div class="fwb commentdiv1"><%=rs("nickname")%> �� <%=rs("timecomment")%> �������ۣ�</div><div class="commentdiv2"><%=replace(rs("content"),chr(13),"<br/>")%><hr /></div>
<% If rs.eof Then Exit Do
	rs.movenext
Loop
rs.close
%>
	</div>
	<div class="commentdiv1">
		<span class="fwb">��������</span></br></br>
		<input type="hidden" name="refid" value="<%=id%>" />
		�ǳƣ�<input name="nickname" size="20" maxlength="20" value="<%=nickname%>" /></br></br>
		���ݣ�<textarea name="content" cols="70" rows="10" value="<%=content%>"></textarea></br></br>
		��֤�룺<input name="captchacode" type="text" id="captchacode" size="10" /><img id="imgCaptcha" src="uc/captcha.asp" /><a href="javascript:void(0);" onclick="RefreshImage('imgCaptcha');">�����壬��һ��</a></br></br>
		<div class="c"><input type="button" name="post" value="����" class="search_button ch" onclick="javascript:chkpost()"/><input type="hidden" name="hidPost" value=""/></div>
	</div>
	<script>
		function chkpost(){
			if (document.form1.nickname.value==""){
				alert("�������ǳ�");
				document.form1.nickname.focus();
				return;
			}
			if (document.form1.content.value==""){
				alert("��������������");
				document.form1.content.focus();
				return;
			}
			if (document.form1.captchacode.value==""){
				alert("��������֤��");
				document.form1.captchacode.focus();
				return;
			}
			document.form1.hidPost.value = "����";
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
			alert("����ɹ�");
		<%end if%>
	</script>
	<div class="underline_left">
	</div>
</div>
<!--���۽���-->
<%End if%>

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