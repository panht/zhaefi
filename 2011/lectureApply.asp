<% Session.CodePage=936
Response.Charset="GBK" %> 

<!--#include file="uc/conn.asp"-->
<%
'on error resume next
If request("action")="apply" then
	feetype=decodeText(request("feetype"))
	cardno=decodeText(request("cardno"))
	cardpassword=decodeText(request("cardpassword"))
	applyQuantity=decodeText(request("applyQuantity"))
	LectureID=decodeText(request("LectureID"))
	
	' ��ȡ������Ϣ
	sql = "select * from lecture where LectureID = " & LectureID
	rs.open sql, conn, 1, 1
	if not rs.eof then
		lectureSubject = rs("subject")
		PriceMemberCard = rs("PriceMemberCard")
		PriceCard = rs("PriceCard")
	end if
	rs.close
		
	'���ʹ��ѧϰ������
	if feetype = 3 then
		'���������Ƿ���ȷ
		'sql = "select * from trainingcard where cardno = '" & cardno & "' and password = '" & cardpassword & "'"
		sql = "select * from trainingcard where cardno = '" & session("cardno") & "'"
		rs.open sql, conn, 1, 1
		'if rs.eof then
		'	response.write "[{'code': -1, 'message':'���Ż������������������'}]"
		'	response.end
		'else
		if not rs.eof then
			cardtype = rs("cardtype")
			balance = rs("balance")
			TrainingCardID = rs("ID")
		end if
		rs.close
		
		' ��ý�������
		if cardtype = "��Ա��" then
			' ����ǻ�Ա��
			Amount = PriceMemberCard * applyQuantity
		elseif cardtype = "�ǻ�Ա��" then
			'����Ƿǻ�Ա��
			Amount = PriceCard * applyQuantity
		end if
		
		'����������
		if balance - Amount < 0 then
			response.write "[{'code': -2, 'message':'���Ͻ��㣬���ȳ�ֵ������ѡ��������ʽ����'}]"
			response.end
		end if
	end if
	
	'����
	FlagFree=decodeText(request("FlagFree"))
	LectureID=decodeText(request("LectureID"))
	company=decodeText(request("company"))
	applyUsername=decodeText(request("applyUsername"))
	tel=decodeText(request("tel"))
	SP=decodeText(request("SP"))
	fax=decodeText(request("fax"))
	cellphone=decodeText(request("cellphone"))
	title=decodeText(request("title"))
	email=decodeText(request("email"))
	Remarks=decodeText(request("Remarks"))
	
	' ���ʹ��ѧϰ������
	if feetype = 3 then
		RecordType = 2 '�̶�Ϊ�ۿ�
		RecordTime = date
		Remark = applyQuantity & "�˱����μӡ�" & lectureSubject & "��"
		createby = company
		
		'д��ѧϰ����¼��
		sql="insert into trainingcardrecord (TrainingCardID, RecordType, CardNo, Amount, RecordTime, Remark, createby) values("&TrainingCardID&", "&RecordType&", '"&cardno&"', "&Amount&", #"&RecordTime&"#, '"&Remark&"', '"&createby&"')"
		conn.execute(sql)
		
		'ѧϰ���ۿ�
		sql = "update trainingcard set balance = balance - " & amount & ", updatetime=now() where id = " & TrainingCardID
		conn.execute(sql)
	end if
	
	' д�뱨����
	if feetype = 1 then
		feetypetext = "�ֳ�"
	elseif feetype = 2 then
		feetypetext = "��ǰ"
	elseif feetype = 3 then
		feetypetext = "ѧϰ�� " & cardno
	end if
	sql = "insert into LectureSignUp(LectureID, company, username, feetype, title, cellphone, tel, SP, fax, Remarks, email) values(" & LectureID & ", '" & company & "', '" & applyUsername & "', '" & feetypetext & "', '" & title & "', '" & cellphone & "', '" & tel & "', '" & SP & "', '" & fax & "', '" & Remarks & "', '" & Email & "')"
	conn.execute(sql)
	
	' ���ر����ɹ�
	if feetype = 3 then
		response.write "[{'code': 1, 'message':'�����ɹ���ѧϰ�����Ϊ" & balance - amount & "'}]"
	else
		response.write "[{'code': 1, 'message':'�����ɹ�'}]"
	end if
	response.end
End If %>
<script language="javascript" runat="server">
function decodeText(str){
    return (str == null ? "" : decodeURIComponent(str));
}
</script>
<!--#include file="uc/connfree.asp"-->