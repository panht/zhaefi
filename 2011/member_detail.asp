<!--#include file="uc/conn.asp"-->
<%
If len(session("Username")) > 0 Then 
Else 
%>
	<script>
		alert("��Ա��¼��ɲ鿴");
		history.back();
	</script>
<%
	response.end
End If
%>
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
<form method="post" name="form1" id="form1" onSubmit="return chk()">
<!--ͷ��-->
<!--#include file="uc/top.asp" -->


<!--�в���ʼ-->
<div class="ma w980">
<%
 id=request("id")
 sql="select * from member where id = "&id
 rs.open sql,conn,1,1
 %>
              <TABLE cellSpacing=1 cellPadding=2 width="900" align=center border=0 bgcolor="#C4C4C4">
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</TD>
                  <TD noWrap height=25 colspan="3" bgcolor="#FFFFFF"><%=rs("login_name")%></TD>
                </TR>
                <TBODY> 
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">��ҵ���ƣ�</TD>
                  <TD noWrap height=25 width="274" bgcolor="#FFFFFF"><%=rs("c_name")%> 
                    <%
				  director_flag=rs("director_flag")
				  if director_flag=true then
				  	director_flag1="<font color=red>��������ҵ��</font>"
				end if
				response.write director_flag1
				  %>
                  </TD>
                  <TD noWrap height=25 width="75" bgcolor="#E6E6E6">������ҵ��</TD>
                  <TD noWrap height=25 width="132" bgcolor="#FFFFFF"><%=rs("industry")%> </TD>
                </TR>
				<%if session("username") <>"" then%>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">�� �� ��</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF"><%=rs("manager")%>&nbsp;</TD>
                  <TD noWrap align=middle width=75 
                                height=25 bgcolor="#E6E6E6">���������ˣ�</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("spokesman")%>&nbsp;
                  </TD>
                </TR>
				<%end if%>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">�硡������</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF"><%=rs("tel1")%>&nbsp;<%=rs("tel2")%></TD>
                  <TD noWrap align=middle width=75 
                                height=25 bgcolor="#E6E6E6">�������棺</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("fax")%></TD>
                </TR>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">�����ʼ���</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF"><a href="mailto:<%=rs("email")%>"><%=rs("email")%></a></TD>
                  <TD noWrap align=middle width=75 height=25 bgcolor="#E6E6E6">�������룺</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("zip_code")%></TD>
                </TR>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">��ϸ��ַ��</TD>
                  <TD noWrap colspan="3" height=25 bgcolor="#FFFFFF"><%=rs("address")%></TD>
                </TR>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">��ҵ��ַ��</TD>
<%url=rs("url")
if left(url, 7) <> "http://" then
	url = "http://" & url
end if
%>
                  <TD noWrap colspan="3" height=25 bgcolor="#FFFFFF"><a href="<%=url%>" target=_blank><%=url%></a></TD>
                </TR>
                <TR> 
                  <TD noWrap width=65 height=23 bgcolor="#E6E6E6">Ͷ�ʹ���</TD>
                  <TD noWrap width=274 height=23 bgcolor="#FFFFFF" <%if session("username") ="" then response.write "colspan=3"%>><%=rs("c_country")%></TD>
				  <%if session("username") <>"" then%>
                  <TD noWrap align=middle width=75 height=23 bgcolor="#E6E6E6">Ͷ�ʱ��֣�</TD>
                  <TD width=132 height=23 bgcolor="#FFFFFF"><%=rs("currency1")%>&nbsp;</TD><%end if%>
                </TR>
				<%if session("username") <>"" then%>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">Ͷ���ܶ</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF"><%=rs("amount")&"����Ԫ��"%>&nbsp;</TD>
                  <TD noWrap align=middle width=75 height=25 bgcolor="#E6E6E6">ע���ʱ���</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("capital")&"����Ԫ��"%>&nbsp;</TD>
                </TR>
				<%end if%>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">��ҵ���ͣ�</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF" <%if session("username") ="" then response.write "colspan=3"%>><%=rs("sort")%></TD>
				   <%if session("username") <>"" then%>
                  <TD noWrap align=middle width=75 height=25 bgcolor="#E6E6E6">������ڣ�</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("reg_date")%> &nbsp;
                  </TD>
				  <%end if%>
                </TR>
                <TBODY> 
                <TR> 
                  <TD width=65 height=25 bgcolor="#E6E6E6">��Ӫ��Χ�Ͳ�Ʒ��</TD>
                  <TD colSpan=3 
                                height=25 valign="top" bgcolor="#FFFFFF"><%=changechr(rs("product"))%></TD>
                </TR>
                <TR> 
                  <TD width=65 height=25 bgcolor="#E6E6E6">��ҵ��飺</TD>
                  <TD colSpan=3 height=25 valign="top" bgcolor="#FFFFFF"><%=rs("c_intro")%></TD>
                </TR>
<%rs.close()%>
				<TR> 
                  <TD colSpan=4 height=25 valign="top" bgcolor="#FFFFFF"><font color="red"><br><br><b>��ע��</b></font><b> �����������д�©�����Ա��ҵ������Э�����鴦��ϵ������</b>
	</TD></TR>
</TBODY></TABLE>
</div>
<!--�в�����-->

<!--�ײ�-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->