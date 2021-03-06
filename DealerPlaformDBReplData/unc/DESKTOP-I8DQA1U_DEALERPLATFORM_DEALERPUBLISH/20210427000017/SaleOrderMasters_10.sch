drop Table [dbo].[SaleOrderMasters]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleOrderMasters](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SaleOrderNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CustomerNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InvoiceNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InputDate] [datetime] NOT NULL,
	[StockNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[EditUserNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[DeliveryDate] [datetime] NOT NULL,
	[Remark] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboSaleOrderMasters]', 'P') > 0
    drop proc [sp_MSins_dboSaleOrderMasters]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboSaleOrderMasters'
go
create procedure [sp_MSins_dboSaleOrderMasters]
    @c1 int,
    @c2 varchar(40),
    @c3 varchar(40),
    @c4 varchar(40),
    @c5 datetime,
    @c6 varchar(40),
    @c7 varchar(40),
    @c8 datetime,
    @c9 varchar(50)
as
begin  
	insert into [dbo].[SaleOrderMasters](
		[Id],
		[SaleOrderNo],
		[CustomerNo],
		[InvoiceNo],
		[InputDate],
		[StockNo],
		[EditUserNo],
		[DeliveryDate],
		[Remark]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6,
    @c7,
    @c8,
    @c9	) 
end  
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSins_dboSaleOrderMasters',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderMasters'
go
if object_id(N'[dbo].[sp_MSins_dboSaleOrderMasters_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboSaleOrderMasters_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboSaleOrderMasters_msrepl_ccs]
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(40),
		@c4 varchar(40),
		@c5 datetime,
		@c6 varchar(40),
		@c7 varchar(40),
		@c8 datetime,
		@c9 varchar(50)
as
begin
if exists (select * 
             from [dbo].[SaleOrderMasters]
            where [SaleOrderNo] = @c2)
begin
update [dbo].[SaleOrderMasters] set
		[CustomerNo] = @c3,
		[InvoiceNo] = @c4,
		[InputDate] = @c5,
		[StockNo] = @c6,
		[EditUserNo] = @c7,
		[DeliveryDate] = @c8,
		[Remark] = @c9
where [SaleOrderNo] = @c2
end
else
begin
	insert into [dbo].[SaleOrderMasters](
		[Id],
		[SaleOrderNo],
		[CustomerNo],
		[InvoiceNo],
		[InputDate],
		[StockNo],
		[EditUserNo],
		[DeliveryDate],
		[Remark]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6,
    @c7,
    @c8,
    @c9	) 
end
end
go
if object_id(N'[sp_MSupd_dboSaleOrderMasters]', 'P') > 0
    drop proc [sp_MSupd_dboSaleOrderMasters]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboSaleOrderMasters'
go
create procedure [sp_MSupd_dboSaleOrderMasters]
		@c1 int = NULL,
		@c2 varchar(40) = NULL,
		@c3 varchar(40) = NULL,
		@c4 varchar(40) = NULL,
		@c5 datetime = NULL,
		@c6 varchar(40) = NULL,
		@c7 varchar(40) = NULL,
		@c8 datetime = NULL,
		@c9 varchar(50) = NULL,
		@pkc1 varchar(40) = NULL,
		@bitmap binary(2)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2)
begin 
update [dbo].[SaleOrderMasters] set
		[SaleOrderNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SaleOrderNo] end,
		[CustomerNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CustomerNo] end,
		[InvoiceNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [InvoiceNo] end,
		[InputDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [InputDate] end,
		[StockNo] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [StockNo] end,
		[EditUserNo] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [EditUserNo] end,
		[DeliveryDate] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [DeliveryDate] end,
		[Remark] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [Remark] end
where [SaleOrderNo] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[SaleOrderMasters] set
		[CustomerNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CustomerNo] end,
		[InvoiceNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [InvoiceNo] end,
		[InputDate] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [InputDate] end,
		[StockNo] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [StockNo] end,
		[EditUserNo] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [EditUserNo] end,
		[DeliveryDate] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [DeliveryDate] end,
		[Remark] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [Remark] end
where [SaleOrderNo] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end 
end 
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSupd_dboSaleOrderMasters',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderMasters'
go
if object_id(N'[sp_MSdel_dboSaleOrderMasters]', 'P') > 0
    drop proc [sp_MSdel_dboSaleOrderMasters]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboSaleOrderMasters'
go
create procedure [sp_MSdel_dboSaleOrderMasters]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[SaleOrderMasters]
where [SaleOrderNo] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
go
if columnproperty(object_id(N'dbo.MSreplication_objects'), N'article', 'AllowsNull') is not null
exec sp_executesql 
    @statement = 
        N'insert dbo.MSreplication_objects (object_name, publisher, publisher_db, publication, article, object_type) 
            values 
        (@object_name, @publisher, @publisher_db, @publication, @article, ''P'')',
    @parameters = 
        N'@object_name sysname, @publisher sysname, @publisher_db sysname, @publication sysname, @article sysname',
    @object_name = N'sp_MSdel_dboSaleOrderMasters',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderMasters'
go
if object_id(N'[dbo].[sp_MSdel_dboSaleOrderMasters_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboSaleOrderMasters_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboSaleOrderMasters_msrepl_ccs]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[SaleOrderMasters]
where [SaleOrderNo] = @pkc1
end  
go
