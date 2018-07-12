use XML_Practice;
go

select
	p.productid as [ID]
	,p.productname as [Name]
from dbo.Products as p
for json path