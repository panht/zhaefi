<!--#include file="../uc/conn.asp"-->
<%strModuleName="�ʺŹ���"%>
<!--#include file="uc/userright.asp"-->
<%
'on error resume next
If request("btnSave")="����" then
	ModuleId=request("ModuleId")
	ModuleName=request("ModuleName")
	ParentModule = request("ParentModule")
	seqno=request("seqno")
	If Not IsNumeric(seqno) Then seqno=0
	ModuleMemo=request("ModuleMemo")
	ModuleLevel=request("ModuleLevel")
	
	If request("Action") = "new" Then 
		sql = "select max(id) from moduletree"
		rs.open sql,conn,1,1
		If Not rs.eof Then idnew = rs(0) + 1
		rs.close
		sql = "insert into ModuleTree(id, ModuleName, ParentModule, ModuleLevel, ModuleMemo, seqno)"
		sql = sql + " values(" & idnew & ", '"&ModuleName&"', "&ParentModule&",  '"&ModuleLevel&"', '"&ModuleMemo&"', "&seqno&")"
	Else
		sql = "Update ModuleTree set ModuleName='" & ModuleName & "', ModuleMemo='" & ModuleMemo & "', seqno=" & seqno & " where id=" & ModuleId
	End If 
	response.write sql
	'response.End
	conn.execute(sql)
	'����и��ڵ㣬���ø��ڵ��HasChildΪ1
	If ParentModule > 0 Then
		conn.execute("Update ModuleTree set HasChild=1 where id=" & ParentModule)
	End If
	'set err1=conn.errors
	'response.write err1(0).description
	conn.close
	response.redirect "adminmodule.asp"
Else
	sql="select * from ModuleTree order by ModuleLevel, seqno"
	rs.open sql,conn,1,1
	If Not rs.eof Then
		strTreeArray="["
		
		'ƴ��Ϊjs���飬�����ͻ�����jquery����������
		Do While Not rs.eof
			id = rs("id")
			ModuleName = rs("ModuleName")
			ParentModule = rs("ParentModule")
			HasChild = rs("HasChild")
			ModuleLevel = rs("ModuleLevel")
			seqno = rs("seqno")
			ModuleMemo = rs("ModuleMemo")
			
			strTreeArray = strTreeArray & "{"
			strTreeArray = strTreeArray & """nodeid"":""" & id & ""","
			strTreeArray = strTreeArray & """nodename"":""" & ModuleName & ""","
			strTreeArray = strTreeArray & """nodeparent"":""" & ParentModule & ""","
			strTreeArray = strTreeArray & """nodehaschild"":""" & HasChild & ""","
			strTreeArray = strTreeArray & """nodelevel"":" & ModuleLevel & ","
			strTreeArray = strTreeArray & """nodeseqno"":""" & seqno & ""","
			strTreeArray = strTreeArray & """nodememo"":""" & ModuleMemo & """"
			strTreeArray = strTreeArray & "}" & Chr(13)

			rs.movenext
			If rs.eof Then
				Exit Do
			Else
				strTreeArray = strTreeArray & ","
			End If		
		Loop

		strTreeArray = strTreeArray & "]"
	End If
End If
rs.close
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<title>�麣����Ͷ����ҵЭ��</title>	
	<link rel="stylesheet" href="../static/js/treeview/jquery.treeview.css" />
	<link rel="stylesheet" href="../static/js/treeview/screen.css" />
	<link rel="stylesheet" href="../static/js/ufvalidator/ufvalidator.css" />
<!--#include file="uc/static.asp" -->
	<script src="../static/js/ufvalidator/jquery.ufvalidator.js" type="text/javascript"></script>
	<script src="../static/js/treeview/jquery.treeview.js" type="text/javascript"></script>
	<script src="../static/js/treeview/jquery.cookie.js" type="text/javascript"></script>
	<script src="../static/js/contextmenu/jquery.contextmenu.js" type="text/javascript"></script>
</head>
<body> 
<form method="post" name="form1">
<!--�˵�-->
<!--#include file="uc/menu.asp" -->

<!--���-->
<div class="fl mt10 ml10 bd1">
	<div class="c c2 fs18">��Ŀ����</div>
	
<!--��-->
<div id="tree" class="w220 ml10 fl mt10">
	<div class="c1">����Ҽ���ӽڵ�ͱ༭��Ŀ</br>��Ŀ���3�������������޷���������</br></div>
	<span id="treeTitle">��Ŀ����</span>
	<ul id="root" class="treeview-gray treeview">
	</ul>
</div>
<!--��-->
<form name="form1" id="form1" method="post">
<div id="panel" class="ml10 fl mt10 dn">
	<table class="tableForm form">
	  <tr> 
		<td class="w50">ID</td>
		<td id="ModuleIdDisplay">&nbsp;</td>
	  </tr>
	  <tr> 
		<td class="w50">������Ŀ</td>
		<td><input type="text" name="ModuleName" id="ModuleName" size="20" maxlength="20" value="" class="input req-string" /></td>
	  </tr>
	  <tr> 
		<td class="w50">�����</td>
		<td><input type="text" name="seqno" id="seqno" size="10" maxlength="5" value="" class="input req-numeric"/></td>
	  </tr>
	  <tr> 
		<td>��ע</td>
		<td><input type="text" name="ModuleMemo" id="ModuleMemo" size="20" maxlength="20" value="" class="input" /></td>
	  </tr>
	  <tr> 
		<td colspan="2" class="c">
			<input type="hidden" name="ModuleId" id="ModuleId" value="0"/>
			<input type="hidden" name="ModuleLevel" id="ModuleLevel" value="1"/>
			<input type="hidden" name="ParentModule" id="ParentModule" value="1"/>
			<input type="hidden" name="Action" id="Action" value="new"/>
			<input type='submit' size='3' value='����' name="btnSave" id="btnSave" />
			<div id="errorDiv1" class="error-div"></div>
		</td>
	  </tr>
  </table>
</div>

<div class="clear"></div>
</form>

<!--���ڵ�˵�-->
<div class="contextMenu" id="myMenuRoot">
	<ul>
		<li id="addChild"><img src="../static/js/contextmenu/addChild.png" />����¼���Ŀ </li>
	</ul>
</div>
<!--��ͨ�ڵ�˵�-->
<div class="contextMenu bs1g" id="myMenu1">
	<ul>
		<li id="addChild"><img src="../static/js/contextmenu/addChild.png" />����¼���Ŀ </li>
		<li id="addBrother"><img src="../static/js/contextmenu/addBrother.png" />���ͬ����Ŀ </li>
		<li id="property"><img src="../static/js/contextmenu/property.png" />�༭ </li>
	</ul>
</div>

</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 2 });

	//�ӷ���˽������ڵ����飬������
	//nodeid, nodename, nodetype, nodeparent, nodehaschild�� nodelevel�� nodeurl�� nodememo
	var arrayTree = <%=strTreeArray%>;
	var parentNode;
	$.each(arrayTree, function(i, n){
		//��ȡ��ǰҪ���ɵĽڵ�ĸ��ڵ�
		if (n.nodelevel == 1){
			parentNode = "#root";
		}else{
			parentNode = "#branch" + n.nodeparent;
		}
		
		//���뵱ǰ�ڵ�
		$(parentNode).append("<li class='treenode ch' id='" + n.nodeid + "' nodename='" + n.nodename + "' nodeparent='" + n.nodeparent + "' nodehaschild='" + n.nodehaschild + "' nodelevel='" + n.nodelevel + "' nodememo='" + n.nodememo + "' nodeseqno='" + n.nodeseqno +"'>" + n.nodename + "</li>");
		
		
		//��ǰ�ڵ�������ӽڵ�
		if (n.nodehaschild != "False"){
			$("#"+n.nodeid).addClass("collapsable");
			$("#"+n.nodeid).wrapInner("<span></span>");
			$("#"+n.nodeid).prepend("<div class='hitarea collapsable-hitarea'></div>");
			if ($("#branch" + n.nodeid).length == 0)
			{
				$("#"+n.nodeid).append("<ul id='branch" + n.nodeid + "'></ul>");
			}
		}
	});

	//���������滻���һ��li����ʽ
	$.each($(".treenode"), function(i, n){
		//ͬ�㼶���һ��li
		if ($("#" + n.id +" ~li").length == 0 )
		{
			$("#" + n.id).addClass("last");
			//������ӽڵ�
			if($("#" + n.id).attr("nodehaschild") != "False"){		
				$("#" + n.id).addClass("lastCollapsable");
				$("#" + n.id + "> div").addClass("lastCollapsable-hitarea");
			}
		}
	});


	//��������
	$("#root").treeview({
		control: "#treecontrol",
		persist: "cookie",
		cookieId: "treeview-black"
	});

	//�ڵ����¼�
	$(".treenode").click(function(t){
		$(".treenode").removeClass("highlight");
		$(".treenode > span").removeClass("highlight");
		$(t.target).addClass("highlight");
		$("input#ModuleId").val(t.target.id);
		$("#ModuleIdDisplay").text(t.target.id);
		$("input#ModuleName").val(t.target.attributes["nodename"].nodeValue);
		$("input#ModuleLevel").val( t.target.attributes["nodelevel"].nodeValue);
		$("input#ModuleMemo").val(t.target.attributes["nodememo"].nodeValue);
		$("input#seqno").val(t.target.attributes["nodeseqno"].nodeValue);
		$("input#Action").val("edit");
		$("#panel").removeClass("dn");
	});

	//����֤���ύ
	$('#btnSave').formValidator({
		scope : '#form1',
		errorDiv : '#errorDiv'
	});
});

/*
//���ڵ��Ҽ��˵�
$('#treeTitle').contextMenu('myMenuRoot', {
	bindings: {
		'addChild': function(t) {			
			$("input#ModuleId").val("");
			$("#ModuleIdDisplay").text("");
			$("input#ParentModule").val(0);
			$("input#ModuleLevel").val(1);
			$("input#ModuleName").val("");
			$("input#ModuleMemo").val("");
			$("input#Action").val("new");
			$("#panel").removeClass("dn");
        }
	}
});*/

//��ͨ�ڵ��Ҽ��˵�
//nodeid, nodename, nodetype, nodeparent, nodehaschild�� nodelevel�� nodeurl�� nodememo
//sql = "insert into ModuleTree(ModuleName, ParentModule, ModuleType, ModuleLevel, ModuleUrl, ModuleMemo)"
$('.treenode').contextMenu('myMenu1', {
	bindings: {
		'addChild': function(t) {	
			$("input#ModuleId").val("");
			$("#ModuleIdDisplay").text("");
			$("input#ParentModule").val($(t).attr("id"));
			$("input#ModuleLevel").val(parseInt($(t).attr("nodelevel")) + 1);
			$("input#ModuleName").val("");
			$("input#ModuleMemo").val("");
			$("input#seqno").val("90");
			$("input#Action").val("new");
			$("#panel").removeClass("dn");
        },
        'addBrother': function(t) {	
			$("input#ModuleId").val("");
			$("#ModuleIdDisplay").text("");
			$("input#ParentModule").val($(t).attr("nodeparent"));
			$("input#ModuleLevel").val($(t).attr("nodelevel"));
			$("input#ModuleName").val("");
			$("input#ModuleMemo").val("");
			$("input#seqno").val("90");
			$("input#Action").val("new");
			$("#panel").removeClass("dn");
        },
        'property': function(t) {
			$("#panel").removeClass("dn");
			$("input#ModuleId").val($(t).attr("id"));
			$("#ModuleIdDisplay").text($(t).attr("id"));
			$("input#ModuleName").val($(t).attr("nodename"));
			$("input#ModuleLevel").val( $(t).attr("nodelevel"));
			$("input#ModuleMemo").val($(t).attr("nodememo"));
			$("input#seqno").val($(t).attr("nodeseqno"));
			$("input#Action").val("edit");
        },
        'gotoArticles': function(t) {
			alert('Trigger was '+t.id+'\nAction was articles');
        }
	}
});
</script>
</body></html>
<!--#include file="../uc/connfree.asp"-->