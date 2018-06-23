use XML_Practice;
go

create table dbo.FlexDefinitions
(
	id int not null identity(1,1) primary key,
	setname nvarchar(25),
	setcolumns xml
);

insert into dbo.FlexDefinitions (setname, setcolumns)
	values (N'set 1', '<flexsetdef><column>field 1</column><column>field 2</column></flexsetdef>');
go