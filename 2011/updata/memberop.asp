<% Session.CodePage=936 
Response.Charset="GBK" %> 
<!--#include file="../uc/conn.asp"-->
<%
strModuleName="会员管理"
%>
<!--#include file="uc/userright.asp"-->
<%
action=request("action")

if action="companyName" Then
	sql="select top 10 id, c_name from member where c_name like '%" & request("name") & "%'"
	rs.open sql, conn, 1, 1

	result = ""
	if not rs.eof then
		result = result & "["
		do while not rs.eof
			result = result & "{""id"":" & rs("id") & ", ""name"":""" & rs("c_name") & """}"
			rs.movenext
			if not rs.eof then
				result = result & ", "
			end if
		loop
		result = result & "]"
	end if
	rs.close
	
	response.write result
	response.end
end if
%>