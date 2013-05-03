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
	
	' 获取讲座信息
	sql = "select * from lecture where LectureID = " & LectureID
	rs.open sql, conn, 1, 1
	if not rs.eof then
		lectureSubject = rs("subject")
		PriceMemberCard = rs("PriceMemberCard")
		PriceCard = rs("PriceCard")
	end if
	rs.close
		
	'如果使用学习卡报名
	if feetype = 3 then
		'卡号密码是否正确
		sql = "select * from trainingcard where cardno = '" & cardno & "' and password = '" & cardpassword & "'"
		rs.open sql, conn, 1, 1
		if rs.eof then
			response.write "[{'code': -1, 'message':'卡号或密码错误，请重新输入'}]"
			response.end
		else
			cardtype = rs("cardtype")
			balance = rs("balance")
			TrainingCardID = rs("ID")
		end if
		rs.close
		
		' 获得讲座费用
		if cardtype = 1 then
			' 如果是会员卡
			Amount = PriceMemberCard
		elseif cardtype = 2 then
			'如果是非会员卡
			Amount = PriceCard
		end if
		
		'卡上余额够不够
		if balance - Amount < 0 then
			response.write "[{'code': -2, 'message':'卡上金额不足，请先充值，或者选用其它方式报名'}]"
			response.end
		end if
	end if
	
	'保存
	FlagFree=decodeText(request("FlagFree"))
	LectureID=decodeText(request("LectureID"))
	company=decodeText(request("company"))
	applyUsername=decodeText(request("applyUsername"))
	tel=decodeText(request("tel"))
	fax=decodeText(request("fax"))
	cellphone=decodeText(request("cellphone"))
	title=decodeText(request("title"))
	email=decodeText(request("email"))
	Remarks=decodeText(request("Remarks"))
	
	' 如果使用学习卡报名
	if feetype = 3 then
		RecordType = 2 '固定为扣款
		RecordTime = date
		Remark = applyQuantity & "人报名参加《" & lectureSubject & "》"
		createby = company
		
		'写入学习卡记录表
		sql="insert into trainingcardrecord (TrainingCardID, RecordType, CardNo, Amount, RecordTime, Remark, createby) values("&TrainingCardID&", "&RecordType&", '"&cardno&"', "&Amount&", #"&RecordTime&"#, '"&Remark&"', '"&createby&"')"
		conn.execute(sql)
		
		'学习卡扣款
		sql = "update trainingcard set balance = balance - " & amount & " where id = " & TrainingCardID
		conn.execute(sql)
	end if
	
	' 写入报名表
	if feetype = 1 then
		feetypetext = "现场"
	elseif feetype = 2 then
		feetypetext = "提前"
	elseif feetype = 3 then
		feetypetext = "学习卡"
	end if
	sql = "insert into LectureSignUp(LectureID, company, username, feetype, title, cellphone, tel, fax, Remarks, email) values(" & LectureID & ", '" & company & "', '" & applyUsername & "', '" & feetypetext & "', '" & title & "', '" & cellphone & "', '" & tel & "', '" & fax & "', '" & Remarks & "', '" & Email & "')"
	conn.execute(sql)
	
	' 返回报名成功
	if feetype = 3 then
		response.write "[{'code': 1, 'message':'报名成功，学习卡余额为" & balance - amount & "'}]"
	else
		response.write "[{'code': 1, 'message':'报名成功'}]"
	end if
	response.end
End If %>
<script language="javascript" runat="server">
function decodeText(str){
    return (str == null ? "" : decodeURIComponent(str));
}
</script>
<!--#include file="uc/connfree.asp"-->