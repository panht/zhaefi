<!--#include file="../uc/conn.asp"-->
<%
module=request("module")
If module = 93 Then
	strModuleName="资讯焦点"
	strTitle="资讯焦点"
ElseIf module = 87 Then
	strModuleName="协会动态+会员报道"
	strTitle="协会动态"
ElseIf module = 91 Then
	strModuleName="协会动态+会员报道"
	strTitle="会员报道"
ElseIf module = 92 Then
	strModuleName="会刊+专题+专栏"
	strTitle="会刊"
ElseIf module = 89 Then
	strModuleName="会刊+专题+专栏"
	strTitle="专题"
ElseIf module = 90 Then
	strModuleName="会刊+专题+专栏"
	strTitle="专栏"
ElseIf module = 83 Then
	strModuleName="政策法规"
	strTitle="政策法规"
ElseIf module = 86 Then
	strModuleName="重点"
	strTitle="重点"
ElseIf module = 85 Then
	strModuleName="网站信息"
	strTitle="网站信息"
End If
%>
<!--#include file="uc/userright.asp"-->
<%
id=request("id")
CurrentPage = request("Page")
keyword=request("keyword")
action=request("action")


'保存操作
If request.Form("save") = "保存" Then 
	'id=request("art_id")
	art_title=request("art_title")
	art_title_b=request("art_title_b")
	art_title_color=request("art_title_color")
	art_time=request("art_time")
	sort_2=request("mclass")
	sort_3=request("sclass")
	If sort_2 = "" Then sort_2 = 0
	If sort_3 = "" Then sort_3 = 0
	art_content=request("art_content")
	art_title=replace(replace(art_title, chr(39), "&#39;"), chr(34), "&quot;")
	art_content=replace(replace(art_content, chr(39), "&#39;"), chr(34), "&quot;")

	if action="new" Then
		if len(art_time) = 0 or isnull(art_time) then
			sql="insert into article(art_title, art_title_b, art_title_color, art_content, art_info_id, sort_2, sort_3) values('" & art_title & "', '" & art_title_b & "', '" & art_title_color & "', '" & art_content & "', "& module & ", "& sort_2 & ",  "& sort_3 & ")"
		else
			sql="insert into article(art_title, art_title_b, art_title_color, art_content, art_time, art_info_id, sort_2, sort_3) values('" & art_title & "', '" & art_title_b & "', '" & art_title_color & "', '" & art_content & "', #"&art_time&"#, "& module & ", "& sort_2 & ",  "& sort_3 & ")"
		end if
	elseif action="edit" then
		if len(art_time) = 0 or isnull(art_time) then
			sql="update article set art_title='" & art_title & "', art_title_b='" & art_title_b & "', art_title_color='" & art_title_color & "', art_content='" & art_content & "', sort_2=" & sort_2 & ", sort_3=" & sort_3 &", pub_time=now() where art_id=" & id
		else
			sql="update article set art_title='" & art_title & "',  art_title_b='" & art_title_b & "', art_title_color='" & art_title_color & "', art_content='" & art_content & "', art_time=#" & art_time & "#, sort_2=" & sort_2 & ", sort_3=" & sort_3 &", pub_time=now() where art_id=" & id
		end if
	end If
	response.write sql
	conn.execute(sql)
	conn.close
	response.redirect "articlelist.asp?page="&CurrentPage&"&keyword="&keyword&"&module="&module
End If 

if action="new" then
	art_id=id
	sort_2=0
	sort_3=0
	art_title=""
	art_time=""
	art_content=""
	pagetitle="发表文章"
elseif action="edit" then
	sql="select * from article where art_id=" & id
	rs.open sql,conn,1,1
	art_id=rs("art_id")
	sort_2=rs("sort_2")
	sort_3=rs("sort_3")
	art_title=rs("art_title")
	art_title_b=rs("art_title_b")
	art_title_color=rs("art_title_color")
	art_time=rs("art_time")
	'art_content=replace(rs("art_content"), Chr(13), "</br>")
	art_content=rs("art_content")
	rs.close
	pagetitle="编辑文章"
elseif action="del" Then
	sql="delete from article where art_id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "articlelist.asp?page="&CurrentPage&"&keyword="&keyword&"&module="&module
elseif action="flagnew" Then
	sql="update article set is_new = not is_new where art_id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "articlelist.asp?page="&CurrentPage&"&keyword="&keyword&"&module="&module
elseif action="flagmember" Then
	sql="update article set member_flag = not member_flag where art_id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "articlelist.asp?page="&CurrentPage&"&keyword="&keyword&"&module="&module
elseif action="flagcomment" Then
	sql="update article set flag = not flag where art_id=" & id
	conn.execute(sql)
	conn.close
	response.redirect "articlelist.asp?page="&CurrentPage&"&keyword="&keyword&"&module="&module
end If



'二、三级类别改为从moduletree表获取
'If module=83 Then
	set rs1=server.createobject("adodb.recordset")

	'sql="select m2.id as mid2, m2.modulename as mname2, m3.id as mid3, m3.modulename as mname3 from moduletree m2, moduletree m3 where m3.parentmodule = m2.id and m3.id="&sort_2
	'rs1.open sql,conn,1,1
	'if not rs1.eof then
	'	sort_2_name_this=rs1("mname2")
	'	sort_3_name_this=rs1("mname3")
	'end if
	'rs1.close

	'生成二级类别下拉框
	sql="select * from moduletree where parentmodule=" & module & " order by seqno"
	rs1.open sql,conn,1,1
	str_mclass="<select name='mclass' onchange='changesortselect(this.value)'><option value=''>请选择类别一...</option>"
	count_mclass=rs1.recordcount
	for i=1 to count_mclass
		if sort_2 = rs1("id") then
			str_selectedm=" selected"
		else
			str_selectedm=""
		end if
		str_mclass=str_mclass&"<option value='" & rs1("id") & "'" & str_selectedm & ">" & rs1("modulename") & "</option>"
		rs1.movenext
	next
	str_mclass=str_mclass&"</select>"
	rs1.close

	'生成三级类别下拉框
	sql="select * from moduletree where parentmodule=" & sort_2 & " order by seqno"
	rs1.open sql,conn,1,1
	for i=1 to rs1.recordcount
		if sort_3 = rs1("id") then
			str_selecteds=" selected"
		else
			str_selecteds=""
		end if
		str_sclass=str_sclass&"<option value='" & rs1("id") & "'" & str_selecteds & ">" & rs1("modulename") & "</option>"
		rs1.movenext
	next
	rs1.close
	set rs1=nothing
'End If 
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Expires" content="0">
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
<form method="post" name="form1" id="form1"> <!-- action="upload.asp" enctype="multipart/form-data">-->
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--表格-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 fs18">文章管理</div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>标题</td>
			<td>
				<input type="text" name="art_title" size="70" maxlength="100" class="input req-string" style="width:360px" value="<%=art_title%>" />
				<input type="checkbox" name="art_title_b" value="b" <%If art_title_b="b" Then response.write "checked"%> /><B>加粗</B> 				
				<input type="radio" name="art_title_color" value="" checked /><span class="">■</span>
				<input type="radio" name="art_title_color" value="ctitlered" <%If art_title_color="ctitlered" Then response.write "checked"%> /><span class="ctitlered"><FONT COLOR="#FF0000">■</FONT></span>
				<input type="radio" name="art_title_color" value="ctitlecoffee" <%If art_title_color="ctitlecoffee" Then response.write "checked"%>  /><span class="ctitlecoffee"><FONT COLOR="#990000">■</FONT></span>
				<input type="radio" name="art_title_color" value="ctitlegreem" <%If art_title_color="ctitlegreem" Then response.write "checked"%>  /><span class="ctitlegreem"><FONT COLOR="#0066FF">■</FONT></span>
			</td>
		</tr>
		<tr>
			<td>类别</td>
			<td>
				<%=str_mclass%>
				<select name="sclass" id="sclass">
					<%if sort_3 > 0 then
						response.write str_sclass
					ElseIf sort_2 > 0 Then %>
				  <option value="0">请先选择大类...</option>
					<%end if%>
				</select>
			</td>
		</tr>
		<tr>
			<td>发布时间</td>
			<td><input type="text" name="art_time" size="50" maxlength="50" class="input req-string" value="<%=art_time%>" /> (yyyy-mm-dd)</td>
		</tr>
		<tr>
			<td>内容</td>
			<td>
				<span id="inputfileuploadtitle">点击上传图片：</span>&nbsp;<input type="checkbox" value="0" name="addwatermark" id="addwatermark" onchange="initInputfile();" checked="true" />添加水印<input name="file" type="file" id="inputfileupload" class="input" style="height:25px" />
				<span id="inputfileuploadmsg" class="c2"></span><br/>
				<textarea id="inputCLE" name="art_content"><%=art_content%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="c">
				<input type='submit' value='保存' name="save" id="btnsave" /> 
				<input type='button' value='返回' name="return" id="btnreturn" /> 
				<input type="hidden" value="<%=action%>" name="action" /> 
				<input type="hidden" value="<%=module%>" name="module" /> 
				<div id="errorDiv" class="error-div"></div>
			</td>
		</tr>
	</table>
	<iframe id="selectclass" src="" style="display:none"></iframe>
</div>
</form>
<script>

$(document).ready(function(){
	$( "#accordion" ).accordion();

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
          height:       550, // height not including margins, borders or padding
         controls:     // controls to add to the toolbar
                        "bold underline | size color removeformat | outdent " +
                        "indent | alignleft center alignright justify | undo redo | " +
                        "rule image link unlink pastetext | source" 
	})[0];

})


var qus = [];
var editor;
function initInputfile(){
	file = document.getElementById("inputfileupload"),
	qu = new QuickUpload(file, {
		action: "upload.asp?watermark=" + document.getElementById("addwatermark").checked,
		timeout: 180,
		onReady: function(){
			file.style.display = "none";
			$("#inputfileuploadtitle").text("");
			showmsg("上传中...");
		},
		onFinish: function(iframe){
			try{//处理返回信息(需要后台配合)
				var info = eval("(" + iframe.contentWindow.document.body.innerHTML + ")");
				showmsg("上传完成");
				editor.$area.val( "<img src=" + info.path + " \/>" + editor.$area.val());
				editor.updateFrame();
				editor.focus();
			}catch(e){//获取数据出错
				showmsg("上传失败"); ResetFile(file);return;
			}
			ResetFile(file);
			//移除程序
			this.remove();
		},
		onStop: function(){ showmsg("已经停止"); ResetFile(file); },
		onTimeout: function(){ showmsg("上传超时"); ResetFile(file);}
	});
	
	
	//function stop(){
		//count--; //CheckBtn();
		//a.innerHTML = "重置"; a.onclick = reset;
		//file.style.display = msgfile.innerHTML =				
		//title.style.display = msgtitle.innerHTML = "";
	//}
	
	//function reset(){ showmsg("选择文件"); ResetFile(file); return false; }
	
	function showmsg(m){ $("#inputfileuploadmsg").html(m); }
}
initInputfile();

//选择完图片即上传
$$("inputfileupload").onchange = function(){
	qus.push(qu);
	$$A.filter(qus, function(qu){ qu.upload(); }); 
	initInputfile();
}

//重置上传控件
function ResetFile(file){
	file.value = "";//ff chrome safari
	if ( file.value ) {
		if ( $$B.ie ) {//ie
			with(file.parentNode.insertBefore(document.createElement('form'), file)){
				appendChild(file); reset(); removeNode(false);
			}
		} else {//opera
			file.type = "text"; file.type = "file";
		}
	}
	file.style.display = "block";
	$("#inputfileuploadtitle").text("点击上传图片：")
	document.getElementById("addwatermark").checked = document.getElementById("addwatermark").checked;
}

function changesortselect(v){
	document.getElementById("selectclass").src = "changesortselect.asp?sort_2="+v;
}
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->