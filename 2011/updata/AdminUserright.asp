<!--#include file="../uc/conn.asp"-->
<%strModuleName="�ʺŹ���"%>
<!--#include file="uc/userright.asp"-->
<%
'�������
If request.Form("save") = "����" Then 
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
	<title>�麣����Ͷ����ҵЭ��</title>	
	<link rel="stylesheet" href="../static/js/ufvalidator/ufvalidator.css" />
<!--#include file="uc/static.asp" -->
	<script src="../static/js/ufvalidator/jquery.ufvalidator.js" type="text/javascript"></script>
</head>
<body> 
<form method="post" name="form1" id="form1" class="">
<!--�˵�-->
<!--#include file="uc/menu.asp" -->

<!--������-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 mt10 fs18">�ʺŹ��� - Ȩ��</div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>
				<ul><input type="checkbox" name="userright" value="���ݹ���" />���ݹ���
					<li class="ml10"><input type="checkbox" name="userright" value="��Ѷ����" />��Ѷ����<li>
					<li class="ml10"><input type="checkbox" name="userright" value="Э�ᶯ̬+��Ա����" />Э�ᶯ̬+��Ա����<li>
					<li class="ml10"><input type="checkbox" name="userright" value="�`+ר��+ר��" />�`+ר��+ר��<li>
					<li class="ml10"><input type="checkbox" name="userright" value="���߷���" />���߷���<li>
					<li class="ml10"><input type="checkbox" name="userright" value="�ص�" />�ص�<li>
					<li class="ml10"><input type="checkbox" name="userright" value="��վ��Ϣ" />��վ��Ϣ<li>
				</ul>
				<ul><input type="checkbox" name="userright" value="ҵ�����" />ҵ�����
					<li class="ml10"><input type="checkbox" name="userright" value="��Ա����" />��Ա����<li>
					<li class="ml10"><input type="checkbox" name="userright" value="��Ա����" />ѧϰ��</li>
					<li class="ml10"><input type="checkbox" name="userright" value="��������" />��������<li>
					<li class="ml10"><input type="checkbox" name="userright" value="�ȵ����" />�ȵ����<li>
					<li class="ml10"><input type="checkbox" name="userright" value="�ʾ����" />�ʾ����<li>
				</ul>
				<ul><input type="checkbox" name="userright" value="ϵͳ����" />ϵͳ����
					<li class="ml10"><input type="checkbox" name="userright" value="����ͳ��" />����ͳ��<li>
					<li class="ml10"><input type="checkbox" name="userright" value="��Ŀ����" />��Ŀ����<li>
					<li class="ml10"><input type="checkbox" name="userright" value="�ʺŹ���" />�ʺŹ���<li>
					<li class="ml10"><input type="checkbox" name="userright" value="����ͬ��" />����ͬ��<li>
					<li class="ml10"><input type="checkbox" name="userright" value="�޸�����" />�޸�����<li>
				</ul>
			</td>
		</tr>
		<tr>
			<td class="c">
				<input type="hidden" name="username" value="<%=id%>" />
				<input type='submit' value='����' name="save" id="btnsave" /> 
				<input type='button' value='����' name="return" id="btnreturn" />
			</td>
		</tr>
	</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 2 });

	//������ѡ��������û���Ȩ����ѡ��
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