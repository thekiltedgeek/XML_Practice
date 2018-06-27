use XML_Practice;
go

declare @mytable table
(
	columnnames nvarchar(25) null
);

insert into @mytable (columnnames) values ('field 1'), ('field 2'), ('field 3');

select
	columnnames as [column]
from @mytable for xml path(''), root('flexsetdef');