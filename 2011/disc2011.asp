<!--#include file="uc/conn.asp"-->
<style>body{font-size:12px;}</style>
<div style="background-color:#EEEEFF"><strong>������Ϣ���麣����Ͷ����ҵЭ����վ������</strong></div>
<%
'����2011�������ʾЭ�ᶯ̬

Function FormatArtTitle(title, length)
	If Len(title) > length Then 
		FormatArtTitle = Left(title, length) & "..."
	Else 
		FormatArtTitle = title
	End If 
End Function

sql="select top 2 * from article where art_info_id=87 order by flag asc, art_time desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <div style="margin-top:3px;"><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>" target="_blank"><span><%=FormatArtTitle(rs("art_title"), 40)%><span></a>
		<span>[<%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%>]</span>
		</div>
<% rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close


sql="select top 2 * from article where art_info_id=83 order by flag asc, art_time desc"
rs.open sql, conn, 1, 1
Do While Not rs.eof
%>
        <div style="margin-top:3px;"><a href="article.asp?id=<%=rs("art_id")%>" title="<%=rs("art_title")%>" target="_blank"><span><%=FormatArtTitle(rs("art_title"), 40)%><span></a>
		<span>[<%=(Year(rs("art_time")) & "-" & Right("0" & Month(rs("art_time")), 2) & "-" & Right("0" & Day(rs("art_time")), 2))%>]</span>
		</div>
<% rs.movenext
	If rs.eof Then Exit Do
Loop
rs.close

%>
<!--#include file="uc/connfree.asp"-->