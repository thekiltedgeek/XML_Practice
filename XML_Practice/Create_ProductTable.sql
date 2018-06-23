use XML_Practice;
go

drop table if exists dbo.Products;

create table dbo.Products
(
	productid int not null identity(1,1)
	,productname nvarchar(25) not null
	,productflexdata xml null
	,constraint PK_Products primary key (productid)
);

declare @product1flexdata xml, @product2flexdata xml;

set @product1flexdata =
'<flexset name="set 1">
	<flexfield name="field 1">Product 1, field 1 data</flexfield>
	<flexfield name="field 2">Product 1, field 2 data</flexfield>
</flexset>'
;

set @product2flexdata =
'<flexset name="set 1">
	<flexfield name="field 1">Product 2, field 1 data</flexfield>
	<flexfield name="field 2">Product 2, field 2 data</flexfield>
</flexset>'
;

insert into dbo.Products (productname, productflexdata)
	values ('Product 1',@product1flexdata), ('Product 2', @product2flexdata), ('Product 3', null);