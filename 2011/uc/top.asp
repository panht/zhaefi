<%
'��ʽ�����⣬���ȳ���ָ��������...����
Function FormatArtTitle(title, length)
	If Len(title) > length Then 
		FormatArtTitle = Left(title, length) & "..."
	Else 
		FormatArtTitle = title
	End If 
End Function

'��һƪ�����л�ȡͼƬ
Function RegExp_Execute(string)
	Dim regEx, Match, Matches,values '����������

	Set regEx = New RegExp '����������ʽ��
	regEx.Pattern = "src\=.+?\.(gif|jpg)" '����ģʽ��
	regEx.IgnoreCase = true '�����Ƿ������ַ���Сд��
	regEx.Global = True '����ȫ�ֿ����ԡ�
	Set Matches = regEx.Execute(string) 'ִ��������
	For Each Match in Matches '����ƥ�伯�ϡ�
		values=values&Match.Value&"""|"
	Next
	RegExp_Execute = values
End Function 

'����html��ǩ
Function RegExp_FilterHtml(ContentStr)
	Dim ClsTempLoseStr,regEx
	ClsTempLoseStr = Cstr(ContentStr)
	Set regEx = New RegExp
	regEx.Pattern = "(<[a-zA-Z].*?>)|(<[\/][a-zA-Z].*?>)"
	regEx.IgnoreCase = True
	regEx.Global = True
	ClsTempLoseStr = regEx.Replace(ClsTempLoseStr,"")
	RegExp_FilterHtml = ClsTempLoseStr
End Function

'�����¼ 
If request.Form("username") <> "" and request.Form("hidLogin") = "��¼" Then
	username = request.Form("username")
	password = request.Form("password")
	sql="select * from member where login_name='" & username & "' and login_pwd='" & password & "'"

	rs.open sql,conn,1,1
	If Not rs.eof Then
		session("Username") = username
		session("c_name") = rs("c_name")
		Session.Timeout= 30
		rs.close
		'response.redirect request.ServerVariables("HTTP_REFERER")
	Else
%>
		<script>
			alert("�������˴�����ʺŻ����룬���ٴ����룡" )
			history.back()
		</script>
<%
		rs.close
		response.end
	end If
End If

'�˳���¼
If request("c") = "q" Then
	session("username") = ""
	session("c_name") = ""
	response.redirect request.ServerVariables("HTTP_REFERER")
End if
%>
<script src="static/js/jquery.js" type="text/javascript"></script>
<div class="topbg">
	<div class="top ma w980">
		<div id="logo" class="fl">
			<a href="http://www.zhaefi.org/"><img alt="�麣����Ͷ����ҵЭ��" src="static/images/Logo.png"></a>
		</div>
		<!--<div class="fl mt10 ml10">
			<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
			codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
			width="240" height="45" id="banner201107_2" align="">
			<param name=movie value="static/images/banner201107_2.swf">
			<param name="quality" value="high">
			<embed src="static/images/banner201107_2.swf" quality="high" width="240" height="45" name="banner201107_2" align=""
			type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
			</embed></object>
		</div>-->
		<div class="fr">
			<div class="web_tip r">
		<!--
<%If Len(session("username")) > 0 Then
	response.write "��ӭ��" & session("c_name")
%>
				<a class="reg" id="loginAnchor" href="./?c=q">�˳���¼</a>
<%
Else
%>
				<a class="reg" id="loginAnchor" href="./?c=l">��Ա��¼</a>
<%End if%>
			-->
<% If Len(session("CardNo")) > 1 Then
	response.write "<a href='userzone.asp'>ѧϰ������</a>"
End If%>

				<a class="home" href="javascript:" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.zhaefi.org/');">��Ϊ��ҳ</a>
				<a class="fav" href="javascript:window.external.addFavorite('http://www.zhaefi.org','�麣����Ͷ����ҵЭ��');">�����ղ�</a>
			</div>
			<div class="search r mt10">
				<select name="keywordquery">
					<option selected="" value="channel.asp?c=83&keyword=">���߷���</option>
					<% '<option value="member.asp?keyword=">��Ա��ҵ</option> %>
					<option value="channel.asp?c=93&keyword=">��Ѷ����</option>
				</select>
				<input name="keywords" value="" class="search_input" style="color:black">
				<input type="button" class="search_button ch" value="����" onclick="javascript:window.location.href=keywordquery.value+keywords.value">
			</div>
		</div>
	</div>
	<div class="clear"></div>

	<div class="menu ma w980">
		<div class="main_menu" id="menubox">
			<ul>
				<li <%If InStr(URLCurrent, "default.asp") > 0 Then response.write "class=""current"""%>><a href="./"><span><em>��ҳ</em></span></a></li>
				<li <%If InStr(URLCurrent, "channel.asp?c=93") > 0 Then response.write "class=""current"""%>><a href="channel.asp?c=93"><span><em>��Ѷ����</em></span></a></li>
				<li <%If InStr(URLCurrent, "channel.asp?c=87") > 0 Then response.write "class=""current"""%>><a href="channel.asp?c=87"><span><em>Э�ᶯ̬</em></span></a></li>
				<li <%If InStr(URLCurrent, "channel.asp?c=83") > 0 Then response.write "class=""current"""%>><a href="channel.asp?c=83"><span><em>���߷���</em></span></a></li>
				<li <%If InStr(URLCurrent, "survey.asp") > 0 Then response.write "class=""current"""%>><a href="survey.asp"><span><em>�ʾ����</em></span></a></li>
				<li <%If InStr(URLCurrent, "mag.asp") > 0 Or InStr(URLCurrent, "channel.asp?c=92") > 0 Then response.write "class=""current"""%>><a href="mag.asp"><span><em>�`</em></span></a>
				<li <%If InStr(URLCurrent, "article.asp?id=3775") > 0 Then response.write "class=""current"""%>><a href="article.asp?id=3800"><span><em>���ָ��</em></span></a></li>
				<li <%If InStr(URLCurrent, "article.asp?id=3772") > 0 Then response.write "class=""current"""%>><a href="article.asp?id=3801"><span><em>��������</em></span></a></li>
			</ul>
		</div>
	</div>
</div>
