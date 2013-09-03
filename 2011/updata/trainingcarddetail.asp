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
	cardstatus=request("cardstatus")
	cardno=request("cardno")
	OwnerName=request("OwnerName")
	OwnerCellphone=request("OwnerCellphone")
	OwnerEmail=request("OwnerEmail")
	Memo=request("Memo")
	createdate=request("createdate")
	if isnull(createdate) then createdate=""
	if len(createdate)=0 then
		createdate=cdate("1900-1-1")
	else
		createdate=cdate(createdate)
	end if
	CancelDate=request("CancelDate")
	if isnull(CancelDate) then CancelDate=""
	if len(CancelDate)=0 then
		CancelDate=cdate("1900-1-1")
	else
		CancelDate=cdate(CancelDate)
	end if
	 
	'createby=request("createby")
	
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
		password = "555555"
		sql="insert into trainingcard (memberid, companyName, cardtype, cardstatus, cardno, OwnerName, OwnerCellphone, OwnerEmail, [Memo], balance, [password], createdate, CancelDate, createby, updateby) values("&memberid&", '"&companyName&"', '"&cardtype&"', '"&cardstatus&"', '"&cardno&"', '"&OwnerName&"', '"&OwnerCellphone&"', '"&OwnerEmail&"', '"&Memo&"', 0, '"&password&"', #"&createdate&"#, #"&CancelDate&"#, '"&session("AdminUsername")&"', '"&session("AdminUsername")&"')"
		response.write sql
		conn.execute(sql)
	elseif action="edit" then
		sql="update trainingcard set memberid="&memberid&", companyName='"&companyName&"', cardtype='"&cardtype&"', cardstatus='"&cardstatus&"', cardno='"&cardno&"', OwnerName='"&OwnerName&"', OwnerCellphone='"&OwnerCellphone&"', OwnerEmail='"&OwnerEmail&"', [Memo]='"&Memo&"',  createdate=#"&createdate&"#,  CancelDate=#"&CancelDate&"#, updateby='"&session("AdminUsername")&"', updatetime=now() where id="&id
		response.write sql
		conn.execute(sql)
	end If
	conn.close
	response.redirect "trainingcardlist.asp?page="&CurrentPage&"&keyword="&keyword
End If 



if action="new" then
	pagetitle="开卡"
	cardtype=1
	cardstatus=1
	balance=0
	createdate = formatdatetime(date, 2)
	createtime = formatdatetime(date, 2)
	createby=session("AdminUsername")
	updatetime = createtime
	updateby = createby
	' 默认密码
	password = "555555"
elseif action="edit" then
	sql="select * from trainingcard where id=" & id
	rs.open sql,conn,1,1
	memberid=rs("memberid")
	companyName=rs("companyName")
	cardtype=rs("cardtype")
	cardstatus=rs("cardstatus")
	cardno=rs("cardno")
	OwnerName=rs("OwnerName")
	OwnerCellphone=rs("OwnerCellphone")
	OwnerEmail=rs("OwnerEmail")
	password=rs("password")
	balance=rs("balance")
	Memo=rs("Memo")
	createdate=formatdatetime(rs("createdate"), 2)
	if len(rs("CancelDate")) > 0 then
		CancelDate=formatdatetime(rs("CancelDate"), 2)
	end if
	CreateTime=formatdatetime(rs("CreateTime"), 2)
	createby=rs("createby")
	updatetime=formatdatetime(rs("updatetime"), 2)
	updateby=rs("updateby")
	rs.close
	pagetitle="编辑学习卡"
elseif action="del" Then
	sql="delete from trainingcard where id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "trainingcardlist.asp?page="&CurrentPage&"&keyword="&keyword
elseif action="resetPassword" Then
	sql="update trainingcard set [password] = '555555' where id=" & id
	conn.execute(sql)
%>
	<script language="javascript">
		alert("密码已重置为555555");
		window.location.href = "./trainingcardlist.asp?page=<%=CurrentPage%>&keyword=<%=keyword%>";
	</script>
<%
	response.end
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
			<td>卡号</td>
			<td><input type="text" name="cardno" size="20" maxlength="20" class="input req-string" value="<%=cardno%>" /><input type="hidden" name="cardnoOld" value="<%=cardno%>" /></td>
			<td>密码</td>
			<td>默认密码为555555</td>
		</tr>
		<tr>
			<td>企业名称</td>
			<td colspan="3"><input type="text" name="companyname" id="companyname" size="40" maxlength="40" class="input req-string" style="width:400px" value="<%=companyname%>" /><input type="hidden" id="memberid" name="memberid" value="<%=memberid%>" />
			<div id="divCompanyName"  style="border:solid 1px; display:none; width: 300px;"></td>
		</tr>
		<tr>
			<td>持卡人姓名</td>
			<td><input type="text" name="OwnerName" size="20" maxlength="20" value="<%=OwnerName%>" /></td>
			<td>持卡人手机号码</td>
			<td><input type="text" name="OwnerCellphone" size="20" maxlength="12" value="<%=OwnerCellphone%>" /></td>
		</tr>
		<tr>
			<td>持卡人电邮</td>
			<td><input type="text" name="OwnerEmail" size="50" maxlength="50" value="<%=OwnerEmail%>" /></td>
			<td>余额</td>
			<td><input type="text" name="Balance" size="20" maxlength="20" class="input req-string" value="<%=Balance%>" disabled /></td>
		</tr>
		<tr>
			<td>开卡日期</td>
			<td><input type="text" name="createdate" size="15" maxlength="15" class="input req-string" value="<%=createdate%>" /> yyyy-mm-dd</td>
			<td>类型</td>
			<td><input type="radio" name="cardtype" value="会员卡" <%if cardtype="会员卡" then response.write "checked"%>/>会员卡&nbsp;&nbsp;<input type="radio" name="cardtype" value="非会员卡" <%if cardtype="非会员卡" then response.write "checked"%>/>非会员卡</td>
		</tr>
		<tr>
			<td>状态</td>
			<td><input type="radio" name="cardStatus" value="已激活" <%if cardStatus="已激活" then response.write "checked"%>/>已激活&nbsp;&nbsp;<input type="radio" name="cardStatus" value="已注销" <%if cardStatus="已注销" then response.write "checked"%>/>已注销&nbsp;&nbsp;<input type="radio" name="cardStatus" value="冻结中" <%if cardStatus="冻结中" then response.write "checked"%>/>冻结中</td>
			<td>注销日期</td>
			<td><input type="text" name="Canceldate" size="15" maxlength="15"  value="<%=Canceldate%>" /> yyyy-mm-dd</td>
		</tr>
		<tr>
			<td>备注</td>
			<td colspan="3"><input type="text" name="Memo" size="50" maxlength="200" value="<%=Memo%>" /></td>
		</tr>
		<tr>
			<td>创建人</td>
			<td><%=createby%></td>
			<td>创建时间</td>
			<td><%=createtime%></td>
		</tr>
		<tr>
			<td>最后修改人</td>
			<td><%=updateBy%></td>
			<td>最后修改时间</td>
			<td><%=updatetime%></td>
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
		/*
			$.ajax({
				//type: "GET",
				//url: "memberop.asp",
				url: "http://pht-pc:82/general/crm/memberop.php?",
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
			*/
			$.getJSON("http://61.145.230.82:81/general/crm/memberop.php?action=companyName&name=" + value + "&callback=?",
				function(result) {  
					$("#divCompanyName").html("");
					$("#divCompanyName").css("display", "none");
					//var names = eval(msg);
					
					if (result != undefined && result.length > 0) {
						$("#divCompanyName").append("<ul>");
						
						for (var i = 0; i <  result.length; i++) {
							$("#divCompanyName").append("<li class='liCompanyName' style='padding:5px' id='" + result[i].id + "'>" + result[i].name + "</li>");
						}
						$("#divCompanyName").append("</ul>");
						$("#divCompanyName").css("display", "block");
					}
				}
			);  
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