<!--#include file="uc/conn.asp"-->
<%

'on error resume next
If request.form("save")="提交" then
	login_name=session("username")
	term_id=request("term_id")
	company=request("company")
	answer_person=request("answer_person")
	title=request("a_title")
	tel=request("a_tel")
	fax=request("fax")
	cellphone=request("cellphone")
	email=request("email")
	memo=request("memo")

	'插入答案主表
	sql="insert into research_result_main(term_id, [company], [name], [title], tel ,fax, cellphone, [email], [memo]) values(" & term_id &", '" & company & "', '" & answer_person & "', '" & title & "', '" & tel & "', '" & fax & "', '" & cellphone & "', '" & email & "', '" & memo & "')"
	conn.execute(sql)

	sql = "select top 1 id from research_result_main order by id desc"
	rs.open sql, conn, 1, 1
	If Not rs.eof Then
		answer_id = rs("id")
	End If
	rs.close

	'插入答案项表及其它回答表
	For Each I in Request.Form
		If I <> "save" Then 
			others_flag=0
			answer=Request.Form.Item(I)
			'Response.Write I&Request.Form.Item(I)&"<br>"
			
			if I > "others" then
				others_flag=1 
				I = right(I, len(I) - len("others"))
			end if
			research_id=I
			answer_item=split(answer, ",")
			for j=0 to ubound(answer_item)
				sql=""
				SELECT CASE trim(ucase(answer_item(j)))
					CASE "A"
						sql="update research set A_count = A_count + 1 where id="&I
					CASE "B"
						sql="update research set B_count = B_count + 1 where id="&I
					CASE "C"
						sql="update research set C_count = C_count + 1 where id="&I
					CASE "D"
						sql="update research set D_count = D_count + 1 where id="&I
					CASE "E"
						sql="update research set E_count = E_count + 1 where id="&I
					CASE "F"
						sql="update research set F_count = F_count + 1 where id="&I
					CASE "OTHERS"
						sql="update research set others_count = others_count + 1 where id="&I
				END Select
				'if len(sql) > 0 then conn.execute(sql)
			next

			if len(answer) > 0 and I<>"answer_person" Then
				If IsNumeric(research_id) then
					if others_flag=1 then answer="othersanswer" & answer
					sql1="insert into research_result(login_name, research_id, answer, answer_person, term_id, answer_id"
					'if others_flag=1 then sql1=sql1 & ", others_flag"
					sql1=sql1&") values('"&login_name&"', "&research_id&", '"&answer&"', '"&answer_person&"', "& term_id & ", "& answer_id
					'if others_flag=1 then sql1=sql1 & ", 1"
					sql1=sql1&")"
					'response.write sql1 & "<br>"
					'response.end
					conn.execute(sql1)
				End if
			end If
		End if
	Next
	'Response.End

	'set err1=conn.errors
	'response.write err1(0).description
	conn.close
	%>
	<script>
		alert("问卷已提交成功，感谢您的答卷！");
		window.location.href="./"
	</script>
<%End If %>

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
<form method="post" name="form1" id="form1" onSubmit="return chk()">
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
        
<!--问卷调查开始-->
<%
set rs1=server.createobject("adodb.recordset")
sql="select * from research_term where isdisp=true"
rs.open sql,conn,1,1
%>
                    <table width="597" border="0" cellspacing="1" cellpadding="4">
                      <%if not rs.eof then%>
                        <tr> 
                          <td align="center" class="news1">
								<h1>
									<span><%=rs("term_name")%></span>
								</h1><input type="hidden" name="term_id" value="<%=rs("id")%>">
                          </td>
                        </tr>
                        <tr> 
                          <td class="news1"><%=Replace(Replace(Replace(replace(rs("foreword"),chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", Chr(39)), "&nbsp;", "")%></td>
                        </tr>
                        <tr> 
                          <td class="news1"><%=Replace(Replace(Replace(replace(rs("description"),chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", Chr(39)), "&nbsp;", "")%></td>
                        </tr>
                        <tr> 
                          <td class="news1"> 
                            <%
sql="select * from research where isdisp=true and term_id="&rs("id")&" order by sno"
rs1.open sql,conn,1,1
for i=1 to rs1.recordcount
	top_flag=0
	m_flag=rs1("flag")
	if m_flag<>true then
		str_chk="<input type='radio' style='border:0 0 0 0' name="&rs1("id")
	else
        str_chk="<input type='checkbox' style='border:0 0 0 0' name="&rs1("id")
	end if
	sno1=65
	str=str&rs1("sno")&"、"&rs1("subject")&"<br>"
	if len(rs1("a")) > 0 then
		str=str&str_chk
		if top_flag=0 and m_flag<>true then str=str&" checked"
		str=str&" value='A'>"&chr(sno1)&"、"&rs1("a")&"<br>"
		sno1=sno1+1
		top_flag=1
	end if
	if len(rs1("b")) > 0 then
		str=str&str_chk
		if top_flag=0 and m_flag<>true then str=str&" checked"
		str=str&" value='B'>"&chr(sno1)&"、"&rs1("b")&"<br>"
		sno1=sno1+1
		top_flag=1
	end if
	if len(rs1("c")) > 0 then
		str=str&str_chk
		if top_flag=0 and m_flag<>true then str=str&" checked"
		str=str&" value='C'>"&chr(sno1)&"、"&rs1("c")&"<br>"
		sno1=sno1+1
		top_flag=1
	end if
	if len(rs1("d")) > 0 then
		str=str&str_chk
		if top_flag=0 and m_flag<>true then str=str&" checked"
		str=str&" value='D'>"&chr(sno1)&"、"&rs1("d")&"<br>"
		sno1=sno1+1
		top_flag=1
	end if
	if len(rs1("e")) > 0 then
		str=str&str_chk
		if top_flag=0 and m_flag<>true then str=str&" checked"
		str=str&" value='E'>"&chr(sno1)&"、"&rs1("e")&"<br>"
		sno1=sno1+1
		top_flag=1
	end if
	if len(rs1("f")) > 0 then
		str=str&str_chk
		if top_flag=0 and m_flag<>true then str=str&" checked"
		str=str&" value='F'>"&chr(sno1)&"、"&rs1("f")&"<br>"
		sno1=sno1+1
		top_flag=1
	end if
	if len(rs1("others")) > 0 then
		str=str&str_chk
		if top_flag=0 and m_flag<>true then str=str&" checked"
		str=str&" value='others'>"&chr(sno1)&"、"&rs1("others")&"&nbsp;<input type='text' name='others"&rs1("id")&"' size='40' maxlength='255'>"&"<br>"
		sno1=sno1+1
	end if
	
	str=str&"<br>"
rs1.movenext
next
rs1.close
response.write str%>
                          </td>
                        </tr>
                        <tr>
                          <td class="news1">【填写人资料:】</td>
                        </tr>
						<tr>
                          <td class="news1">公司名称：<input type="text" name="company" size="50" maxlength="50"><FONT COLOR="#FF0000">（必填）</FONT></td>
                        </tr>
                        <tr>
                          <td class="news1">填写人：<input type="text" name="answer_person" size="30" maxlength="30"><FONT COLOR="#FF0000">（必填）</FONT></td>
                        </tr>
                        <tr>
                          <td class="news1">职务：<input type="text" name="a_title" size="30" maxlength="20"></td>
                        </tr>
                        <tr>
                          <td class="news1">电话：<input type="text" name="a_tel" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                          <td class="news1">传真：<input type="text" name="fax" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                          <td class="news1">手机：<input type="text" name="cellphone" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                          <td class="news1">电子邮箱：<input type="text" name="email" size="30" maxlength="100"></td>
                        </tr>
                        <tr>
                          <td class="news1">备注：<textarea name="memo" rows="5" cols="50"></textarea></td>
                        </tr>
<!--
                        <tr> 
                          <td class="news1">注：填写问卷前请先确认是否本站会员。</td>
                        </tr>
                        <tr> 
-->
                          <td align="center"> 
<script>
	function chk(){
		<%'if session("username")="" or isnull(session("username")) then%>
			//alert("您还不是本站会员，必须成为本站会员以后才能填写问卷！");
			//return
		<%'end if%>
		if (document.form1.company.value==""){
			alert("公司名称不能为空！")
			document.form1.company.focus();
			return false;
		}
		if (document.form1.answer_person.value==""){
			alert("填写人不能为空！")
			document.form1.answer_person.focus();
			return false;
		}
		//document.form1.submit();
		return true;
	}
</script>
                            <input type="submit" name="save" value="提交" style="height:25px">
                            <input type="reset" name="ok2" value="重填" style="height:25px">
                            <input type="button" name="ok3" value="返回" onClick="history.back()" style="height:25px">
                            &nbsp;</td>
                        </tr>
	<%else%>
                      <div align="center" class="news1">暂时还没有问卷调查！</div>
	<%end If
	rs.close
	%>
                    </table>
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