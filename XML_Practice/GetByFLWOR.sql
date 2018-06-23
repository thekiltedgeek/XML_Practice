use FileUploader;
go

with XMLRows as
(
select
	ar.AuditData.query
		(
			'for $i in AuditData
			let $t := $i/Table
			let $u := $i/UpdatedBy
			let $o := $i/UpdatedDatetime
			for $j in $i/NewData/row
			return
			<AuditRows>
				{$t}
				{$u}
				{$o}
				<clientid>{data($j/@client_id)}</clientid>
				<recno>{data($j/@rec_no)}</recno>
				<ctrlnumber>{data($j/@client_recipt)}</ctrlnumber>
				{$j}
			</AuditRows>'
		) as newrows
from dbo.AuditRecords ar
)

select
	d.value('Table [1]', 'sysname') as TableName
	,d.value('UpdatedBy [1]', 'nvarchar(25)') as UpdatedBy
	,d.value('UpdatedDatetime [1]', 'datetime') as UpdatedOn
	,d.value('clientid [1]', 'char(7)') as ClientId
	,d.value('recno [1]', 'char(7)') as RecNo
	,d.value('ctrlnumber [1]', 'char(7)') as CtrlNumber
	,d.query('./row') as newrowdata
from XMLRows x cross apply x.newrows.nodes('AuditRows') as a(d);
