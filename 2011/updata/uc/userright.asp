<%

If LCase(session("AdminUsername")) <> "zhaefi" then
	'sql="select * from adminmodule where username='" & session("AdminUsername") & "' and modulename='" & strModuleName & "'"
	sql="select * from admin where username='" & session("AdminUsername") & "' and user_right like '%" & strModuleName & "%'"
	'response.write sql
	rs.open sql, conn, 1, 1
	If rs.eof Then 
		rs.close
		conn.close
		response.redirect "./?c=q"
	End If
	rs.close
End If
%>