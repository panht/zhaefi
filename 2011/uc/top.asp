<%
'格式化标题，长度超出指定长度以...补足
Function FormatArtTitle(title, length)
	If Len(title) > length Then 
		FormatArtTitle = Left(title, length) & "..."
	Else 
		FormatArtTitle = title
	End If 
End Function

'从一篇文章中获取图片
Function RegExp_Execute(string)
	Dim regEx, Match, Matches,values '建立变量。

	Set regEx = New RegExp '建立正则表达式。
	regEx.Pattern = "src\=.+?\.(gif|jpg)" '设置模式。
	regEx.IgnoreCase = true '设置是否区分字符大小写。
	regEx.Global = True '设置全局可用性。
	Set Matches = regEx.Execute(string) '执行搜索。
	For Each Match in Matches '遍历匹配集合。
		values=values&Match.Value&"""|"
	Next
	RegExp_Execute = values
End Function 

'过滤html标签
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

'处理登录 
If request.Form("username") <> "" and request.Form("hidLogin") = "登录" Then
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
			alert("您输入了错误的帐号或密码，请再次输入！" )
			history.back()
		</script>
<%
		rs.close
		response.end
	end If
End If

'退出登录
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
			<a href="http://www.zhaefi.org/"><img alt="珠海外商投资企业协会" src="static/images/Logo.png"></a>
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
	response.write "欢迎，" & session("c_name")
%>
				<a class="reg" id="loginAnchor" href="./?c=q">退出登录</a>
<%
Else
%>
				<a class="reg" id="loginAnchor" href="./?c=l">会员登录</a>
<%End if%>
			-->
<% If Len(session("CardNo")) > 1 Then
	response.write "<a href='userzone.asp'>学习卡管理</a>"
End If%>

				<a class="home" href="javascript:" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.zhaefi.org/');">设为首页</a>
				<a class="fav" href="javascript:window.external.addFavorite('http://www.zhaefi.org','珠海外商投资企业协会');">加入收藏</a>
			</div>
			<div class="search r mt10">
				<select name="keywordquery">
					<option selected="" value="channel.asp?c=83&keyword=">政策法规</option>
					<% '<option value="member.asp?keyword=">会员企业</option> %>
					<option value="channel.asp?c=93&keyword=">资讯焦点</option>
				</select>
				<input name="keywords" value="" class="search_input" style="color:black">
				<input type="button" class="search_button ch" value="搜索" onclick="javascript:window.location.href=keywordquery.value+keywords.value">
			</div>
		</div>
	</div>
	<div class="clear"></div>

	<div class="menu ma w980">
		<div class="main_menu" id="menubox">
			<ul>
				<li <%If InStr(URLCurrent, "default.asp") > 0 Then response.write "class=""current"""%>><a href="./"><span><em>首页</em></span></a></li>
				<li <%If InStr(URLCurrent, "channel.asp?c=93") > 0 Then response.write "class=""current"""%>><a href="channel.asp?c=93"><span><em>资讯焦点</em></span></a></li>
				<li <%If InStr(URLCurrent, "channel.asp?c=87") > 0 Then response.write "class=""current"""%>><a href="channel.asp?c=87"><span><em>协会动态</em></span></a></li>
				<li <%If InStr(URLCurrent, "channel.asp?c=83") > 0 Then response.write "class=""current"""%>><a href="channel.asp?c=83"><span><em>政策法规</em></span></a></li>
				<li <%If InStr(URLCurrent, "survey.asp") > 0 Then response.write "class=""current"""%>><a href="survey.asp"><span><em>问卷调查</em></span></a></li>
				<li <%If InStr(URLCurrent, "mag.asp") > 0 Or InStr(URLCurrent, "channel.asp?c=92") > 0 Then response.write "class=""current"""%>><a href="mag.asp"><span><em>会刊</em></span></a>
				<li <%If InStr(URLCurrent, "article.asp?id=3775") > 0 Then response.write "class=""current"""%>><a href="article.asp?id=3800"><span><em>入会指南</em></span></a></li>
				<li <%If InStr(URLCurrent, "article.asp?id=3772") > 0 Then response.write "class=""current"""%>><a href="article.asp?id=3801"><span><em>关于我们</em></span></a></li>
			</ul>
		</div>
	</div>
</div>
