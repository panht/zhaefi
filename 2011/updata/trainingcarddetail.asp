<% Session.CodePage=936 
Response.Charset="GBK" %> 
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
	memberid=request("memberid")
	if isnull(memberid) or memberid="" then memberid=0
	companyName=request("companyName")
	cardtype=request("cardtype")
	cardno=request("cardno")
	password=request("password")
	createdate=request("createdate")
	if isnull(createdate) then createdate=""
	if len(createdate)=0 then
		createdate=cdate("1900-1-1")
	else
		createdate=cdate(createdate)
	end if
	 
	createby=request("createby")
	
	' 卡号是否重复
	if action = "new" then
		sql = "select * from trainingcard where cardno = '" & cardno & "'"
	elseif action = "edit" then
		cardnoOld = request("cardnoOld")
		sql = "select * from trainingcard where cardno = '" & cardno & "' and cardno <> '" & cardnoOld & "'"
	end if
	rs.open sql, conn, 1, 1
	if not rs.eof then
		rs.close
%>
<script>
	alert("卡号重复，请重新输入");
	history.back();
</script>
<%
		response.end
	else
		rs.close
	end if
	
	'保存
	if action="new" Then
		sql="insert into trainingcard (memberid, companyName, cardtype, cardno, balance, [password], createdate, createby) values("&memberid&", '"&companyName&"', "&cardtype&", '"&cardno&"', 0, '"&password&"', #"&createdate&"#, '"&createby&"')"
		response.write sql
		conn.execute(sql)
	elseif action="edit" then
		sql="update trainingcard set memberid="&memberid&", companyName='"&companyName&"', cardtype="&cardtype&", cardno='"&cardno&"', [password]='"&password&"', createdate=#"&createdate&"#, createby='"&createby&"' where id="&id
		conn.execute(sql)
	end If
	conn.close
	response.redirect "trainingcardlist.asp?page="&CurrentPage&"&keyword="&keyword
End If 



if action="new" then
	pagetitle="开卡"
	cardtype=1
	createdate = formatdatetime(date, 2)
	createby=session("AdminUsername")
elseif action="edit" then
	sql="select * from trainingcard where id=" & id
	rs.open sql,conn,1,1
	memberid=rs("memberid")
	companyName=rs("companyName")
	cardtype=rs("cardtype")
	cardno=rs("cardno")
	password=rs("password")
	createdate=formatdatetime(rs("createdate"), 2)
	createby=rs("createby")
	rs.close
	pagetitle="编辑学习卡"
elseif action="del" Then
	sql="delete from trainingcard where id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "trainingcardlist.asp?page="&CurrentPage&"&keyword="&keyword
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
			<td colspan="3"><input type="radio" name="cardtype" value="1" <%if cardtype=1 then response.write "checked"%>/>会员卡&nbsp;&nbsp;<input type="radio" name="cardtype" value="2" <%if cardtype=2 then response.write "checked"%>/>非会员卡</td>
		</tr>
		<tr>
			<td>企业名称</td>
			<td colspan="3"><input type="text" name="companyname" id="companyname" size="40" maxlength="40" class="input req-string" style="width:400px" value="<%=companyname%>" /><input type="hidden" id="memberid" name="memberid" value="<%=memberid%>" />
			<div id="divCompanyName"  style="border:solid 1px; display:none; width: 300px;"></td>
		</tr>
		<tr>
			<td>卡号</td>
			<td><input type="text" name="cardno" size="20" maxlength="20" class="input req-string" value="<%=cardno%>" /><input type="hidden" name="cardnoOld" value="<%=cardno%>" /></td>
			<td>密码</td>
			<td><input type="text" name="password" size="20" maxlength="20" class="input req-string" value="<%=password%>" /></td>
		</tr>
		<tr>
			<td>开卡日期</td>
			<td><input type="text" name="createdate" size="15" maxlength="15" class="input req-string" value="<%=createdate%>" /></td>
			<td>经办人</td>
			<td><input type="text" name="createby" size="15" maxlength="15" class="input req-string" value="<%=createby%>" /></td>
		</tr>
		<tr>
			<td colspan="4" class="c">
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" /> 
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
	
	// 输入企业名称显示下拉选择
	$("#companyname").keyup(function(){
		var value = $(this).val().trim();
		if (value.length >= 2) {
			$.ajax({
				type: "GET",
				url: "memberop.asp",
				data: "action=companyName&name=" + value,
				success: function(msg) {
					$("#divCompanyName").html("");
					$("#divCompanyName").css("display", "none");
					
					var names = eval(msg);
					
					if (names != undefined && names.length > 0) {
						$("#divCompanyName").append("<ul>");
						
						for (var i = 0; i <  names.length; i++) {
							$("#divCompanyName").append("<li class='liCompanyName' style='padding:5px' id='" + names[i].id + "'>" + names[i].name + "</li>");
						}
						$("#divCompanyName").append("</ul>");
						$("#divCompanyName").css("display", "block");
					}
				}
			});
		}
	});
	
	// 企业名称下拉框点击
	$(".liCompanyName").live("click", function() {
		$("#companyname").val($(this).text());
		$("#memberid").val($(this).attr("id"));
		$("#divCompanyName").css("display", "none");
	});
	// 企业名称下拉框鼠标进入移开
	$(".liCompanyName").live("mouseover", function() {
		$(this).css("background-color", "#CCC");
	});
	$(".liCompanyName").live("mouseout", function() {
		$(this).css("background-color", "#FFF");
	});

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