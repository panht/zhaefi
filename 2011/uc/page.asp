<%
page=request("page") 
if page="" then page=1 
page=cdbl(page)

rowcount=request("rowcount")
if rowcount="" then rowcount=20
rowcount1=rowcount

rcount=rs.recordcount 
if rcount mod rowcount=0 then 
   pagecount=rcount/rowcount 
else 
  pagecount=fix(rcount/rowcount+1) 
end if 

if page>pagecount then page=pagecount 
if page<1 then page=1
if rcount=0 then page=0
%>