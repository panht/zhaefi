<!--#include file="../uc/conn.asp"-->
<%
strModuleName="ѧϰ��"
%>
<!--#include file="uc/userright.asp"-->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>�麣����Ͷ����ҵЭ��</title>
<!--#include file="uc/static.asp" -->
</head>
<body> 
<form method="post" name="form1">
<!--�˵�-->
<!--#include file="uc/menu.asp" -->

<!--���-->
<div class="fl mt10 ml10 wmain">
	<div class="c c2 fs18"><%=strModuleName%></div>
<%
sqltext="select * from trainingcard where id=" & request("id")
rs.open sqltext,conn,1,1
if not rs.eof then
%>
<table cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td>��ҵ���ƣ�</td><td><%=rs("companyName")%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;ѧϰ���ţ�</td><td><%=rs("cardno")%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;ѧϰ�����</td><td>
				<%
				cardtype = rs("cardtype")
				if cardtype=1 then
					response.write "��Ա��"
				elseif cardtype=2 then
					response.write "�ǻ�Ա��"
				end if
				%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;��</td><td><%=rs("balance")%></td>
	</tr>
</table>
<%
end if
rs.close
%>
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th width="50px"><div>���</div></th>
			<th width="100px"><div>���</div></th>
			<th width="120px"><div>ʱ��</div></th>
			<th><div>��ע</div></th>
		</tr>
	</thead>
<%
sqltext="select * from trainingcardrecord where trainingcardid=" & request("id") & " order by RecordTime desc" 
rs.open sqltext,conn,1,1
%>
<!--#include file="../uc/page.asp"-->
<%
if not rs.eof then
	rs.move (page - 1) * rowcount
	i = 0
	do while not rs.eof and rowcount > 0
		i= i+ 1
		id = rs("id")
%>
	<tbody>
		<tr <%If i Mod 2 = 0 Then response.write "class=""odd"""%>>
			<td style="text-align:center">
				<%if (rs("RecordType") = 1) then
					response.write "<span style='color:darkgreen'>��ֵ</span>" 
				elseif (rs("RecordType") = 2) then
					response.write "<span style='color:red'>����</span>" 
				end if %>
			</td>
			<td style="text-align:right"><%=rs("Amount")%></td>
			<td style="text-align:center"><%if not isnull(rs("RecordTime")) Then response.write FormatDateTime(rs("RecordTime"), vbShortDate)%></td>
			<td><%=rs("Remark")%></td>
		</tr>
<%
		IF rs.eof THEN exit do
		rowcount = rowcount - 1
		rs.movenext
	loop
end if
rs.close
%>
		<tr> 
		  <td colspan="4"> 
			<%call pageSplit("keyword")%>
		  </td>
		</tr>
		<tr> 
		  <td colspan="4" style="text-align:center"> 
			<input type='button' value='����' name="return" id="btnreturn" /> 
		  </td>
		</tr>
	</tbody>
</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 1 });
	
	$('#btnreturn').click( function(){
		history.back();
	});
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->