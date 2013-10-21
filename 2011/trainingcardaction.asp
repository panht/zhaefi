<% Session.CodePage=936 
Response.Charset="GBK" %> 
<!--#include file="uc/conn.asp"-->
<%
action=request("action")

if action="login" Then
	cardno = decodeText(request("logincardno"))
	cardpassword = decodeText(request("logincardpassword"))
	'¿¨ºÅÃÜÂëÊÇ·ñÕýÈ·
	sql = "select * from trainingcard where cardno = '" & cardno & "' and password = '" & cardpassword & "'"
	rs.open sql, conn, 1, 1
	if rs.eof then
		response.write "[{'code': -1, 'message':'¿¨ºÅ»òÃÜÂë´íÎó£¬ÇëÖØÐÂÊäÈë'}]"
		response.end
	else
		response.write "[{'code': 1, 'message':'µÇÂ¼³É¹¦'}]"
		session("cardno") = rs("cardno")
		session("CompanyName") = rs("CompanyName")
		Session.Timeout= 30
	end if
	rs.close
	
	response.write result
	response.end
end if
%>
<!--#include file="uc/connfree.asp"-->
<script language="javascript" runat="server">
function decodeText(str){
    return (str == null ? "" : decodeURIComponent(str));
}
</script>