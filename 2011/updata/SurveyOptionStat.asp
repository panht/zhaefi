<!--#include file="../uc/conn.asp"-->
<%
strModuleName="问卷调查"
id=request("id")

sqltext="select * from research where id="&id
rs.open sqltext,conn,1,1
subject=rs("subject")
a=rs("a")
b=rs("b")
c=rs("c")
d=rs("d")
e=rs("e")
f=rs("f")
others=rs("others")
'a_count=rs("a_count")
'b_count=rs("b_count")
'c_count=rs("c_count")
'd_count=rs("d_count")
'e_count=rs("e_count")
'f_count=rs("f_count")
'others_count=rs("others_count")
'all_count=a_count + b_count + c_count + d_count + e_count + f_count + others_count
rs.close

sql="select count(id) from research_result where research_id=" & id & " and (answer='A' or answer like 'A,%')"
rs.open sql,conn, 1, 1
a_count=rs(0)
rs.close

sql="select count(id) from research_result where research_id=" & id & " and (answer='B' or answer like '%B,%' or answer like '%, B%')"
rs.open sql,conn, 1, 1
b_count=rs(0)
'response.write sql & b_count
rs.close

sql="select count(id) from research_result where research_id=" & id & " and (answer='C' or answer like '%C,%' or answer like '%, C%')"
rs.open sql,conn, 1, 1
c_count=rs(0)
rs.close

sql="select count(id) from research_result where research_id=" & id & " and (answer='D' or answer like '%D,%' or answer like '%, D%')"
rs.open sql,conn, 1, 1
d_count=rs(0)
rs.close

sql="select count(id) from research_result where research_id=" & id & " and (answer='E' or answer like '%E,%' or answer like '%, E%')"
rs.open sql,conn, 1, 1
e_count=rs(0)
rs.close

sql="select count(id) from research_result where research_id=" & id & " and (answer='F' or answer like '%, F')"
rs.open sql,conn, 1, 1
f_count=rs(0)
rs.close

sql="select count(id) from research_result where research_id=" & id & " and answer='others'"
rs.open sql,conn, 1, 1
others_count=rs(0)
rs.close

all_count=a_count + b_count + c_count + d_count + e_count + f_count + others_count

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
	<div class="c c2 fs18">查看答题统计 - <%=subject%><br>总计：<%=all_count%>票</div>
	<input type="button" name="ButtonReturn" value="返回" onClick="history.back();" />
	<table cellspacing="0" cellpadding="0" border="0" id="example" class="tlist">
	<thead>
		<tr>
			<th><div>&nbsp;</div></th> 
			<th><div>选项</div></th>
			<th colspan="2"><div>比例</div></th>
			<th><div>票数</div></th>
		</tr>
	</thead>
	<tbody>
<%
if len(trim(a)) > 0 then
	if all_count > 0 then
		a_per_count = a_count/all_count
	else
		a_per_count = 0
	end If
%>
		<tr>
			<td class="c">A</td>
			<td class="c"><%=a%></td>
			<td><%=FormatPercent(a_per_count)%></td>
			<td><img src="../static/images/stat.gif" width="<%=formatnumber(a_per_count)*100%>" height="18" /></td>
			<td class="c"><%=a_count%></td>
		</tr>
<%end if%>
<%
if len(trim(b)) > 0 then
	if all_count > 0 then
		b_per_count = b_count/all_count
	else
		b_per_count = 0
	end If
%>
		<tr class="odd">
			<td class="c">B</td>
			<td class="c"><%=b%></td>
			<td><%=FormatPercent(b_per_count)%></td>
			<td><img src="../static/images/stat.gif" width="<%=formatnumber(b_per_count)*100%>" height="18" /></td>
			<td class="c"><%=b_count%></td>
		</tr>
<%end if%>
<%
if len(trim(c)) > 0 then
	if all_count > 0 then
		c_per_count = c_count/all_count
	else
		c_per_count = 0
	end If
%>
		<tr>
			<td class="c">C</td>
			<td class="c"><%=c%></td>
			<td><%=FormatPercent(c_per_count)%></td>
			<td><img src="../static/images/stat.gif" width="<%=formatnumber(c_per_count)*100%>" height="18" /></td>
			<td class="c"><%=c_count%></td>
		</tr>
<%end if%>
<%
if len(trim(d)) > 0 then
	if all_count > 0 then
		d_per_count = d_count/all_count
	else
		d_per_count = 0
	end If
%>
		<tr class="odd">
			<td class="c">D</td>
			<td class="c"><%=d%></td>
			<td><%=FormatPercent(d_per_count)%></td>
			<td><img src="../static/images/stat.gif" width="<%=formatnumber(d_per_count)*100%>" height="18" /></td>
			<td class="c"><%=d_count%></td>
		</tr>
<%end if%>
<%
if len(trim(e)) > 0 then
	if all_count > 0 then
		e_per_count = e_count/all_count
	else
		e_per_count = 0
	end If
%>
		<tr>
			<td class="c">E</td>
			<td class="c"><%=e%></td>
			<td><%=FormatPercent(e_per_count)%></td>
			<td><img src="../static/images/stat.gif" width="<%=formatnumber(e_per_count)*100%>" height="18" /></td>
			<td class="c"><%=e_count%></td>
		</tr>
<%end if%>
<%
if len(trim(f)) > 0 then
	if all_count > 0 then
		f_per_count = f_count/all_count
	else
		f_per_count = 0
	end If
%>
		<tr class="odd">
			<td class="c">F</td>
			<td class="c"><%=f%></td>
			<td><%=FormatPercent(f_per_count)%></td>
			<td><img src="../static/images/stat.gif" width="<%=formatnumber(f_per_count)*100%>" height="18" /></td>
			<td class="c"><%=f_count%></td>
		</tr>
<%end if%>
<%
if len(trim(others)) > 0 then
	if all_count > 0 then
		others_per_count = others_count/all_count
	else
		others_per_count = 0
	end If
%>
		<tr>
			<td class="c">Others</td>
			<td class="c"><%=others%></td>
			<td><%=FormatPercent(others_per_count)%></td>
			<td><img src="../static/images/stat.gif" width="<%=formatnumber(others_per_count)*100%>" height="18" /></td>
			<td class="c"><%=others_count%></td>
		</tr>
<%end if%>
	</tbody>
</table>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 1 });
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->