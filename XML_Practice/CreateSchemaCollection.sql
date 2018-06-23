use FileUploader;
go

declare @mySchemaCollection nvarchar(max) = N'';

set @mySchemaCollection +=
(
	select top (0) --use this for tables containing data
	*
	from sbs_maintdtl
	for xml auto, elements, xmlschema('sbs_maintdtl')
);

set @mySchemaCollection +=
(
	select top (0)
	*
	from sbs_curr_qty
	for xml auto, elements, xmlschema('sbs_curr_qty')
);

select cast(@mySchemaCollection as XML);
create xml schema collection dbo.AuditSchemaCollection as @mySchemaCollection;
go