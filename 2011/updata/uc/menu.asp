<%
sql = "select * from admin where username='" & session("AdminUsername") & "'"
rs.open sql,conn,1,1
If Not rs.eof Then 
	'Do While Not rs.eof
	'	strUserrightMenu = strUserrightMenu & "," & rs("modulename")
	'	rs.movenext()
	'Loop
	strUserrightMenu = rs("user_right")
End If
rs.close
%>
<div id="menu" class="w220 fl mt10 ml10">
<img src="http://www.zhaefi.org/plus/image/emblem_left.jpg" class="w220" />
<div class="c c2 fs18">网站后台管理系统</div>
<div id="accordion">
	<h3 class="menu dn"><a href="#">内容管理</a></h3>
	<div>
		<ul>
			<li class="menu dn"><a href="articlelist.asp?module=93">资讯焦点</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=87">协会动态</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=91">会员报道</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=92">会刊</a></li>
			<!--<li class="menu dn"><a href="articlelist.asp?module=89">专题</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=90">专栏</a></li>-->
			<li class="menu dn"><a href="articlelist.asp?module=83">政策法规</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=86">重点</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=85">网站信息</a></li>
			<li class="menu dn"><a href="commentlist.asp">评论管理</a></li>
		</ul>
	</div>
	<h3 class="menu dn"><a href="#">业务管理</a></h3>
	<div>
		<ul>
			<!--<li class="menu dn"><a href="memberlist.asp">会员管理</a></li>-->
			<li class="menu dn"><a href="trainingcardlist.asp">学习卡</a></li>
			<li class="menu dn"><a href="lecturelist.asp">讲座管理</a></li>
			<li class="menu dn"><a href="inquirylist.asp">热点调查</a></li>
			<li class="menu dn"><a href="surveylist.asp">问卷调查</a></li>
		</ul>
	</div>
	<h3 class="menu dn"><a href="#">系统管理</a></h3>
	<div>
		<ul>
			<li class="menu dn"><a href="http://tongji.baidu.com" target="_blank">访问统计</a></li>
			<li class="menu dn"><a href="adminmodule.asp">栏目管理</a></li>
			<li class="menu dn"><a href="adminuserlist.asp">帐号管理</a></li>
			<!--<li class="menu dn"><a href="datasyn.asp">数据同步</a></li>-->
			<li class="menu dn"><a href="adminpassworddetail.asp">修改密码</a></li>
		</ul>
	</div>
	<h3 onclick="location.href='./?c=q'"><a href="#">退出</a></h3>
</div>
</div>

<script>
$(document).ready(function(){
	//遍历菜单，如果该用户有权限则显示
	var strUserrightMenu = "<%=strUserrightMenu%>";
	$(".menu").each(function(){	
	<%if lcase(session("AdminUsername"))="zhaefi" then%>
		$(this).removeClass("dn");
	<%else%>
		if(strUserrightMenu.indexOf($(this).text()) >= 0 )
		{
			$(this).removeClass("dn");
		}
	<%end if%>
	});
})
</script>