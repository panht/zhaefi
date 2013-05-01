<!--#include file="../uc/conn.asp"-->
<%strModuleName="问卷调查"%>
<!--#include file="uc/userright.asp"-->
<%
id=request("id")
term_name=request("term_name")
answer_id=request("answer_id")
answer_date=request("answer_date")
CurrentPage = request("Page")
action=request("action")


if action="view" then
	sql="select * from research_result_main where id=" & answer_id
	rs.open sql,conn,1,1
	str = "公司名称：" + rs("company") + "<br>"
	str = str & "填写人：" + rs("name") + "<br>"
	str = str & "职务："+ rs("title") + "<br>"
	str = str & "电话："+ rs("tel") + "<br>"
	str = str & "传真："+ rs("fax") + "<br>"
	str = str & "手机："+ rs("cellphone") + "<br>"
	str = str & "电子邮箱："+ rs("email") + "<br>"
	str = str & "备注："+ rs("memo") + "<br>" + "<br>"
	rs.close
	pagetitle="查看问卷调查题目"
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
	<div class="c c2 fs18"><%=pagetitle%> - <%=term_name%></div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td><%=str%></td>
		</tr>
		<tr>
			<td>
 <%
 str=""
sql="select * from v_research_result_detail where isdisp=true and answer_id="&answer_id&" order by sno"
rs.open sql,conn,1,1
if not rs.eof Then
'response.write "会员名称："&rs("c_name")&"<br>填写人："&rs("answer_person")&"<br><br>"
for i=1 to rs.recordcount
	if rs("flag")<>true then
		str_chk="<input disabled type='radio' style='border:0 0 0 0' name="&rs("id")
	else
        str_chk="<input disabled type='checkbox' style='border:0 0 0 0' name="&rs("id")
	end if
	sno1=65
	str_checked=""
	answer111=rs("answer")

	if answer111 <> "others" then
		str=str&rs("sno")&"、"&rs("subject")&"<br>"
		if len(rs("a")) > 0 and left(answer111, 12) <> "othersanswer" then
			if instr(answer111, "A")>0 then str_checked=" checked"
			str=str&str_chk&" value='A'"& str_checked &">"&chr(sno1)&"、"&rs("a")&"<br>"
			sno1=sno1+1
		end if
		str_checked=""
		if len(rs("b")) > 0 and left(answer111, 12) <> "othersanswer"  then
			if instr(answer111,"B")>0 then str_checked=" checked"
			str=str&str_chk&" value='B'"& str_checked &">"&chr(sno1)&"、"&rs("b")&"<br>"
			sno1=sno1+1
		end if
		str_checked=""
		if len(rs("c")) > 0  and left(answer111, 12) <> "othersanswer" then
			if instr(answer111,"C")>0 then str_checked=" checked"
			str=str&str_chk&" value='C'"& str_checked &">"&chr(sno1)&"、"&rs("c")&"<br>"
			sno1=sno1+1
		end if
		str_checked=""
		if len(rs("d")) > 0  and left(answer111, 12) <> "othersanswer" then
			if instr(answer111,"D")>0 then str_checked=" checked"
			str=str&str_chk&" value='D'"& str_checked &">"&chr(sno1)&"、"&rs("d")&"<br>"
			sno1=sno1+1
		end if
		str_checked=""
		if len(rs("e")) > 0  and left(answer111, 12) <> "othersanswer" then
			if instr(answer111,"E")>0 then str_checked=" checked"
			str=str&str_chk&" value='E'"& str_checked &">"&chr(sno1)&"、"&rs("e")&"<br>"
			sno1=sno1+1
		end if
		str_checked=""
		if len(rs("f")) > 0  and left(answer111, 12) <> "othersanswer"  then
			if instr(answer111,"F") then str_checked=" checked"
			str=str&str_chk&" value='F'"& str_checked &">"&chr(sno1)&"、"&rs("f")&"<br>"
			sno1=sno1+1
		end if
		str_checked=""
		if len(rs("others")) > 0 then
			if left(answer111, 12) = "othersanswer" then
				answer_text=right(answer111, len(answer111) -12)
				str_checked=" checked"
				
				'if answer_text = "others" then
				'	rs.movenext
				'	i=i+1
					str=str&str_chk&" value='others'"& str_checked &">"&chr(sno1)&"、"&rs("others")&"&nbsp;<u>"&answer_text&"</u><br>"
				'else
				'	str=str&str_chk&" value='others'"& str_checked &">"&chr(sno1)&"、"&rs("others")&"&nbsp;<u>"&answer_text&"</u><br>"
				'	rs.movenext
				'	i=i+1
				'end if
				'if rs.eof then exit for
			else
				str=str&str_chk&" value='others'"& str_checked &">"&chr(sno1)&"、"&rs("others")&"&nbsp;<br>"
			end if
			sno1=sno1+1
		end if
		
		str=str&"<br>"
	end if
	rs.movenext
	if rs.eof then exit for
next
rs.close
response.write str
end if%>

			</td>
		</tr>
		<tr>
			<td class="c">
				<input type='button' value='返回' name="return" id="btnreturn" /> 
			</td>
		</tr>
	</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 1 });


	$('#btnreturn').click( function(){
		history.back();
	});
})


</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->