<!--#include file="../uc/conn.asp"-->
<%
module=request("module")
If module = 93 Then
	strModuleName="��Ѷ����"
	strTitle="��Ѷ����"
ElseIf module = 87 Then
	strModuleName="Э�ᶯ̬+��Ա����"
	strTitle="Э�ᶯ̬"
ElseIf module = 91 Then
	strModuleName="Э�ᶯ̬+��Ա����"
	strTitle="��Ա����"
ElseIf module = 92 Then
	strModuleName="�`+ר��+ר��"
	strTitle="�`"
ElseIf module = 89 Then
	strModuleName="�`+ר��+ר��"
	strTitle="ר��"
ElseIf module = 90 Then
	strModuleName="�`+ר��+ר��"
	strTitle="ר��"
ElseIf module = 83 Then
	strModuleName="���߷���"
	strTitle="���߷���"
ElseIf module = 86 Then
	strModuleName="�ص�"
	strTitle="�ص�"
ElseIf module = 85 Then
	strModuleName="��վ��Ϣ"
	strTitle="��վ��Ϣ"
End If
%>
<!--#include file="uc/userright.asp"-->
<%
id=request("id")
CurrentPage = request("Page")
keyword=request("keyword")
action=request("action")


'�������
If request.Form("save") = "����" Then 
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
	pagetitle="��������"
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
	pagetitle="�༭����"
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



'������������Ϊ��moduletree���ȡ
'If module=83 Then
	set rs1=server.createobject("adodb.recordset")

	'sql="select m2.id as mid2, m2.modulename as mname2, m3.id as mid3, m3.modulename as mname3 from moduletree m2, moduletree m3 where m3.parentmodule = m2.id and m3.id="&sort_2
	'rs1.open sql,conn,1,1
	'if not rs1.eof then
	'	sort_2_name_this=rs1("mname2")
	'	sort_3_name_this=rs1("mname3")
	'end if
	'rs1.close

	'���ɶ������������
	sql="select * from moduletree where parentmodule=" & module & " order by seqno"
	rs1.open sql,conn,1,1
	str_mclass="<select name='mclass' onchange='changesortselect(this.value)'><option value=''>��ѡ�����һ...</option>"
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

	'�����������������
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
	<title>�麣����Ͷ����ҵЭ��</title>	
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
<!--�˵�-->
<!--#include file="uc/menu.asp" -->

<!--���-->
<div id="mainpanel" class="ml10 fl mt10 wmain">
	<div class="c c2 fs18">���¹���</div>
	<table cellspacing="0" cellpadding="0" border="0" class="tdetail mt10 form">
		<tr>
			<td>����</td>
			<td>
				<input type="text" name="art_title" size="70" maxlength="100" class="input req-string" style="width:360px" value="<%=art_title%>" />
				<input type="checkbox" name="art_title_b" value="b" <%If art_title_b="b" Then response.write "checked"%> /><B>�Ӵ�</B> 				
				<input type="radio" name="art_title_color" value="" checked /><span class="">��</span>
				<input type="radio" name="art_title_color" value="ctitlered" <%If art_title_color="ctitlered" Then response.write "checked"%> /><span class="ctitlered"><FONT COLOR="#FF0000">��</FONT></span>
				<input type="radio" name="art_title_color" value="ctitlecoffee" <%If art_title_color="ctitlecoffee" Then response.write "checked"%>  /><span class="ctitlecoffee"><FONT COLOR="#990000">��</FONT></span>
				<input type="radio" name="art_title_color" value="ctitlegreem" <%If art_title_color="ctitlegreem" Then response.write "checked"%>  /><span class="ctitlegreem"><FONT COLOR="#0066FF">��</FONT></span>
			</td>
		</tr>
		<tr>
			<td>���</td>
			<td>
				<%=str_mclass%>
				<select name="sclass" id="sclass">
					<%if sort_3 > 0 then
						response.write str_sclass
					ElseIf sort_2 > 0 Then %>
				  <option value="0">����ѡ�����...</option>
					<%end if%>
				</select>
			</td>
		</tr>
		<tr>
			<td>����ʱ��</td>
			<td><input type="text" name="art_time" size="50" maxlength="50" class="input req-string" value="<%=art_time%>" /> (yyyy-mm-dd)</td>
		</tr>
		<tr>
			<td>����</td>
			<td>
				<span id="inputfileuploadtitle">����ϴ�ͼƬ��</span>&nbsp;<input type="checkbox" value="0" name="addwatermark" id="addwatermark" onchange="initInputfile();" checked="true" />���ˮӡ<input name="file" type="file" id="inputfileupload" class="input" style="height:25px" />
				<span id="inputfileuploadmsg" class="c2"></span><br/>
				<textarea id="inputCLE" name="art_content"><%=art_content%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="c">
				<input type='submit' value='����' name="save" id="btnsave" /> 
				<input type='button' value='����' name="return" id="btnreturn" /> 
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

	//����֤���ύ
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
			showmsg("�ϴ���...");
		},
		onFinish: function(iframe){
			try{//��������Ϣ(��Ҫ��̨���)
				var info = eval("(" + iframe.contentWindow.document.body.innerHTML + ")");
				showmsg("�ϴ����");
				editor.$area.val( "<img src=" + info.path + " \/>" + editor.$area.val());
				editor.updateFrame();
				editor.focus();
			}catch(e){//��ȡ���ݳ���
				showmsg("�ϴ�ʧ��"); ResetFile(file);return;
			}
			ResetFile(file);
			//�Ƴ�����
			this.remove();
		},
		onStop: function(){ showmsg("�Ѿ�ֹͣ"); ResetFile(file); },
		onTimeout: function(){ showmsg("�ϴ���ʱ"); ResetFile(file);}
	});
	
	
	//function stop(){
		//count--; //CheckBtn();
		//a.innerHTML = "����"; a.onclick = reset;
		//file.style.display = msgfile.innerHTML =				
		//title.style.display = msgtitle.innerHTML = "";
	//}
	
	//function reset(){ showmsg("ѡ���ļ�"); ResetFile(file); return false; }
	
	function showmsg(m){ $("#inputfileuploadmsg").html(m); }
}
initInputfile();

//ѡ����ͼƬ���ϴ�
$$("inputfileupload").onchange = function(){
	qus.push(qu);
	$$A.filter(qus, function(qu){ qu.upload(); }); 
	initInputfile();
}

//�����ϴ��ؼ�
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
	$("#inputfileuploadtitle").text("����ϴ�ͼƬ��")
	document.getElementById("addwatermark").checked = document.getElementById("addwatermark").checked;
}

function changesortselect(v){
	document.getElementById("selectclass").src = "changesortselect.asp?sort_2="+v;
}
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->