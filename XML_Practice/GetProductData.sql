use XML_Practice;
go

declare
	@columns nvarchar(max)
	,@sql nvarchar(max)
	;

set @columns = '';
select @columns += N', ' + quotename(colname)
from
	(
		select
			f.d.value('./@name','nvarchar(128)') as colname
		from dbo.Products as p cross apply p.productflexdata.nodes('/flexset/flexfield') as f(d)
		where p.productflexdata is not null
	) as cols;

print @columns;