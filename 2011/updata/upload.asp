<%OPTION EXPLICIT%>
<%Server.ScriptTimeOut=5000
%>
<!--#include file="../uc/upload_wj.asp"-->
<%
dim upload, file, formName, path, titles, i, title, re, randomfilename
Dim Jpeg, iWidth, iHeight, iiWidth, iiHeight
Set Jpeg = Server.CreateObject("Persits.Jpeg")

set upload = new upload_file

'titles = upload.form("title")
'if titles = empty then
'	titles = Array("")
'else
'	titles = Split(titles, ",")
'end if

Set re = New RegExp
re.Pattern = "[\\/:*?""<>|]"
re.Global = True

i = 0

'��������ļ���
Randomize
randomfilename = year(now) & SetLength(Month(now), 2) & SetLength(Day(now), 2) & SetLength(Hour(now), 2) & SetLength(Minute(now), 2) & SetLength(Second(now), 2) & SetLength(Int(1000*Rnd+1), 3)

for each formName in upload.file
	set file = upload.file(formName)
	if file.FileSize>0 then

		'title = Trim(titles(i))
		'if title = empty then
		'	title = file.FileName
		'else
		'	title = re.Replace(title, "") & "." & file.FileExt
		'end if
		
		path = "/plus/image/" & randomfilename & "." & Right(file.FileName,3)
		'path = "./" & randomfilename & "." & Right(file.FileName,3)
		file.SaveToFile Server.mappath(path)

		Jpeg.Open Server.MapPath(path)
		
		'��ˮӡ
		If CStr(request.querystring("watermark") = "true") Then 
			' �������ˮӡ
			'Jpeg.Canvas.Font.Color = &HFF0000' ��ɫ
			'Jpeg.Canvas.Font.Family = "����"
			'Jpeg.Canvas.Font.Bold = True  
			'Jpeg.Canvas.Print 10, 10, "zhaefi.org"
			'ͼƬˮӡ
			 Jpeg.Interpolation=1  
			 Jpeg.Quality=100  
			 iWidth=Jpeg.OriginalWidth
			 iHeight=Jpeg.OriginalHeight  
			 iiwidth=182 'ˮӡͼƬ�Ŀ��
			 iiHeight=26 'ˮӡͼƬ�ĸ߶�
			 Jpeg.Canvas.DrawPng 5, iHeight-iiHeight-5,Server.MapPath("../static/images/watermark.png")
		End If

		' �����ļ�
		Jpeg.Save Server.MapPath(path)


		Response.Write("{ path: """ & path & """, name: """ & title & """ }")
		
		i = i + 1
	end if
next

set file = nothing
set upload = Nothing
Set Jpeg = Nothing


'�ַ���ǰ��0
Function SetLength(p, i)
	If Len(p) = 1 Then
		SetLength = String(i-1, "0") & p
	Else
		SetLength = p
	End If
End Function
%>