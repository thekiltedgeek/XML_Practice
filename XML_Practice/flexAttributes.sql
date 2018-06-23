use XML_Practice;
go

select
	d.value('./flexfield[1]','nvarchar(50)')
	,d.value('./flexfield[2]','nvarchar(50)')
from dbo.Products p cross apply p.productflexdata.nodes('/flexset') as fs(d)
where p.productflexdata is not null;