<%strModuleName="数据同步"%>
<!--#include file="uc/userright.asp"-->
<!--#include file="../uc/conn.asp"-->
<%

'清空会员表
if request("action") = "emptymember" Then
	sql = "delete from member"
	conn.execute(sql)
%>
<script language="JavaScript">
	alert("清空会员表成功！");
	window.location.href="datasyn.asp"
</script>
<%End If

'数据同步
if request("action") = "datasyn" then
	'on error resume next
	set rs_xh=server.createobject("adodb.recordset")
	connstr_xh="DBQ="+server.mappath("zhaefi.mdb")+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};"
	set conn_xh=server.createobject("ADODB.CONNECTION")
	conn_xh.open connstr_xh

	'从会员库读取数据
	sql_xh="select * from member"
	rs_xh.open sql_xh, conn_xh, 1, 1
	for i=1 to rs_xh.recordcount
		id=rs_xh("id")
		 c_name=rs_xh("c_name")
		 address=rs_xh("address")
		 zip_code=rs_xh("zip_code")
		 tel1=rs_xh("tel1")
		 tel2=rs_xh("tel2")
		 fax=rs_xh("fax")
		 spokesman=rs_xh("spokesman")
		 manager=rs_xh("manager")
		 industry=rs_xh("industry")
		 product=rs_xh("product")
		 currency1=rs_xh("currency1")
		 amount=rs_xh("amount")
		 capital=rs_xh("capital")
		 sort=rs_xh("sort")
		 c_country=rs_xh("c_country")
		 reg_date=rs_xh("reg_date")
		 email=rs_xh("email")
		 url=rs_xh("url")
		 director_flag=rs_xh("director_flag")
		 
		 '从会员库中的数据同网站会员表一一比对
		sql="select * from member where id="&id
		rs.open sql,conn,1,1
		if rs.eof Then
			'如果网站会员表中没有该数据，则插入一条记录
			sql_new="insert into member(id, c_name, address, zip_code, tel1, tel2, fax, spokesman, manager, industry, product, currency1, amount, capital, sort, c_country, email, url, director_flag, login_name, login_pwd"
			if len(reg_date) > 0 then
				sql_new=sql_new &", reg_date"
			end if
			sql_new=sql_new&") values("&id&", '"&c_name&"', '"&address&"', '"&zip_code&"', '"&tel1&"', '"&tel2&"', '"&fax&"', '"&spokesman&"', '"&manager&"', '"&industry&"', '"&product&"', '"&currency1&"', "&amount&", "&capital&", '"&sort&"', '"&c_country&"', '"&email&"', '"&url&"', "&director_flag & ", '" & id & "', '123456'"
			if len(reg_date) > 0 then
				sql_new=sql_new & ", #"&reg_date&"#"
			end if
			sql_new=sql_new &")"
		else
			'如果网站会员表已经存在数据，则更新该数据
			sql_new="update member set c_name='"&c_name&"', address='"&address&"', zip_code='"&zip_code&"', tel1='"&tel1&"', tel2='"&tel2&"', fax='"&fax&"', spokesman='"&spokesman&"', manager='"&manager&"', industry='"&industry&"', product='"&product&"', currency1='"&currency1&"', amount="&amount&", capital="&capital&", sort='"&sort&"', c_country='"&c_country&"', email='"&email&"', url='"&url&"', director_flag="&director_flag
			if len(reg_date) > 0 then
				sql_new = sql_new & ", reg_date=#"&reg_date&"#"
			end if
			sql_new = sql_new & " where id="&id
		end if
		rs.close
		rs_xh.movenext
		conn.execute(sql_new)
	next

	'set err1=conn.errors
	'response.write err1(0).description

	set rs_xh=nothing
	'conn.close
	conn_xh.close
	'set conn=nothing
	set conn_xh=Nothing
%>
<script language="JavaScript">
	alert("同步成功！");
	window.location.href="datasyn.asp"
</script>
<%end if%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>珠海外商投资企业协会</title>	
<!--#include file="uc/static.asp" -->
</head>
<body> 
<form method="post" name="form1" id="form1">
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--主界面-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 fs18" style="margin-top:200px;">
		以下操作不可恢复，安全起见，请先备份数据。同步数据前将会员系统导出的数据库zhaefi.mdb上传到网站后台目录。<br/><br/>
		<input type="button" name="emptymember" value="清空会员表" onclick="checkemptymember()" style="margin-right:200px; font-size:30px;height:65px;padding:15px;"/>
		<input type="button" name="datasyn" value="同步数据" onclick="checkdatasyn()" style="font-size:30px;height:65px;padding:15px;"/>
	</div>

	<script>
	function checkemptymember()
	{
		if (window.confirm("该操作不可恢复，确定要清空会员表吗？")){
			window.location.href="datasyn.asp?action=emptymember";
		}
	}
	
	function checkdatasyn()
	{
		if (window.confirm("该操作不可恢复，确定要同步吗？")){
			window.location.href="datasyn.asp?action=datasyn";
		}
	}
</script>
</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 2 });
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->