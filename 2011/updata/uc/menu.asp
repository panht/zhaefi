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
<div class="c c2 fs18">��վ��̨����ϵͳ</div>
<div id="accordion">
	<h3 class="menu dn"><a href="#">���ݹ���</a></h3>
	<div>
		<ul>
			<li class="menu dn"><a href="articlelist.asp?module=93">��Ѷ����</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=87">Э�ᶯ̬</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=91">��Ա����</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=92">�`</a></li>
			<!--<li class="menu dn"><a href="articlelist.asp?module=89">ר��</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=90">ר��</a></li>-->
			<li class="menu dn"><a href="articlelist.asp?module=83">���߷���</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=86">�ص�</a></li>
			<li class="menu dn"><a href="articlelist.asp?module=85">��վ��Ϣ</a></li>
			<li class="menu dn"><a href="commentlist.asp">���۹���</a></li>
		</ul>
	</div>
	<h3 class="menu dn"><a href="#">ҵ�����</a></h3>
	<div>
		<ul>
			<!--<li class="menu dn"><a href="memberlist.asp">��Ա����</a></li>-->
			<li class="menu dn"><a href="trainingcardlist.asp">ѧϰ��</a></li>
			<li class="menu dn"><a href="lecturelist.asp">��������</a></li>
			<li class="menu dn"><a href="inquirylist.asp">�ȵ����</a></li>
			<li class="menu dn"><a href="surveylist.asp">�ʾ����</a></li>
		</ul>
	</div>
	<h3 class="menu dn"><a href="#">ϵͳ����</a></h3>
	<div>
		<ul>
			<li class="menu dn"><a href="http://tongji.baidu.com" target="_blank">����ͳ��</a></li>
			<li class="menu dn"><a href="adminmodule.asp">��Ŀ����</a></li>
			<li class="menu dn"><a href="adminuserlist.asp">�ʺŹ���</a></li>
			<!--<li class="menu dn"><a href="datasyn.asp">����ͬ��</a></li>-->
			<li class="menu dn"><a href="adminpassworddetail.asp">�޸�����</a></li>
		</ul>
	</div>
	<h3 onclick="location.href='./?c=q'"><a href="#">�˳�</a></h3>
</div>
</div>

<script>
$(document).ready(function(){
	//�����˵���������û���Ȩ������ʾ
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