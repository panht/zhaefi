<!--#include file="../uc/conn.asp"-->
<%
strModuleName="学习卡"
%>
<!--#include file="uc/userright.asp"-->
<%
id=request("id")
CurrentPage = request("Page")
keyword=request("keyword")
action=request("action")

'保存操作
If request.Form("save") = "保存" Then
	TrainingCardID=request("TrainingCardID")
	RecordType=1 '充值为1
	cardno=request("cardno")
	Amount=request("Amount")
	RecordTime=request("RecordTime")
	if isnull(RecordTime) then RecordTime=""
	if len(RecordTime)=0 then
		RecordTime=cdate("1900-1-1")
	else
		RecordTime=cdate(RecordTime)
	end if
	Remark=request("Remark")
	createby=request("createby")

	if action="charge" Then
		sql="insert into trainingcardrecord (TrainingCardID, RecordType, CardNo, Amount, RecordTime, Remark, createby) values("&TrainingCardID&", "&RecordType&", '"&cardno&"', "&Amount&", #"&RecordTime&"#, '"&Remark&"', '"&createby&"')"
		conn.execute(sql)
		sql = "update trainingcard set balance = balance + " & amount & ", updatetime=now() where id = " & TrainingCardID
		conn.execute(sql)
	end If
	conn.close
	response.redirect "trainingcardlist.asp?page="&CurrentPage&"&keyword="&keyword
End If 



if action="charge" then
	pagetitle="充值"
	
	sql = "select * from trainingcard where id = "& id
	rs.open sql, conn, 1, 1
	if not rs.eof then
		cardtype = rs("cardtype")
		cardno = rs("cardno")
		companyname = rs("companyname")
	end if
	rs.close
	RecordTime = formatdatetime(date, 2)
	createby=session("AdminUsername")
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
	<div class="c c2 fs18"><%=strModuleName%></div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>类别</td>
			<td><%=cardtype%></td>
			<td>学习卡号</td>
			<td><%=cardno%></td>
		</tr>
		<tr>
			<td>企业名称</td>
			<td colspan="3"><%=companyname%></td>
		</tr>
		<tr>
			<td>充值金额</td>
			<td><input type="text" name="Amount" size="20" maxlength="10" class="input req-string req-numeric" /></td>
			<td>充值日期</td>
			<td><input type="text" name="RecordTime" size="15" maxlength="15" class="input req-string" value="<%=RecordTime%>" /></td>
		</tr>
		<tr>
			<td>备注</td>
			<td><input type="text" name="remark" class="input" style="width:400px" maxlength="200" /></td>
		</tr>
		<tr>
			<td colspan="4" class="c">
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" /> 
				<input type="hidden" value="<%=id%>" name="TrainingCardID" /> 
				<input type="hidden" value="<%=CardNo%>" name="CardNo" /> 
				<input type="hidden" value="<%=createby%>" name="createby" />
				<input type="hidden" value="<%=action%>" name="action" /> 
				<div id="errorDiv" class="error-div"></div>
			</td>
		</tr>
	</table>
	</div>
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