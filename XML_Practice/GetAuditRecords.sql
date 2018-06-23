use FileUploader;
go

SELECT
	ar.AuditRecordID
	,ar.AuditDate
	,ar.AuditTime
	,d.value('Table [1]','sysname') as TableName
	,d.value('UpdatedBy [1]','nvarchar(50)') as UpdatedBy
	,ar.AuditData
FROM dbo.AuditRecords ar cross apply ar.AuditData.nodes('AuditData') as a(d);