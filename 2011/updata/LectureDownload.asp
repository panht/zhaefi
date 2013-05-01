<!--#include file="../uc/conn.asp"-->
<%strModuleName="讲座管理"%>
<!--#include file="uc/userright.asp"-->
<%

function CheckLength(sStr, lLength)
	if len(sStr) < lLength then
		CheckLength = String(lLength - len(sStr), "0") & sStr
	else
		CheckLength = sStr
	end if
end function

function dl(filePath, fileName)
	'on error resume next
	Dim S
	Set S=server.CreateObject("Adodb.Stream") 
	S.Mode=3 
	S.Type = 1
	S.Open 
	S.LoadFromFile(server.mappath(filePath & fileName))
	

	if Err.Number>0 then 
		Response.Status="404"
	else
		Response.ContentType="application/*"
		Response.AddHeader "Content-Disposition:","attachment; filename=" & fileName
		Range=Mid(Request.ServerVariables("HTTP_RANGE"),7)
		if Range="" then
			Response.BinaryWrite(S.Read)
		else
		'S.position=Clng(Split(Range,"-")(0))
			Response.BinaryWrite(S.Read)
		End if
	end if
	Response.End
end function

id=request("id")
Subject=Server.urlencode(request("Subject"))
sFilename= Subject & "-网上报名表.xls"
Set fso = CreateObject("Scripting.FileSystemObject")
Set ts = fso.CreateTextFile(server.mapPath("./Download/" & sFilename), True, True)

sStr = "公司" & vbTab & "姓名" & vbTab & "职务" & vbTab & "电话" & vbTab & "传真" & vbTab & "手机" & vbTab & "电子邮箱" & vbTab & "交费" & vbTab & "报名时间" & vbTab & "备注" & VBcrlf
ts.WriteLine sStr

sortx=" order by PostDate desc"
keyword=request("keyword")
sqltext="select * from LectureSignUp where LectureID=" & id 

sqltext = sqltext & sortx
rs.open sqltext,conn,1,1
'set err1=conn.errors
'response.write "ERR: " + err1(0).description

if not rs.eof then
	for i=1 to rs.recordcount
		company=rs("company"):if isnull(company) then company=""
		username=rs("username"):if isnull(username) then username=""
		title=rs("title"):if isnull(title) then title=""
		tel=rs("tel"):if isnull(tel) then tel=""
		fax=rs("fax"):if isnull(fax) then fax=""
		cellphone=rs("cellphone"):if isnull(cellphone) then cellphone=""
		email=rs("email"):if isnull(email) then email=""
		feetype=rs("feetype"):if isnull(feetype) then feetype=""
		postdate=rs("postdate"):if isnull(postdate) then postdate=""
		remarks=rs("remarks"):if isnull(remarks) then remarks=""
					
		sStr= " " & company & vbTab
		sStr=sStr & " " &  username & vbTab
		sStr=sStr & " " &  title & vbTab
		sStr=sStr & " " &  tel & vbTab
		sStr=sStr & " " &  fax & vbTab
		sStr=sStr & " " &  cellphone & vbTab
		sStr=sStr & " " &  email & vbTab
		sStr=sStr & " " &  feetype & vbTab
		sStr=sStr & " " & postdate & vbTab
		sStr=sStr & " " &  remarks & vbTab
		'sStr=sStr & VBcrlf
		ts.WriteLine sStr
		rs.movenext
	next	
end if
rs.close

'ts.write(sStr)
'set err1=fso.errors
'response.write "ERR: " + err1(0).description
ts.close
call dl("./Download/", sFilename)
set ts = nothing
set fso = nothing
%>
<SCRIPT language=JavaScript>
	wp.document.execCommand("saveAs");
	window.close();
</SCRIPT>
<!--#include file="../uc/connfree.asp"-->