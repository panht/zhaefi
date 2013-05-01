<!--#include file="../uc/conn.asp"-->
<%strModuleName="问卷调查"%>
<!--#include file="uc/userright.asp"-->
<%
id=request("id")
id_option=request("id_option")
CurrentPage = request("Page")
action=request("action")
term_name=request("term_name")

'保存操作
If request.Form("save") = "保存" Then
	sno=request("sno")
	subject=request("subject")
	A=request("A")
	B=request("B")
	C=request("C")
	D=request("D")
	E=request("E")
	F=request("F")
	others=request("others")
	if request("flag")="true" then
		flag=true
	else
		flag=false
	end if

	if action="new" Then
		sql="insert into research(term_id, sno, subject, A, B, C, D, E, F, others, flag) values("&id&", '"&sno&"', '"&subject&"',  '"&A&"', '"&B&"', '"&C&"', '"&D&"', '"&E&"', '"&F&"','"&others&"', "&flag&")"
	elseif action="edit" then
		sql="update research set sno='"&sno&"', subject='"&subject&"', A='"&A&"', B='"&B&"', C='"&C&"', D='"&D&"', E='"&E&"', F='"&F&"', others='"&others&"', flag="&flag&" where id="&id_option
	end If
	response.write sql
	conn.execute(sql)
	response.write sql
	conn.close
	response.redirect "surveyoptionlist.asp?page="&CurrentPage&"&keyword="&keyword&"&id="&id&"&term_name="&term_name
End If 



if action="new" then
	pagetitle="添加问卷调查题目"
elseif action="edit" then
	sql="select * from research where id=" & id_option
	rs.open sql,conn,1,1
	sno=rs("sno")
	subject=rs("subject")
	A=rs("A")
	B=rs("B")
	C=rs("C")
	D=rs("D")
	E=rs("E")
	F=rs("F")
	others=rs("others")
	flag=rs("flag")
	rs.close
	pagetitle="编辑问卷调查题目"
elseif action="del" Then
	sql="delete from research where id=" & id_option
	conn.execute(sql)
	conn.close
	response.redirect "surveyoptionlist.asp?page="&CurrentPage&"&keyword="&keyword&"&id="&id&"&term_name="&term_name
elseif action="flagdisplay" Then
	sql="update research set isdisp = not isdisp where id=" & id_option
	conn.execute(sql)
	conn.close
	response.redirect "surveyoptionlist.asp?page="&CurrentPage&"&keyword="&keyword&"&id="&id&"&term_name="&term_name
end if
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
<form method="post" name="form1" id="form1">
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--表格-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 fs18"><%=strModuleName%> - <%=pagetitle%> - <%=term_name%></div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>编号</td>
			<td><input type="text" name="sno" size="10" maxlength="10" class="input req-string req-numeric" style="width:60px" value="<%=sno%>" /></td>
		</tr>
		<tr>
			<td>主题</td>
			<td><input type="text" name="subject" size="70" maxlength="100" class="input req-string" style="width:460px" value="<%=subject%>" /></td>
		</tr>
		<tr>
			<td>选项A</td>
			<td colspan="3"><input type="text" name="A" size="70" maxlength="100" value="<%=A%>" /></td>
		</tr>
		<tr>
			<td>选项B</td>
			<td colspan="3"><input type="text" name="B" size="70" maxlength="100" value="<%=B%>" /></td>
		</tr>
		<tr>
			<td>选项C</td>
			<td colspan="3"><input type="text" name="C" size="70" maxlength="100" value="<%=C%>" /></td>
		</tr>
		<tr>
			<td>选项D</td>
			<td colspan="3"><input type="text" name="D" size="70" maxlength="100" value="<%=D%>" /></td>
		</tr>
		<tr>
			<td>选项E</td>
			<td colspan="3"><input type="text" name="E" size="70" maxlength="100" value="<%=E%>" /></td>
		</tr>
		<tr>
			<td>选项F</td>
			<td colspan="3"><input type="text" name="F" size="70" maxlength="100" value="<%=F%>" /></td>
		</tr>
		<tr>
			<td>填空题</td>
			<td colspan="3"><input type="text" name="others" size="70" maxlength="255" value="<%=others%>" /></td>
		</tr>
		<tr>
			<td>是否多选</td>
			<td colspan="3"><input type="checkbox" name="flag" value="true"<%if flag=true then%>checked<%end if%> /></td>
		</tr>
		<tr>
			<td colspan="4" class="c">
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" /> 
				<input type="hidden" value="<%=action%>" name="action" />
				<input type="hidden" value="<%=id%>" name="id" />
				<input type="hidden" value="<%=id_option%>" name="id_option" />
				<div id="errorDiv" class="error-div"></div>
			</td>
		</tr>
	</table>
</div>
</form>
<script>
var editor;

$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 1 });

	//表单验证及提交
	$('#btnsave').formValidator({
		scope : '#form1',
		errorDiv : '#errorDiv'
	});

	$('#btnreturn').click( function(){
		history.back();
	});
})


</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->