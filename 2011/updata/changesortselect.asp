<!--#include file="../uc/conn.asp"-->
<%
'���������������
sort_2=request("sort_2")
sql="select * from moduletree where parentmodule=" & sort_2 & " order by seqno"
rs.open sql,conn,1,1
If rs.recordcount > 0 Then
	str_sclass="<option selected value=''>��ѡ������..</option>"
	for i=1 to rs.recordcount
		str_sclass=str_sclass & "<option value='" & rs("id") & "'>" & rs("modulename") & "</option>"
		rs.movenext
	Next
Else
	sclasstyle="none"
End If
rs.close
%>
<script language=javascript>
if (top.document.getElementById("form1").mclass.value!=""){
	top.document.getElementById("sclass").innerHTML="<%=str_sclass%>";
}
else{
	top.document.getElementById("sclass").innerHTML="<option>����ѡ�����һ...</option>";
}
</script>
<!--#include file="../uc/connfree.asp"-->