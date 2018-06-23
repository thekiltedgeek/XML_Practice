use XML_Practice;
go

declare @flexdata xml;

set @flexdata =
'<flexset name="set 1">
	<flexfield>
		<name>field 1</name>
		<value>field 1 data</value>
	</flexfield>
	<flexfield>
		<name>field 2</name>
		<value>field 2 data</value>
	</flexfield>
</flexset>'
;

select
	f.value('./name[1]','nvarchar(128)') as cols
	,f.value('./value[1]','nvarchar(100)') as [data]
from @flexdata.nodes('/flexset/flexfield') as fd(f);