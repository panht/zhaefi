<!--#include file="../uc/conn.asp"-->
<%strModuleName="问卷调查"%>
<!--#include file="uc/userright.asp"-->
<%
id=request("id")
CurrentPage = request("Page")
action=request("action")

'保存操作
If request.Form("save") = "保存" Then
	term_name=request("term_name")
	foreword=request("foreword")
	description=request("description")	
	description=replace(replace(description, chr(39), "&#39;"), chr(34), "&quot;")

	if action="new" Then
		sql="insert into research_term(term_name, foreword, description) values('"&term_name&"', '"&foreword&"',  '"&description&"')"
	elseif action="edit" then
		sql="update research_term set term_name='"&term_name&"',foreword='"&foreword&"',description='"&description&"' where id="&id
	end If
	conn.execute(sql)
	response.write sql
	conn.close
	response.redirect "surveylist.asp?page="&CurrentPage&"&keyword="&keyword
End If 



if action="new" then
	pagetitle="添加问卷调查"
elseif action="edit" then
	sql="select * from research_term where id=" & id
	rs.open sql,conn,1,1
	term_name=rs("term_name")
	foreword=rs("foreword")
	description=rs("description")
	rs.close
	pagetitle="编辑问卷调查"
elseif action="del" Then
	sql="delete from research_term where id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "surveylist.asp?page="&CurrentPage&"&keyword="&keyword
elseif action="flagdisplay" Then
	sql="update research_term set isdisp = not isdisp where id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "surveylist.asp?page="&CurrentPage&"&keyword="&keyword
end if
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>珠海外商投资企业协会</title>	
	<link rel="stylesheet" href="../static/js/ufvalidator/ufvalidator.css" />
	<link rel="stylesheet" href="../static/js/cleditor/jquery.cleditor.css" />
<!--#include file="uc/static.asp" -->
	<script src="../static/js/ufvalidator/jquery.ufvalidator.js" type="text/javascript"></script>
	<script src="../static/js/cleditor/jquery.cleditor.js" type="text/javascript"></script>
	<script src="../static/js/QuickUpload/CJL.0.1.min.js" type="text/javascript"></script>
	<script src="../static/js/QuickUpload/QuickUpload.js" type="text/javascript"></script>
</head>
<body> 
<form method="post" name="form1" id="form1">
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--表格-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 fs18"><%=strModuleName%></div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>主题</td>
			<td><input type="text" name="term_name" size="70" maxlength="100" class="input req-string" style="width:460px" value="<%=term_name%>" /></td>
		</tr>
		<tr>
			<td>前言</td>
			<td colspan="3">
				<textarea id="inputCLE" name="foreword"><%=foreword%></textarea>
			</td>
		</tr>
		<tr>
			<td>说明</td>
			<td colspan="3"><input type="text" name="description" size="70" maxlength="100" value="<%=description%>" /></td>
		</tr>
		<tr>
			<td colspan="4" class="c">
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" /> 
				<input type="hidden" value="<%=action%>" name="action" /> 
				<input type="hidden" value="<%=id%>" name="id" /> 
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

	editor = $("#inputCLE").cleditor({
          width:       700, // height not including margins, borders or padding
          height:       250, // height not including margins, borders or padding
         controls:     // controls to add to the toolbar
                        "bold underline | size color removeformat | outdent " +
                        "indent | alignleft center alignright justify | undo redo | " +
                        "rule image link unlink pastetext | source" 
	})[0];
})


</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->