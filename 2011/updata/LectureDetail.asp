<!--#include file="../uc/conn.asp"-->
<%strModuleName="��������"%>
<!--#include file="uc/userright.asp"-->
<%
id=request("id")
CurrentPage = request("Page")
keyword=request("keyword")
action=request("action")

'�������
If request.Form("save") = "����" Then
	Subject=request("Subject")
	AddDate=request("AddDate")
	if isnull(AddDate) then AddDate=""
	if len(AddDate)=0 then
		AddDate=Now()
	else
		AddDate=cdate(AddDate)
	end if
	Content=request("Content")
	PublishingDate=request("PublishingDate")
	'TargetUser=request("TargetUser")
	'LectureDate=request("LectureDate")
	'Address=request("Address")
	'Fee=request("Fee")
	'Contacts=request("Contacts")
	'Tel=request("Tel")
	'Fax=request("Fax")
	PriceMember=request("PriceMember")
	PriceMemberCard=request("PriceMemberCard")
	PriceCard=request("PriceCard")
	Price=request("Price")
	Remarks=request("Remarks")
	flagfree=request("flagfree")
	Content=replace(replace(Content, chr(39), "&#39;"), chr(34), "&quot;")

	if action="new" Then
		sql="insert into Lecture(subject, content, Remarks, AddDate, flagfree, PriceMember, PriceMemberCard, Price, PriceCard) values('" & subject & "', '" & content & "', '" & Remarks & "', #" & AddDate & "#, '" & flagfree & "', " & PriceMember & ", " & PriceMemberCard & ", " & Price & ", " & PriceCard & ")"
	elseif action="edit" then
		sql="update Lecture set subject='"&subject&"', content='" & content & "', Remarks='" & Remarks & "', AddDate=#" & AddDate & "#, flagfree='" & flagfree & "', PriceMember=" & PriceMember & ", PriceMemberCard=" & PriceMemberCard & ", Price=" & Price & ", PriceCard=" & PriceCard & " where LectureID=" & id
	end If
	conn.execute(sql)
	response.write sql
	conn.close
	response.redirect "lecturelist.asp?page="&CurrentPage&"&keyword="&keyword
End If 



if action="new" then
	pagetitle="��ӽ���"
	PriceMember=0
	PriceMemberCard=0
	PriceCard=0
	Price=0
elseif action="edit" then
	sql="select * from Lecture where Lectureid=" & id
	rs.open sql,conn,1,1
	Subject=rs("Subject")
	AddDate=rs("AddDate")
	Content=rs("Content")
	Remarks=rs("Remarks")
	FlagFree=rs("FlagFree")
	PriceMember=rs("PriceMember")
	PriceMemberCard=rs("PriceMemberCard")
	PriceCard=rs("PriceCard")
	Price=rs("Price")
	rs.close
	pagetitle="�༭����"
elseif action="del" Then
	sql="delete from Lecture where Lectureid=" & id
	conn.execute(sql)
	sql="delete from LectureSignUp where LectureID=" & id
	conn.execute(sql)
	conn.close
	response.redirect "lecturelist.asp?page="&CurrentPage&"&keyword="&keyword
elseif action="flagdisplay" Then
	sql="update Lecture set flagdisplay = not flagdisplay where LectureID=" & id
	conn.execute(sql)
	conn.close
	response.redirect "lecturelist.asp?page="&CurrentPage&"&keyword="&keyword
end if
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>�麣����Ͷ����ҵЭ��</title>	
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
<!--�˵�-->
<!--#include file="uc/menu.asp" -->

<!--���-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 fs18"><%=strModuleName%></div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>��������</td>
			<td><input type="text" name="subject" size="50" maxlength="255" class="input req-string" style="width:460px" value="<%=subject%>" /></td>
		</tr>
		<tr>
			<td>����ʱ��</td>
			<td><input type="text" name="AddDate" size="20" maxlength="20" value="<%=AddDate%>" />(yyyy-mm-dd)</td>
		</tr>
		<tr>
			<td>�Ƿ����</td>
			<td>
				<input type="radio" name="flagfree" value="1" <%If flagfree=true Then response.write " checked"%>>��&nbsp;
				<input type="radio" name="flagfree" value="0" <%If flagfree=False Then response.write " checked"%>>��
				
				<div id="divPrice" style="display:block">
					�ǻ�Ա��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����<input type="input" name="Price" value="<%=Price%>" class="input req-string req-numeric" style="width:60px;text-align:right;" /> /��<br/><br/>
					��Ա��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����<input type="input" name="PriceMember" value="<%=PriceMember%>" class="input req-string req-numeric" style="width:60px;text-align:right;" /> /��<br/><br/>
					�ǻ�Աѧϰ���ۣ���<input type="input" name="PriceCard" value="<%=PriceCard%>" class="input req-string req-numeric" style="width:60px;text-align:right;" /> /��<br/><br/>
					��Աѧϰ����&nbsp;&nbsp;����<input type="input" name="PriceMemberCard" value="<%=PriceMemberCard%>" class="input req-string req-numeric" style="width:60px;text-align:right;" /> /��
				</div>
			</td>
		</tr>
		<tr>
			<td>��дҪ��</td>
			<td><input type="text" name="Remarks" size="70" maxlength="70" value="<%=Remarks%>" /></td>
		</tr>
		<tr>
			<td>��������</td>
			<td>
				<textarea id="inputCLE" name="Content"><%=Content%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="c">
				<input type='submit' value='����' name="save" id="btnsave" /> 
				<input type='button' value='����' name="return" id="btnreturn" /> 
				<input type="hidden" value="<%=action%>" name="action" /> 
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

	//����֤���ύ
	$('#btnsave').formValidator({
		scope : '#form1',
		errorDiv : '#errorDiv'
	});
	
	// �Ƿ���ѵ�ѡť
	$(":radio").click(function() {
		if ($(":radio:checked").val() == 0) {
			$("#divPrice").css("display", "block");
		} else {
			$("#divPrice").css("display", "none");
		}
	});
	
	// ���ذ�ť
	$('#btnreturn').click( function(){
		history.back();
	});
	
	// cl�༭��
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