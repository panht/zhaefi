<!--#include file="uc/conn.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title><%=art_title%> - �麣����Ͷ����ҵЭ��</title>
	<meta name="keywords" content="<%=art_title%> - �麣����Ͷ����ҵЭ��">
	<meta name="description" content="<%=art_title%> - �麣����Ͷ����ҵЭ��">
	<link href="static/css/Style.css" type="text/css" rel="stylesheet">
	<link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon"> 
</head>
<body> 
<form method="post" name="form1" id="form1">
<!--ͷ��-->
<!--#include file="uc/top.asp" -->


<!--�в���ʼ-->
<div class="ma w980">
<!--������ʼ-->
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
 if len(AddDate) > 5 then AddDate = "�������ڣ�" & formatdatetime(cdate(AddDate), 2)
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
				<tr><td class="news1"><br><br><hr>[<b><%=subject%></b>]���ϱ�����</td></tr>
				<tr><td class="news1">����дҪ�󣺡���<%=remarks%></td></tr>
				<tr><td class="news1">
					��˾���ƣ�<input type="text" name="company" id="company" size="30" maxlength="50"><font color=red>*</font>&nbsp;
					�μ���������<input type="text" name="applyUsername" id="applyUsername" size="30" maxlength="50"><font color=red>*</font>
				</td></tr>
				<tr><td class="news1">
					ְ��<input type="text" name="title" id="title" size="15" maxlength="50"><font color=red>*</font>&nbsp;
					��ϵ�绰��<input type="text" name="tel" id="tel" size="15" maxlength="50"><font color=red>*</font>&nbsp;
					���棺<input type="text" name="fax" id="fax" size="15" maxlength="50"><font color=red>*</font>&nbsp;
				</td></tr>
				<tr><td class="news1">
					�ֻ���<input type="text" name="cellphone" id="cellphone" size="15" maxlength="50"><font color=red>*</font>
					�ֻ���Ӫ�̣�<select name="SP" id="SP"><option value="">��ѡ��</option><option value="�ƶ�">�ƶ�</option><option value="��ͨ">��ͨ</option><option value="����">����</option><option value="����">����</option></select>��Э�����鴦���Զ�����ʽ֪ͨ�λ�������ˣ�
				</td></tr>
				<tr><td class="news1">
					�������䣺<input type="text" name="email" id="email" size="50" maxlength="50">
				</td></tr>
				<tr><td class="news1">��ע��<input type="text" name="Remarks" id="Remarks" size="50" maxlength="50"></td></tr>
<input type="hidden" name="flagfree" id="flagfree" value="<%=flagfree%>">
<% If FlagFree=false Then%>
				<tr><td class="news1">��˾׼������ѡ�񣩣� 
				<input type="radio" value="1" name="FeeType" id="FeeType" style="border:0 0 0 0"/>�ֳ���������&nbsp;
				<input type="radio" value="2" name="FeeType" id="FeeType" style="border:0 0 0 0" checked />��ǰ��������&nbsp;
				<input type="radio" value="3" name="FeeType" id="FeeType" style="border:0 0 0 0"/>ʹ��ѧϰ����������&nbsp;
				<font color=red>*</font> </td></tr>
				<tr>
					<td class="news1" align="center">
						<div id="divFee" style="text-align:center;">��Ա��ҵ��<font color=red><%=PriceMember%></font>/�ˣ��ǻ�Ա��ҵ��<font color=red><%=Price%></font>/��</div>
						<div id="divFeeCard" style="display:none;text-align:center;">ʹ��ѧϰ����������Ա��ҵ��<font color=red><%=PriceMemberCard%></font>/�ˣ��ǻ�Ա��ҵ��<font color=red><%=PriceCard%></font>/��</div>
					</td>
				</tr>
				<tr>
					<td class="news1">
						<div id="divTrainingCard" style="display:none">
							ѧϰ���ţ�<input type="input" name="cardno" id="cardno" size="12" />
							&nbsp;&nbsp;���룺<input type="password" name="cardpassword" id="cardpassword" size="12" />
							&nbsp;&nbsp;����������<input type="input" name="applyQuantity" id="applyQuantity" size="3" />��
						</div>
					</td>
				</tr>
<%End If%>
				<tr><td class="news1" align="center"><input type="button" name="save" value="�ύ������" class="button1" style="height:25px" id="btnsave">&nbsp;<input type="reset"  name="button" value="����" class="button1" style="height:25px"></td></tr>
				<input type="hidden" name="LectureID" id="LectureID" value="<%=id%>">
			</tbody></table>
<script language="javascript">
function chk(){
	// ��У��
	if($("#company").val() == ""){
		alert("����д��˾���ƣ�");
		$("#company")[0].focus();
		return false;
	}
	if($("#applyUsername").val() == ""){
		alert("����д�μ���������");
		$("#applyUsername")[0].focus();
		return false;
	}
	if($("#title").val() == ""){
		alert("����дְ��");
		$("#title")[0].focus();
		return false;
	}
	if($("#tel").val() == ""){
		alert("����д��ϵ�绰��");
		$("#tel")[0].focus();
		return false;
	}
	if($("#fax").val() == ""){
		alert("����д���棡");
		$("#fax")[0].focus();
		return false;
	}
	if($("#cellphone").val() == ""){
		alert("����д�ֻ����룡");
		$("#cellphone")[0].focus();
		return false;
	}
	//  ���ѡ��ʹ��ѧϰ������
	if ($("#FeeType:checked").val() == "3") {
		if($("#cardno").val() == ""){
			alert("����дѧϰ���ţ�");
			$("#cardno")[0].focus();
			return false;
		}
		if($("#cardpassword").val() == ""){
			alert("����дѧϰ�����룡");
			$("#cardpassword")[0].focus();
			return false;
		}
		if($("#applyQuantity").val() == ""){
			alert("����д����������");
			$("#applyQuantity")[0].focus();
			return false;
		}
		if(isNaN($("#applyQuantity").val()) === true){
			alert("�����������������֣�");
			$("#applyQuantity")[0].focus();
			return false;
		}
	}
	
	// ȡֵ
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
	
	// �������֤������
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
<!--�ʾ�������-->
    </div>
</div>

</div>
<!--��������-->
<!--����-->
<!--#include file="uc/sidebar.asp" -->
<div style="clear:both; height:0;"></div>
</div>
<!--�в�����-->



<!--�ײ�-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->