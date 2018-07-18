use XML_Practice;
go

declare @jsontable table
	(
		productid int
		,field1 nvarchar(50)
		,field2 nvarchar(50)
	);

insert into @jsontable (productid,field1,field2)
values(1,'Product 1, field 1 data','Product 1, field 2 data'),
	(2,'Product 2, field 1 data','Product 2, field 2 data');

update p
	set
		p.jsonflexdata =
		(select
			field1 as "field 1"
			,field2 as "field 2"
		from @jsontable
		where productid = p.productid
		for json path,root('set1'))
from dbo.Products p
inner join @jsontable j on p.productid = j.productid;

select * from dbo.Products;