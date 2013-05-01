<!--#include file="uc/conn.asp"-->
<%
If len(session("Username")) > 0 Then 
Else 
%>
	<script>
		alert("会员登录后可查看");
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
<%
 id=request("id")
 sql="select * from member where id = "&id
 rs.open sql,conn,1,1
 %>
              <TABLE cellSpacing=1 cellPadding=2 width="900" align=center border=0 bgcolor="#C4C4C4">
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">编&nbsp;&nbsp;&nbsp;&nbsp;号：</TD>
                  <TD noWrap height=25 colspan="3" bgcolor="#FFFFFF"><%=rs("login_name")%></TD>
                </TR>
                <TBODY> 
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">企业名称：</TD>
                  <TD noWrap height=25 width="274" bgcolor="#FFFFFF"><%=rs("c_name")%> 
                    <%
				  director_flag=rs("director_flag")
				  if director_flag=true then
				  	director_flag1="<font color=red>【理事企业】</font>"
				end if
				response.write director_flag1
				  %>
                  </TD>
                  <TD noWrap height=25 width="75" bgcolor="#E6E6E6">所属行业：</TD>
                  <TD noWrap height=25 width="132" bgcolor="#FFFFFF"><%=rs("industry")%> </TD>
                </TR>
				<%if session("username") <>"" then%>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">总 经 理：</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF"><%=rs("manager")%>&nbsp;</TD>
                  <TD noWrap align=middle width=75 
                                height=25 bgcolor="#E6E6E6">法定代表人：</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("spokesman")%>&nbsp;
                  </TD>
                </TR>
				<%end if%>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">电　　话：</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF"><%=rs("tel1")%>&nbsp;<%=rs("tel2")%></TD>
                  <TD noWrap align=middle width=75 
                                height=25 bgcolor="#E6E6E6">传　　真：</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("fax")%></TD>
                </TR>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">电子邮件：</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF"><a href="mailto:<%=rs("email")%>"><%=rs("email")%></a></TD>
                  <TD noWrap align=middle width=75 height=25 bgcolor="#E6E6E6">邮政编码：</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("zip_code")%></TD>
                </TR>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">详细地址：</TD>
                  <TD noWrap colspan="3" height=25 bgcolor="#FFFFFF"><%=rs("address")%></TD>
                </TR>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">企业网址：</TD>
<%url=rs("url")
if left(url, 7) <> "http://" then
	url = "http://" & url
end if
%>
                  <TD noWrap colspan="3" height=25 bgcolor="#FFFFFF"><a href="<%=url%>" target=_blank><%=url%></a></TD>
                </TR>
                <TR> 
                  <TD noWrap width=65 height=23 bgcolor="#E6E6E6">投资国别：</TD>
                  <TD noWrap width=274 height=23 bgcolor="#FFFFFF" <%if session("username") ="" then response.write "colspan=3"%>><%=rs("c_country")%></TD>
				  <%if session("username") <>"" then%>
                  <TD noWrap align=middle width=75 height=23 bgcolor="#E6E6E6">投资币种：</TD>
                  <TD width=132 height=23 bgcolor="#FFFFFF"><%=rs("currency1")%>&nbsp;</TD><%end if%>
                </TR>
				<%if session("username") <>"" then%>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">投资总额：</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF"><%=rs("amount")&"（万元）"%>&nbsp;</TD>
                  <TD noWrap align=middle width=75 height=25 bgcolor="#E6E6E6">注册资本：</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("capital")&"（万元）"%>&nbsp;</TD>
                </TR>
				<%end if%>
                <TR> 
                  <TD noWrap width=65 height=25 bgcolor="#E6E6E6">企业类型：</TD>
                  <TD noWrap width=274 height=25 bgcolor="#FFFFFF" <%if session("username") ="" then response.write "colspan=3"%>><%=rs("sort")%></TD>
				   <%if session("username") <>"" then%>
                  <TD noWrap align=middle width=75 height=25 bgcolor="#E6E6E6">入会日期：</TD>
                  <TD width=132 height=25 bgcolor="#FFFFFF"><%=rs("reg_date")%> &nbsp;
                  </TD>
				  <%end if%>
                </TR>
                <TBODY> 
                <TR> 
                  <TD width=65 height=25 bgcolor="#E6E6E6">经营范围和产品：</TD>
                  <TD colSpan=3 
                                height=25 valign="top" bgcolor="#FFFFFF"><%=changechr(rs("product"))%></TD>
                </TR>
                <TR> 
                  <TD width=65 height=25 bgcolor="#E6E6E6">企业简介：</TD>
                  <TD colSpan=3 height=25 valign="top" bgcolor="#FFFFFF"><%=rs("c_intro")%></TD>
                </TR>
<%rs.close()%>
				<TR> 
                  <TD colSpan=4 height=25 valign="top" bgcolor="#FFFFFF"><font color="red"><br><br><b>【注】</b></font><b> 以上资料如有错漏，请会员企业尽快与协会秘书处联系更正。</b>
	</TD></TR>
</TBODY></TABLE>
</div>
<!--中部结束-->

<!--底部-->
<!--#include file="uc/bottom.asp" -->
</form>
</body></html>
<!--#include file="uc/connfree.asp"-->