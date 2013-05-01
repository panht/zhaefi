<!--#include file="../uc/conn.asp"-->
<%
strModuleName="学习卡"
%>
<!--#include file="uc/userright.asp"-->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>珠海外商投资企业协会</title>
<!--#include file="uc/static.asp" -->
</head>
<body> 
<form method="post" name="form1">
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--表格-->
<div class="fl mt10 ml10 wmain">
	<div class="c c2 fs18"><%=strModuleName%></div>
<%
sqltext="select * from trainingcard where id=" & request("id")
rs.open sqltext,conn,1,1
if not rs.eof then
%>
<table cellspacing="0" cellpadding="0" border="0">
	<tr>
		<td>企业名称：</td><td><%=rs("companyName")%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;学习卡号：</td><td><%=rs("cardno")%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;学习卡类别：</td><td>
				<%
				cardtype = rs("cardtype")
				if cardtype=1 then
					response.write "会员卡"
				elseif cardtype=2 then
					response.write "非会员卡"
				end if
				%></td>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;余额：</td><td><%=rs("balance")%></td>
	</tr>
</table>
<%
end if
rs.close
%>
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th width="50px"><div>类别</div></th>
			<th width="100px"><div>金额</div></th>
			<th width="120px"><div>时间</div></th>
			<th><div>备注</div></th>
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
					response.write "<span style='color:darkgreen'>充值</span>" 
				elseif (rs("RecordType") = 2) then
					response.write "<span style='color:red'>消费</span>" 
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
			<input type='button' value='返回' name="return" id="btnreturn" /> 
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