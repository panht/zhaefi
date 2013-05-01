<div class="clear"></div>
<div class="ma">
 <table cellspacing="0" cellpadding="0" width="100%" class="c tbottom" border="0">
  <tbody>
  <tr>
    <td align="center">　</td></tr>
  <tr>
    <td align="center" class="c">
		<div class="w980 c ma c0 fwn">
<%
sql="select * from article where art_id=3803"
rs.open sql, conn, 1, 1
If Not rs.eof Then 
	response.write Replace(Replace(replace(rs("art_content"),chr(13),"<br/>"), "&quot;", chr(34)), "&#39;", Chr(39))
End If
rs.close
%>	
	</div>
	</td></tr>

  <tr><td align="center">　</td></tr>
  <tr>
    <td align="center c0"><span class="c0 fwn">版权所有：珠海外商投资企业协会</span><br><span class="content2 c0 fwn">Copyright  &copy; <a href="mailto:contact@zhaefi.org">zhaefi</a> All rights reserved <br><a href="http://www.miibeian.gov.cn/" target="_blank">粤ICP备05056929号</a></span></td></tr>
	<tr><td align="center">
		<script type="text/javascript">
		var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
		document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F97b4edad550bf06815db963b4b9ce31e' type='text/javascript'%3E%3C/script%3E"));
		</script>
	</td></tr>
	</tbody></table>	
</div>