use master;
go

if exists (select name from dbo.sysdatabases where name = 'XML_Practice')
	drop database XML_Practice;
go

create database XML_Practice
on
(
	name = XML_Practice_data,
	filename = 'e:\sqlserver\projectsv13\databases\xml_practice.mdf',
	size = 5MB,
	filegrowth = 1MB
)
log on
(
	name = XML_Practice_log,
	filename = 'e:\sqlserver\projectsv13\logs\xml_practice_log.ldf',
	size = 10MB,
	filegrowth = 10MB
);
go