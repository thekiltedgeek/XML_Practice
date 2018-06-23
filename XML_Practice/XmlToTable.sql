use FileUploader;
go

--SELECT
--	ar.AuditRecordID
--	,d.value('Table [1]','sysname') as TableName
--	,d.value('UpdatedBy [1]','nvarchar(50)') as UpdatedBy
--	,d.value('NewData[1]/row[1]','nvarchar(max)') as clientid
--	,d.value('NewData[1]/row[1]/@rec_no[1]','nvarchar(7)') as receiptnumber
--	,d.value('NewData[1]/row[1]/@client_recipt[1]','nvarchar(7)') as ctrlnum
--	,coalesce(d.value('NewData[1]/row[1]/@loc_to[1]','nvarchar(7)'),N'N/A') as locto
--FROM dbo.AuditRecords ar cross apply ar.AuditData.nodes('AuditData') as a(d);

SELECT
	d.value('Table [1]','sysname') as TableName
	,d.value('UpdatedBy [1]','nvarchar(50)') as UpdatedBy
	,d.query('for $i in ./NewData/row
			return
			<AuditElement>
				<clientid>{data($i/@client_id)}</clientid>
				<recno>{data($i/@rec_no)}</recno>
				<ctrlnum>{data($i/@client_recipt)}</ctrlnum>
			</AuditElement>') as newrowdata
	,a.d.query('./PrevData/row') as olddatarow
FROM dbo.AuditRecords ar cross apply ar.AuditData.nodes('AuditData') as a(d);
