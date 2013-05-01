<!--#include file="../uc/conn.asp"-->
<%strModuleName="帐号管理"%>
<!--#include file="uc/userright.asp"-->
<%
'保存操作
If request.Form("save") = "保存" Then 
	username=request.form("username")

	'sql="delete from adminmodule where username= '" & username & "'"
	'response.write sql
	'conn.execute(sql)

	For Each i In Request.Form("userright")
		'sql="insert into adminmodule(username, modulename) values('" & username & "', '" & i & "')"
		strUserright = strUserright & "," & i
	Next
	sql = "update admin set user_right='" & struserright & "' where username= '" & username & "'"
	response.write sql
	conn.execute(sql)
	'response.end
	conn.close
	response.redirect "adminuserlist.asp"

Else
	id=request("id")
	sql = "select * from admin where username='" & id & "'"
	rs.open sql,conn,1,1
	If Not rs.eof Then 
		'Do While Not rs.eof
		'	strUserright = strUserright & "," & rs("modulename")
		'	rs.movenext()
		'Loop
		strUserright = rs("user_right")
	End If
	rs.close
End If 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>珠海外商投资企业协会</title>	
	<link rel="stylesheet" href="../static/js/ufvalidator/ufvalidator.css" />
<!--#include file="uc/static.asp" -->
	<script src="../static/js/ufvalidator/jquery.ufvalidator.js" type="text/javascript"></script>
</head>
<body> 
<form method="post" name="form1" id="form1" class="">
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--主界面-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 mt10 fs18">帐号管理 - 权限</div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>
				<ul><input type="checkbox" name="userright" value="内容管理" />内容管理
					<li class="ml10"><input type="checkbox" name="userright" value="资讯焦点" />资讯焦点<li>
					<li class="ml10"><input type="checkbox" name="userright" value="协会动态+会员报道" />协会动态+会员报道<li>
					<li class="ml10"><input type="checkbox" name="userright" value="会刊+专题+专栏" />会刊+专题+专栏<li>
					<li class="ml10"><input type="checkbox" name="userright" value="政策法规" />政策法规<li>
					<li class="ml10"><input type="checkbox" name="userright" value="重点" />重点<li>
					<li class="ml10"><input type="checkbox" name="userright" value="网站信息" />网站信息<li>
				</ul>
				<ul><input type="checkbox" name="userright" value="业务管理" />业务管理
					<li class="ml10"><input type="checkbox" name="userright" value="会员管理" />会员管理<li>
					<li class="ml10"><input type="checkbox" name="userright" value="会员管理" />学习卡</li>
					<li class="ml10"><input type="checkbox" name="userright" value="讲座管理" />讲座管理<li>
					<li class="ml10"><input type="checkbox" name="userright" value="热点调查" />热点调查<li>
					<li class="ml10"><input type="checkbox" name="userright" value="问卷调查" />问卷调查<li>
				</ul>
				<ul><input type="checkbox" name="userright" value="系统管理" />系统管理
					<li class="ml10"><input type="checkbox" name="userright" value="访问统计" />访问统计<li>
					<li class="ml10"><input type="checkbox" name="userright" value="栏目管理" />栏目管理<li>
					<li class="ml10"><input type="checkbox" name="userright" value="帐号管理" />帐号管理<li>
					<li class="ml10"><input type="checkbox" name="userright" value="数据同步" />数据同步<li>
					<li class="ml10"><input type="checkbox" name="userright" value="修改密码" />修改密码<li>
				</ul>
			</td>
		</tr>
		<tr>
			<td class="c">
				<input type="hidden" name="username" value="<%=id%>" />
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" />
			</td>
		</tr>
	</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 2 });

	//遍历复选框，如果该用户有权限则选中
	var strUserright = "<%=strUserright%>";
	$(":checkbox").each(function(){	
		if(strUserright.indexOf($(this).val()) >= 0 )
		{
			$(this).attr("checked", true);
		}
	});

	$('#btnreturn').click( function(){
		history.back();
	});

	$(".tdetail li > input:checkbox").click( function(t){
		if(this.checked == true){
			$(this).parent().parent().find(">input:checkbox").attr("checked", true);
		}
	});

	$(".tdetail ul > input:checkbox").click( function(t){
		if(this.checked == false){
			$(this).parent().find("li > input:checkbox").attr("checked", false);
		}
	});
})
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->