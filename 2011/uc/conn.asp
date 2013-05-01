<%
dim conn   
dim connstr

'on error resume next
'connstr="DBQ="+server.mappath("/uc/db/zhaefi.asa")+";DefaultDir=;DRIVER={Microsoft Access Driver (*.mdb)};"
connstr="provider=microsoft.jet.oledb.4.0;data source=" & server.mappath("/uc/db/zhaefi.mdb")
set conn=server.createobject("ADODB.CONNECTION")
set rs=server.createobject("ADODB.RECORDSET")
conn.open connstr 

function pageSplit(parameter)
	if rcount="" or isnull(rcount) then rcount=0
	if pagecount="" or isnull(pagecount) then pagecount=0
	if page="" or isnull(page) then page=0
	if rowcount1="" or isnull(rowcount1) then rowcount1=20
	if parameter="" then
		strParameter=""
	else
		Parameter1=split(parameter, ",")
		for parameteri=0 to ubound(parameter1)
	strParameter=strParameter&"&"&parameter1(parameteri)&"="&Server.URLEncode(request(parameter1(parameteri)))
		next
	end If
	
	strPageSplit = "<div class=""page_css page_line"">" & chr(13)
	strPageSplit = strPageSplit & "<span class=""pagecss"">" & chr(13)
	strPageSplit = strPageSplit & "共<span class=""c1"">" & rcount & "</span>条, <span class=""c1"">" & page & "</span>/<span class=""c1"">" & pagecount & "</span>页" & chr(13)
	if page<>1 and pagecount<>0 then
		strPageSplit = strPageSplit & "<a href=""?page=1" & strParameter & """>首页</a>" & chr(13)
		strPageSplit = strPageSplit & "<a href=""?page=" & page-1 & strParameter & """>上页</a>" & chr(13)
	End If
	if page<>pagecount and pagecount<>0 Then		
		strPageSplit = strPageSplit & "<a href=""?page="  & page+1 & strParameter & """>下页</a>" & chr(13)
		strPageSplit = strPageSplit & "<a href=""?page=" & pagecount & strParameter & """>尾页</a>" & chr(13)
	End If
	strPageSplit = strPageSplit & "</span>" & chr(13)
	strPageSplit = strPageSplit & "</div>" & chr(13)

	'strPageSplit="<form name='frmpage'>"
	'strPageSplit=strPageSplit&"共<font color=red>"&rcount&"</font>条记录 | 共<font color=red>"&pagecount&"</font>页 | 第<font color=red>"&page&"</font>页 | 每页<font color=red>"&rowcount1&"</font>条&nbsp;"
	'strPageSplit=strPageSplit&"<script language='javascript'>"
	'strPageSplit=strPageSplit&"function gopage(){window.location.href='?page='+frmpage.page.value+'"&strParameter&"'}"
	'strPageSplit=strPageSplit&"function keychk(){if ((window.event.keyCode<48)||(window.event.keyCode>57)){window.event.keyCode=0;}}"
	'strPageSplit=strPageSplit&"</script>"
	'if page<>1 and pagecount<>0 then
	'	strPageSplit=strPageSplit&"<a href='?page=1"&strParameter&"'>首页</a>&nbsp;<a href='?page="&page-1&strParameter&"'>上页</a>&nbsp;"
	'end if
	'if page<>pagecount and pagecount<>0 then
	'	strPageSplit=strPageSplit&"<a href='?page="&page+1&strParameter&"'>下页</a>&nbsp;<a href='?page="&pagecount&strParameter&"'>尾页</a>&nbsp;"
	'end if
	'if pagecount>1 then
	'	strPageSplit=strPageSplit&"转到<input name='page' type='text' size='2' maxlength='10' onkeypress='keychk()'>页<input name='go' type='button' value='Go' onclick='gopage()' class='button'>&nbsp;</form>"
	'end if
	response.write strPageSplit
end function

'替换换行符为<br/>
function changechr(str)
	IF IsNull(str) THEN
		str = ""
	END IF
	changechr=replace(replace(replace(str,chr(13),"<br/>")," ","&nbsp;"), "<a&nbsp;", "<a ")
end function 

'获取当前页面URL
Function URLCurrent()    
	'Domain_Name = LCase(Request.ServerVariables("Server_Name"))
	Page_Name = LCase(Request.ServerVariables("Script_Name"))
	Query_Name = LCase(Request.ServerVariables("Query_String"))

	If Query_Name ="" Then
		URLCurrent = Page_Name
	Else
		URLCurrent = Page_Name & "?" & Query_Name
	End If
End Function
%>