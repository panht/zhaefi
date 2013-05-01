<!--#include file="../uc/conn.asp"-->
<%strModuleName="帐号管理"%>
<!--#include file="uc/userright.asp"-->
<%
'on error resume next
If request("btnSave")="保存" then
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
	'如果有父节点，则置父节点的HasChild为1
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
		
		'拼接为js数组，传到客户端由jquery处理生成树
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
	<title>珠海外商投资企业协会</title>	
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
<!--菜单-->
<!--#include file="uc/menu.asp" -->

<!--表格-->
<div class="fl mt10 ml10 bd1">
	<div class="c c2 fs18">栏目管理</div>
	
<!--树-->
<div id="tree" class="w220 ml10 fl mt10">
	<div class="c1">点击右键添加节点和编辑栏目</br>栏目最多3级，超过三级无法处理文章</br></div>
	<span id="treeTitle">栏目管理</span>
	<ul id="root" class="treeview-gray treeview">
	</ul>
</div>
<!--表单-->
<form name="form1" id="form1" method="post">
<div id="panel" class="ml10 fl mt10 dn">
	<table class="tableForm form">
	  <tr> 
		<td class="w50">ID</td>
		<td id="ModuleIdDisplay">&nbsp;</td>
	  </tr>
	  <tr> 
		<td class="w50">文章栏目</td>
		<td><input type="text" name="ModuleName" id="ModuleName" size="20" maxlength="20" value="" class="input req-string" /></td>
	  </tr>
	  <tr> 
		<td class="w50">排序号</td>
		<td><input type="text" name="seqno" id="seqno" size="10" maxlength="5" value="" class="input req-numeric"/></td>
	  </tr>
	  <tr> 
		<td>备注</td>
		<td><input type="text" name="ModuleMemo" id="ModuleMemo" size="20" maxlength="20" value="" class="input" /></td>
	  </tr>
	  <tr> 
		<td colspan="2" class="c">
			<input type="hidden" name="ModuleId" id="ModuleId" value="0"/>
			<input type="hidden" name="ModuleLevel" id="ModuleLevel" value="1"/>
			<input type="hidden" name="ParentModule" id="ParentModule" value="1"/>
			<input type="hidden" name="Action" id="Action" value="new"/>
			<input type='submit' size='3' value='保存' name="btnSave" id="btnSave" />
			<div id="errorDiv1" class="error-div"></div>
		</td>
	  </tr>
  </table>
</div>

<div class="clear"></div>
</form>

<!--根节点菜单-->
<div class="contextMenu" id="myMenuRoot">
	<ul>
		<li id="addChild"><img src="../static/js/contextmenu/addChild.png" />添加下级栏目 </li>
	</ul>
</div>
<!--普通节点菜单-->
<div class="contextMenu bs1g" id="myMenu1">
	<ul>
		<li id="addChild"><img src="../static/js/contextmenu/addChild.png" />添加下级栏目 </li>
		<li id="addBrother"><img src="../static/js/contextmenu/addBrother.png" />添加同级栏目 </li>
		<li id="property"><img src="../static/js/contextmenu/property.png" />编辑 </li>
	</ul>
</div>

</div>
</form>
<script>
$(document).ready(function(){
	$( "#accordion" ).accordion({ active: 2 });

	//从服务端接收树节点数组，生成树
	//nodeid, nodename, nodetype, nodeparent, nodehaschild， nodelevel， nodeurl， nodememo
	var arrayTree = <%=strTreeArray%>;
	var parentNode;
	$.each(arrayTree, function(i, n){
		//获取当前要生成的节点的父节点
		if (n.nodelevel == 1){
			parentNode = "#root";
		}else{
			parentNode = "#branch" + n.nodeparent;
		}
		
		//插入当前节点
		$(parentNode).append("<li class='treenode ch' id='" + n.nodeid + "' nodename='" + n.nodename + "' nodeparent='" + n.nodeparent + "' nodehaschild='" + n.nodehaschild + "' nodelevel='" + n.nodelevel + "' nodememo='" + n.nodememo + "' nodeseqno='" + n.nodeseqno +"'>" + n.nodename + "</li>");
		
		
		//当前节点如果有子节点
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

	//遍历树，替换最后一个li的样式
	$.each($(".treenode"), function(i, n){
		//同层级最后一个li
		if ($("#" + n.id +" ~li").length == 0 )
		{
			$("#" + n.id).addClass("last");
			//如果有子节点
			if($("#" + n.id).attr("nodehaschild") != "False"){		
				$("#" + n.id).addClass("lastCollapsable");
				$("#" + n.id + "> div").addClass("lastCollapsable-hitarea");
			}
		}
	});


	//绑定树操作
	$("#root").treeview({
		control: "#treecontrol",
		persist: "cookie",
		cookieId: "treeview-black"
	});

	//节点点击事件
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

	//表单验证及提交
	$('#btnSave').formValidator({
		scope : '#form1',
		errorDiv : '#errorDiv'
	});
});

/*
//根节点右键菜单
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

//普通节点右键菜单
//nodeid, nodename, nodetype, nodeparent, nodehaschild， nodelevel， nodeurl， nodememo
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