<!--#include file="../../uc/conn.asp"-->
<%
' У���û�������
username = request("u")
password = request("p")
sql="select * from admin where UserName='" & username & "' and [PassWord]='" & password & "'"
rs.open sql,conn,1,1

If rs.eof Then
	rs.close
	' ���ش�����Ϣ
	result = "$data = array('code' => -1, 'err' =>'');"
else
	rs.close
	result = "$data = array('code' => 1, "
	
	' ����ϴ�ͬ��ʱ��
	sql = "select top 1 SyncTime from trainingcardsync order by syncTime desc"
	rs.open sql, conn, 1, 1
	if not rs.eof then
		lastSyncTime = rs("SyncTime")
	end if
	rs.close

	' ͬ��ѧϰ��

	' ͬ��ѧϰ����¼
	sql = "select * from trainingcardrecord where createtime > #" & lastSyncTime & "#"
	rs.open sql, conn, 1, 1
	if not rs.eof then
		result = result & "'dataRecord' => array("
		do while not rs.eof
			result = result & "array("
			result = result & "'TrainingCardID' => '" & rs("TrainingCardID") & "', "
			result = result & "'RecordType' => " & rs("RecordType") & ", "
			result = result & "'CardNo' => '" & rs("CardNo") & "', "
			result = result & "'Amount' => " & rs("Amount") & ", "
			result = result & "'RecordTime' => '" & rs("RecordTime") & "', "
			result = result & "'Remark' => '" & rs("Remark") & "', "
			result = result & "'CreateBy' => '" & rs("CreateBy") & "', "
			result = result & "'CreateTime' => '" & rs("CreateTime") & "'"
			result = result & ")"
			rs.movenext
			if not rs.eof then
				result = result & ", "
			end if
		loop
		result = result & ")"
	end if
	rs.close

	' ����ͬ��ʱ��
	sql = "insert into trainingcardsync(operator) values('')"
	'conn.execute(sql)
	
	result = result & ");"
end if
	
response.write result
%>
<!--#include file="../../uc/connfree.asp"-->