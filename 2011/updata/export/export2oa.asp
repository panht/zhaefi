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
	sql = "select * from trainingcard where datediff('s', #" & lastSyncTime & "#, updatetime) > 0"
	rs.open sql, conn, 1, 1
	if not rs.eof then
		result = result & "'dataCard' => array("
		do while not rs.eof
			result = result & "array("
			result = result & "'CompanyName' => '" & rs("CompanyName") & "', "
			result = result & "'MemberID' => '" & rs("MemberID") & "', "
			result = result & "'CardNo' => '" & rs("CardNo") & "', "
			result = result & "'CardType' => '" & rs("CardType") & "', "
			result = result & "'CardStatus' => '" & rs("CardStatus") & "', "
			result = result & "'OwnerName' => '" & rs("OwnerName") & "', "
			result = result & "'OwnerCellphone' => '" & rs("OwnerCellphone") & "', "
			result = result & "'OwnerEmail' => '" & rs("OwnerEmail") & "', "
			result = result & "'Memo' => '" & rs("Memo") & "', "
			result = result & "'CreateDate' => '" & rs("CreateDate") & "', "
			result = result & "'CancelDate' => '" & rs("CancelDate") & "', "
			result = result & "'Balance' => '" & rs("Balance") & "', "
			result = result & "'CreateTime' => '" & rs("CreateTime") & "', "
			result = result & "'CreateBy' => '" & rs("CreateBy") & "', "
			result = result & "'UpdateTime' => '" & rs("UpdateTime") & "', "
			result = result & "'UpdateBy' => '" & rs("UpdateBy") & "'"
			result = result & ")"
			rs.movenext
			if not rs.eof then
				result = result & ", "
			end if
		loop
		result = result & "), "
	end if
	rs.close
	
	' ͬ��ѧϰ����¼
	sql = "select tcr.*, tc.CompanyName, tc.MemberID, tc.CardType from trainingcardrecord tcr, trainingcard tc where tcr.TrainingCardID = tc.id and datediff('s', #" & lastSyncTime & "#, tcr.createtime) > 0"
	rs.open sql, conn, 1, 1
	if not rs.eof then
		result = result & "'dataRecord' => array("
		do while not rs.eof
			result = result & "array("
			result = result & "'TrainingCardID' => '" & rs("TrainingCardID") & "', "
			if (rs("RecordType") = 1) then
				RecordType = "��ֵ" 
			elseif (rs("RecordType") = 2) then
				RecordType = "֧��"
			end if 
			result = result & "'RecordType' => '" & RecordType & "', "
			result = result & "'CardNo' => '" & rs("CardNo") & "', "
			result = result & "'Amount' => '" & rs("Amount") & "', "
			result = result & "'RecordTime' => '" & rs("RecordTime") & "', "
			result = result & "'Remark' => '" & rs("Remark") & "', "
			result = result & "'CreateBy' => '" & rs("CreateBy") & "', "
			result = result & "'CreateTime' => '" & rs("CreateTime") & "',"
			result = result & "'MemberID' => '" & rs("MemberID") & "',"
			result = result & "'CompanyName' => '" & rs("CompanyName") & "',"
			result = result & "'CardType' => '" & rs("CardType") & "'"
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
	sql = "insert into trainingcardsync(operator) values('" & username & "')"
	conn.execute(sql)
	
	result = result & ");"
end if
	
response.write result
%>
<!--#include file="../../uc/connfree.asp"-->