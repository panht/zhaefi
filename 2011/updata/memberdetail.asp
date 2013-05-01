<!--#include file="../uc/conn.asp"-->
<%
strModuleName="会员管理"
%>
<!--#include file="uc/userright.asp"-->
<%
id=request("id")
CurrentPage = request("Page")
keyword=request("keyword")
action=request("action")

'保存操作
If request.Form("save") = "保存" Then
	login_name=request("login_name")
	login_pwd=request("login_pwd")
	c_name=request("c_name")
	spokesman=request("spokesman")
	manager=request("manager")
	industry=request("industry")
	tel1=request("tel1")
	tel2=request("tel2")
	fax=request("fax")
	email=request("email")
	zip_code=request("zip_code")
	address=request("address")
	URL=request("URL")
	currency1=request("currency1")
	amount=request("amount")
	if isnull(amount) then amount=""
	if len(amount)=0 then amount=0
	capital=request("capital")
	if isnull(capital) then capital=""
	if len(capital)=0 then capital=0
	sort=request("sort")
	reg_date=request("reg_date")
	if isnull(reg_date) then reg_date=""
	if len(reg_date)=0 then
		reg_date=cdate("1900-1-1")
	else
		reg_date=cdate(reg_date)
	end if
	 
	director_flag=request("director_flag")
	if director_flag=1 then
		director_flag=true
	else
		director_flag=false
	end if
	c_country=request("c_country")
	c_intro=request("c_intro")
	product=request("product")
	product=replace(replace(product, chr(39), "&#39;"), chr(34), "&quot;")

	if action="new" Then
		sql="insert into member(login_name, login_pwd, c_name, spokesman, manager, industry, tel1, tel2, fax, email, zip_code, address,URL,currency1 , amount, capital, sort, reg_date, director_flag, product, c_country, c_intro) values('"&login_name&"', '"&login_pwd&"', '"&c_name&"', '"&spokesman&"', '"&manager&"', '"&industry&"', '"&tel1&"', '"&tel2&"', '"&fax&"', '"&email&"', '"&zip_code&"', '"&address&"', '"&URL&"', '"&currency1&"', "&amount&", "&capital&", '"&sort&"', #"&reg_date&"#, "&director_flag&", '"&product&"', '"&c_country&"', '"&c_intro&"')"

		conn.execute(sql)
		'获取新插入数据的id，前面补0足4位，设为login_name
		sql="select top 1 login_name, id from member order by id desc"
		rs.open sql,conn,1,3
		if not rs.eof then
			login_name = rs("login_name")
			if isnull(login_name) or len(login_name) = 0  then
				rs("login_name") = string(4 - len(maxid), "0") & rs("id")
				rs.update
			end if
		end If
		rs.close
	elseif action="edit" then
		sql="update member set login_name='"&login_name&"', login_pwd='"&login_pwd&"', c_name='"&c_name&"', spokesman='"&spokesman&"', manager= '"&manager&"', industry='"&industry&"', tel1='"&tel1&"', tel2='"&tel2&"', fax='"&fax&"', email='"&email&"', zip_code='"&zip_code&"', address='"&address&"',URL='"&URL&"',currency1='"&currency1&"', amount="&amount&", capital="&capital&", sort= '"&sort&"', reg_date=#"&reg_date&"#, director_flag="&director_flag&", product='"&product&"', c_country='"&c_country&"', c_intro='"&c_intro&"' where id="&id

		conn.execute(sql)
	end If
	response.write sql
	conn.close
	response.redirect "memberlist.asp?page="&CurrentPage&"&keyword="&keyword
End If 



if action="new" then
	pagetitle="添加会员"
elseif action="edit" then
	sql="select * from member where id=" & id
	rs.open sql,conn,1,1
	login_name=rs("login_name")
	login_pwd=rs("login_pwd")
	c_name=rs("c_name")
	spokesman=rs("spokesman")
	manager=rs("manager")
	industry=rs("industry")
	tel1=rs("tel1")
	tel2=rs("tel2")
	fax=rs("fax")
	email=rs("email")
	zip_code=rs("zip_code")
	address=rs("address")
	URL=rs("URL")
	currency1=rs("currency1")
	amount=rs("amount")
	capital=rs("capital")
	sort=rs("sort")
	reg_date=rs("reg_date")	 
	director_flag=rs("director_flag")
	c_country=rs("c_country")
	c_intro=rs("c_intro")
	product=rs("product")
	rs.close
	pagetitle="编辑会员"
elseif action="del" Then
	sql="delete from member where id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "memberlist.asp?page="&CurrentPage&"&keyword="&keyword
elseif action="flagcomment" Then
	sql="update member set comment_flag = not comment_flag where id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "memberlist.asp?page="&CurrentPage&"&keyword="&keyword
end if
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>珠海外商投资企业协会</title>	
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
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--表格-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 fs18"><%=strModuleName%></div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>登录账号</td>
			<td><input type="text" name="login_name" size="20" maxlength="20" class="input req-string" value="<%=login_name%>" /></td>
			<td>登录密码</td>
			<td><input type="text" name="login_pwd" size="20" maxlength="20" class="input req-string" value="<%=login_pwd%>" /></td>
		</tr>
		<tr>
			<td>企业名称</td>
			<td><input type="text" name="c_name" size="40" maxlength="40" class="input req-string" value="<%=c_name%>" /></td>
			<td>法定代表人</td>
			<td><input type="text" name="spokesman" size="20" maxlength="20" value="<%=spokesman%>" /></td>
		</tr>
		<tr>
			<td>总 经 理</td>
			<td><input type="text" name="manager" size="20" maxlength="20" value="<%=manager%>" /></td>
			<td>行业</td>
			<td><input type="text" name="industry" size="20" maxlength="20" value="<%=industry%>" /></td>
		</tr>
		<tr>
			<td>电　　话</td>
			<td><input type="text" name="tel1" size="15" maxlength="15" value="<%=tel1%>" /><input type="text" name="tel2" size="15" maxlength="15" value="<%=tel2%>" /></td>
			<td>传　　真</td>
			<td><input type="text" name="fax" size="20" maxlength="20" value="<%=fax%>" /></td>
		</tr>
		<tr>
			<td>电子邮件</td>
			<td><input type="text" name="email" size="20" maxlength="20" value="<%=email%>" /></td>
			<td>邮政编码</td>
			<td><input type="text" name="zip_code" size="20" maxlength="20" value="<%=zip_code%>" /></td>
		</tr>
		<tr>
			<td>详细地址</td>
			<td colspan="3"><input type="text" name="address" size="70" maxlength="70" value="<%=address%>" /></td>
		</tr>
		<tr>
			<td>企业网址</td>
			<td colspan="3"><input type="text" name="url" size="70" maxlength="70" value="<%=url%>" /></td>
		</tr>
		<tr>
			<td>投资国别</td>
			<td><input type="text" name="c_country" size="20" maxlength="20" value="<%=c_country%>" /></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>投资币种</td>
			<td><input type="text" name="currency1" size="20" maxlength="20" value="<%=currency1%>" /></td>
			<td>投资总额</td>
			<td><input type="text" name="amount" size="20" maxlength="20" value="<%=amount%>" class="input req-numeric" />（万元）</td>
		</tr>
		<tr>
			<td>注册资本</td>
			<td><input type="text" name="capital" size="20" maxlength="20" value="<%=capital%>" class="input req-numeric" />（万元）</td>
			<td>企业类型</td>
			<td><input type="text" name="sort" size="20" maxlength="20" value="<%=sort%>" /></td>
		</tr>
		<tr>
			<td>入会日期</td>
			<td><input type="text" name="reg_date" size="20" maxlength="20" value="<%=reg_date%>"/>(yyyy-mm-dd)</td>
			<td>理事企业</td>
			<td><input type="checkbox" name="director_flag" value="1" <%if director_flag=true Then response.write "checked"%>></td>
		</tr>
		<tr>
			<td>企业简介</td>
			<td colspan="3"><input type="text" name="c_intro" size="70" maxlength="70" value="<%=c_intro%>" /></td>
		</tr>
		<tr>
			<td>经营范围和产品</td>
			<td colspan="3">
				<textarea id="inputCLE" name="product"><%=product%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="4" class="c">
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" /> 
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

	//表单验证及提交
	$('#btnsave').formValidator({
		scope : '#form1',
		errorDiv : '#errorDiv'
	});

	$('#btnreturn').click( function(){
		history.back();
	});

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