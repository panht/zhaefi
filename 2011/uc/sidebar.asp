<div class="w220 fl ml10">
 <%'���߷������ʾ����
 If InStr(URLCurrent, "channel.asp?c=83") > 0 Then
	set rs1=server.createobject("adodb.recordset")	
 	sql="select * from ModuleTree where parentmodule=83 order by ModuleLevel, seqno"
	rs.open sql,conn,1,1
	If Not rs.eof Then
		strTreeArray="["
		
		'ƴ��Ϊjs���飬�����ͻ�����jquery����������
		Do While Not rs.eof
			If rs("haschild") = True Then
				strTree = strTree & "<li class='treelevel1' id='m"& rs("id") & "'><a href='?c=83&m="& rs("id") & "'>" & rs("ModuleName") & "</a></li>" & Chr(13)
				strTree = strTree & "<ul>"
				sql1 = "select * from moduletree where parentmodule=" & rs("id") & " order by seqno"
				rs1.open sql1,conn,1,1
				Do While Not rs1.eof
					strTree = strTree & "<li class='treelevel2' id='m"& rs1("id") & "'><a href='?c=83&m="& rs1("id") & "'>" & rs1("ModuleName") & "</a></li>" & Chr(13)
					If Not rs1.eof Then rs1.movenext
				Loop
				strTree = strTree & "</ul>"
				rs1.close
			Else 
				strTree = strTree & "<li class='treelevel2' id='m"& rs("id") & "'><a href='?c=83&m="& rs("id") & "'>" & rs("ModuleName") & "</a></li>" & Chr(13)
			End If


			id = rs("id")
			ModuleName = rs("ModuleName")
			ParentModule = rs("ParentModule")
			HasChild = rs("HasChild")
			ModuleLevel = rs("ModuleLevel")
			ModuleMemo = rs("ModuleMemo")
			
			strTreeArray = strTreeArray & "{"
			strTreeArray = strTreeArray & """nodeid"":""" & id & ""","
			strTreeArray = strTreeArray & """nodename"":""" & ModuleName & ""","
			strTreeArray = strTreeArray & """nodeparent"":""" & ParentModule & ""","
			strTreeArray = strTreeArray & """nodehaschild"":""" & HasChild & ""","
			strTreeArray = strTreeArray & """nodelevel"":" & ModuleLevel & ","
			strTreeArray = strTreeArray & """nodememo"":""" & ModuleMemo & """"
			strTreeArray = strTreeArray & "}" & Chr(13)

			rs.movenext
			If rs.eof Then
				Exit Do
			Else
				strTreeArray = strTreeArray & ","
			End If		
		Loop

		strTreeArray = strTreeArray & "]"
	End If
	rs.close
 %> 
	<script src="static/js/jquery.js" type="text/javascript"></script>
	<div class="sidebar mt10">
		<h3>���߷���</h3>
		<div class="sidebar_content">
			<ul id="root">
				<%=strTree%>
			</ul>		
<%
sql="select count(art_id) as count_id from article where art_info_id=83"
rs.open sql,conn,1,1
count_id=rs("count_id")
rs.close
response.write "<br/><br/>&nbsp;�������߷��� <b><span class='c1'>"&count_id&"</span></b> ��"
%>
		</div>
		<div class="sidebar_underline">
		</div>
	</div>
<script>
$(document).ready(function(){
	$( "#m<%=m%>" ).addClass("c1");
});
</script>
<%End If %>
	

	<!--Э�����-->
	<div class="sidebar mt10">
		<h3>Э�����</h3>
		<ul>
<%
sql="select * from article where sort_2=94 order by art_time desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <li class="fs_14" style="background:none;"><IMG SRC="../static/images/right.png" ><a href="article.asp?id=<%=rs("art_id")%>"><%=rs("art_title")%></a></li>
<% If rs.eof Then Exit Do
	rs.movenext
Loop
rs.close
%>			
		</ul>
		<div class="sidebar_underline">
		</div>
	</div>

	<!--��Ա����-->
	<div class="sidebar mt10">
		<h3>��Ա����</h3>
		<div class="sidebar_content c c0" style="font-weight:normal">
<% If Len(session("Username")) > 1 Then
	response.write "��ӭ��" & session("c_name")
%>

<%Else%>
			�ʺţ�<input name="username" size="15" maxlength="20"/><br/>
			���룺<input name="password" type="password" size="15" maxlength="20" /><br/><input type="hidden" name="hidLogin" value=""/>
			<input name="login" type="button" value="��¼" class="search_button ch" onclick="javascript:chklogin();"/><br/>
<script>
function chklogin(){
	if (document.form1.username.value==''){
		alert('�������ʺ�');
		document.form1.username.focus();
		return;
	}
	if (document.form1.password.value==''){
		alert('����������')
		document.form1.password.focus();
		return;
	}
	document.form1.hidLogin.value = "��¼";
	document.form1.submit();
}
<%if request("c")="l" then%>
	document.form1.username.focus();
<%end if%>
</script>
<%End If%>
		</div>
		<div class="sidebar_underline">
		</div>
	</div>
	
<!--ѧϰ����¼-->
	<div class="sidebar mt10">
		<h3>ѧϰ����¼</h3>
		<div class="sidebar_content c c0" style="font-weight:normal" id="divCardLogin">
<% If Len(session("CardNo")) > 1 Then
	response.write "<a href='userzone.asp'>ѧϰ������</a>"
%>

<%Else%>
			ѧϰ����&nbsp;&nbsp;&nbsp;&nbsp;��<input name="logincardno" id="logincardno" size="12" maxlength="20"/><br/>
			ѧϰ�����룺<input name="logincardpassword" id="logincardpassword" type="password" size="12" maxlength="20" />
			<input name="logincard" id="logincard" type="button" value="��¼" class="search_button ch"/>
<script>
$(document).ready(function() {
	$("#logincard").click(function() {
		logincardno = encodeURIComponent(encodeURIComponent($("#logincardno").val()));
		logincardpassword = encodeURIComponent(encodeURIComponent($("#logincardpassword").val()));
		
		if( logincardno== ""){
			alert("������ѧϰ���ţ�");
			$("#logincardno")[0].focus();
			return false;
		}
		if(logincardpassword == ""){
			alert("������ѧϰ�����룡");
			$("#logincardpassword")[0].focus();
			return false;
		}
		
		$.ajax({
			type: "GET",
			url: "trainingcardaction.asp",
			data: "action=login&logincardno=" + logincardno + "&logincardpassword=" + logincardpassword,
			success: (function(result) {
				result = eval(result);
				if (result[0].code < 0) {
					alert(result[0].message);
				} else {
					alert(result[0].message);
					$("#divCardLogin").html("<a href='userzone.asp'>ѧϰ������</a>");
				}
			}),
		});
	});
});
</script>
<%End If%>
		</div>
		<div class="sidebar_underline">
		</div>
	</div>
 <%'��ҳ����ʾ΢��
 If InStr(URLCurrent, "default.asp") > 0 Then%>
	<div class="sidebar mt10">
		<h3>΢������</h3>
		<div class="sidebar_content h700">
			<iframe width="100%" height="700" class="share_self"  frameborder="0" scrolling="no" src="http://widget.weibo.com/weiboshow/index.php?language=&width=0&height=700&fansRow=2&ptype=1&speed=0&skin=1&isTitle=1&noborder=0&isWeibo=1&isFans=0&uid=1751987160&verifier=75dfaa45&dpc=1"></iframe>
		</div>
		<div class="sidebar_underline">
		</div>
	</div>

	<div class="sidebar mt10">
		<h3>�`</h3>
		<div class="sidebar_content c">
<%
sql="select top 1 * from article where sort_2=96 order by art_time desc"
rs.open sql, conn, 1, 1
If Not rs.eof Then 
%>
        <a href="article.asp?id=<%=rs("art_id")%>"><img <%=Replace(Replace(replace(RegExp_Execute(rs("art_content")),chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", Chr(39))%> /><br><%=rs("art_title")%></a>
<%
End If
rs.close
%>		
		</div>
		<div class="sidebar_underline">
		</div>
	</div>

	<!--�ƽ�-->
	<div class="sidebar mt10">
		<h3>�ƽ�</h3>
		<div class="sidebar_content">
<%
sql="select top 1 * from article where sort_2=95 order by art_time desc"
rs.open sql, conn, 1, 1
If Not rs.eof Then 
%>
        <a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>"><%=Replace(rs("art_content"), "&quot;", "")%></a>
<%
End If
rs.close
%>	
		</div>
		<div class="sidebar_underline">
		</div>
	</div>
<%
End If 
%>
</div>