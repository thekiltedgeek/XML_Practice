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
			f.d.value('.','nvarchar(128)') as colname
		from dbo.FlexDefinitions as fsd cross apply fsd.setcolumns.nodes('/flexsetdef/column') as f(d)
	) as cols;

print @columns;

set @sql = N'
with flexpivot
as
(
	select
		p.productid
		,p.productname
		,f.d.value(''./@name'',''nvarchar(128)'') as colname
		,f.d.value(''.'',''nvarchar(100)'') as coldata
	from dbo.Products as p cross apply p.productflexdata.nodes(''/flexset/flexfield'') as f(d)
	where p.productflexdata is not null
)

select productid, productname' + @columns +
'from flexpivot
	pivot (max(coldata) for colname in (' + stuff(@columns,1,2,'') + ')) as fp;'

exec sp_executesql @stmt = @sql;