<!--#include file="uc/conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=art_title%> - 珠海外商投资企业协会</title>
	<meta name="keywords" content="<%=art_title%> - 珠海外商投资企业协会">
	<meta name="description" content="<%=art_title%> - 珠海外商投资企业协会">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1" id="form1">
<!--头部-->
<!--#include file="uc/top.asp" -->


<!--中部开始-->
<div class="ma w980">
<!--左栏开始-->
<div class="ma w730 fl">

<div class="article mtop10">
    <div class="article_line">
    </div>
	<div class="article_content">
        
<table cellspacing=5 cellpadding=0 width="100%" border=0 align="center" class="borders3"><tbody>
<%
ID=request("id")
sql="select * from Lecture where LectureID = "&ID
rs.open sql,conn,1,1
Subject=rs("Subject")
Content=rs("Content")
TargetUser=rs("TargetUser")
LectureDate=rs("LectureDate")
Address=rs("Address")
Fee=rs("Fee")
Contacts=rs("Contacts")
Tel=rs("Tel")
Fax=rs("Fax")
FlagFree=rs("FlagFree")
AddDate=rs("AddDate")
Remarks=rs("Remarks")
Price=rs("Price")
PriceMember=rs("PriceMember")
PriceMemberCard=rs("PriceMemberCard")
PriceCard=rs("PriceCard")
 if len(AddDate) > 5 then AddDate = "发布日期：" & formatdatetime(cdate(AddDate), 2)
rs.close%>
				<tr><td Class="news" align="center">
					<h1>
						<span><%=Subject%></span>
					</h1>
				</td></tr>
				<tr><td align="right">
					<%=adddate%></td></tr>
				<tr><td height="2" bgcolor="#02519c"></td></tr>
				<tr><td class="news1"><%=replace(replace(replace(replace(content,chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", chr(39)), "&nbsp;", "")%></td></tr>
				<tr><td class="news1"><br><br><hr>[<b><%=subject%></b>]网上报名表</td></tr>
				<tr><td class="news1">【填写要求：】：<%=remarks%></td></tr>
				<tr><td class="news1">
					公司名称：<input type="text" name="company" id="company" size="30" maxlength="50"><font color=red>*</font>&nbsp;
					参加者姓名：<input type="text" name="applyUsername" id="applyUsername" size="30" maxlength="50"><font color=red>*</font>
				</td></tr>
				<tr><td class="news1">
					职务：<input type="text" name="title" id="title" size="15" maxlength="50"><font color=red>*</font>&nbsp;
					联系电话：<input type="text" name="tel" id="tel" size="15" maxlength="50"><font color=red>*</font>&nbsp;
					传真：<input type="text" name="fax" id="fax" size="15" maxlength="50"><font color=red>*</font>&nbsp;
				</td></tr>
				<tr><td class="news1">
					手机：<input type="text" name="cellphone" id="cellphone" size="15" maxlength="50"><font color=red>*</font>
					手机运营商：<select name="SP" id="SP"><option value="">请选择</option><option value="移动">移动</option><option value="联通">联通</option><option value="电信">电信</option><option value="其他">其他</option></select>（协会秘书处将以短信形式通知参会具体事宜）
				</td></tr>
				<tr><td class="news1">
					电子邮箱：<input type="text" name="email" id="email" size="50" maxlength="50">
				</td></tr>
				<tr><td class="news1">备注：<input type="text" name="Remarks" id="Remarks" size="50" maxlength="50"></td></tr>
<input type="hidden" name="flagfree" id="flagfree" value="<%=flagfree%>">
<% If FlagFree=false Then%>
				<tr><td class="news1">贵公司准备（请选择）： 
				<input type="radio" value="1" name="FeeType" id="FeeType" style="border:0 0 0 0"/>现场交报名费&nbsp;
				<input type="radio" value="2" name="FeeType" id="FeeType" style="border:0 0 0 0" checked />提前交报名费&nbsp;
				<input type="radio" value="3" name="FeeType" id="FeeType" style="border:0 0 0 0"/>使用学习卡交报名费&nbsp;
				<font color=red>*</font> </td></tr>
				<tr>
					<td class="news1" align="center">
						<div id="divFee" style="text-align:center;">会员企业￥<font color=red><%=PriceMember%></font>/人，非会员企业￥<font color=red><%=Price%></font>/人</div>
						<div id="divFeeCard" style="display:none;text-align:center;">使用学习卡报名，会员企业￥<font color=red><%=PriceMemberCard%></font>/人，非会员企业￥<font color=red><%=PriceCard%></font>/人</div>
					</td>
				</tr>
				<tr>
					<td class="news1">
						<div id="divTrainingCard" style="display:none">
							学习卡号：<input type="input" name="cardno" id="cardno" size="12" />
							&nbsp;&nbsp;密码：<input type="password" name="cardpassword" id="cardpassword" size="12" />
							&nbsp;&nbsp;报名人数：<input type="input" name="applyQuantity" id="applyQuantity" size="3" />人
						</div>
					</td>
				</tr>
<%End If%>
				<tr><td class="news1" align="center"><input type="button" name="save" value="提交报名表" class="button1" style="height:25px" id="btnsave">&nbsp;<input type="reset"  name="button" value="重填" class="button1" style="height:25px"></td></tr>
				<input type="hidden" name="LectureID" id="LectureID" value="<%=id%>">
			</tbody></table>
<script language="javascript">
function chk(){
	// 表单校验
	if($("#company").val() == ""){
		alert("请填写公司名称！");
		$("#company")[0].focus();
		return false;
	}
	if($("#applyUsername").val() == ""){
		alert("请填写参加者姓名！");
		$("#applyUsername")[0].focus();
		return false;
	}
	if($("#title").val() == ""){
		alert("请填写职务！");
		$("#title")[0].focus();
		return false;
	}
	if($("#tel").val() == ""){
		alert("请填写联系电话！");
		$("#tel")[0].focus();
		return false;
	}
	if($("#fax").val() == ""){
		alert("请填写传真！");
		$("#fax")[0].focus();
		return false;
	}
	if($("#cellphone").val() == ""){
		alert("请填写手机号码！");
		$("#cellphone")[0].focus();
		return false;
	}
	//  如果选中使用学习卡报名
	if ($("#FeeType:checked").val() == "3") {
		if($("#cardno").val() == ""){
			alert("请填写学习卡号！");
			$("#cardno")[0].focus();
			return false;
		}
		if($("#cardpassword").val() == ""){
			alert("请填写学习卡密码！");
			$("#cardpassword")[0].focus();
			return false;
		}
		if($("#applyQuantity").val() == ""){
			alert("请填写报名人数！");
			$("#applyQuantity")[0].focus();
			return false;
		}
		if(isNaN($("#applyQuantity").val()) === true){
			alert("报名人数请输入数字！");
			$("#applyQuantity")[0].focus();
			return false;
		}
	}
	
	// 取值
	flagfree = $("#flagfree").val();
	LectureID=$("#LectureID").val();
	company=encodeURIComponent(encodeURIComponent($("#company").val()));
	applyUsername=encodeURIComponent(encodeURIComponent($("#applyUsername").val()));
	feetype=$("#FeeType:checked").val().trim();
	tel=encodeURIComponent(encodeURIComponent($("#tel").val()));
	fax=encodeURIComponent(encodeURIComponent($("#fax").val()));
	cellphone=encodeURIComponent(encodeURIComponent($("#cellphone").val()));
	SP=encodeURIComponent(encodeURIComponent($("#SP").val()));
	title=encodeURIComponent(encodeURIComponent($("#title").val()));
	email=encodeURIComponent(encodeURIComponent($("#email").val()));
	Remarks=encodeURIComponent(encodeURIComponent($("#Remarks").val()));
	cardno=encodeURIComponent(encodeURIComponent($("#cardno").val()));
	cardpassword=encodeURIComponent(encodeURIComponent($("#cardpassword").val()));
	applyQuantity=encodeURIComponent(encodeURIComponent($("#applyQuantity").val()));
	
	// 服务端验证及保存
	$.ajax({
		type: "GET",
		url: "lectureApply.asp?action=apply",
		data: "flagfree=" + flagfree + "&LectureID=" + LectureID + "&company=" + company + "&applyUsername=" + applyUsername + "&tel=" + tel + "&fax=" + fax + "&cellphone=" + cellphone + "&SP=" + SP + "&title=" + title + "&email=" + email + "&Remarks=" + Remarks + "&cardno=" + cardno + "&cardpassword=" + cardpassword + "&applyQuantity=" + applyQuantity + "&feetype=" + feetype,
		success: (function(result) {
			result = eval(result);
			if (result[0].code < 0) {
				alert(result[0].message);
			} else {
				alert(result[0].message);
				$("#form1")[0].reset();
			}
		}),
	});
	//document.form1.submit();
}

$(document).ready(function() {
	$("#btnsave").click(function() {
		chk();
	});

	$("input[name='FeeType']").click(function() {
		if ($(this).val() == 3) {
			$("#divTrainingCard").css("display", "block");
			$("#divFee").css("display", "none");
			$("#divFeeCard").css("display", "block");
		} else {
			$("#divTrainingCard").css("display", "none");
			$("#divFee").css("display", "block");
			$("#divFeeCard").css("display", "none");
		}
	});
});
</script>
<!--问卷调查结束-->
    </div>
</div>

</div>
<!--左栏结束-->
<!--右栏-->
<!--#include file="uc/sidebar.asp" -->
<div style="clear:both; height:0;"></div>
</div>
<!--中部结束-->



<!--底部-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->