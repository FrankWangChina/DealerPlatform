drop Table [dbo].[SaleOrderDetails]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleOrderDetails](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SaleOrderGuid] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[SaleOrderNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductName] [varchar](40) COLLATE Chinese_PRC_CI_AS NULL,
	[ProductPhotoUrl] [varchar](200) COLLATE Chinese_PRC_CI_AS NULL,
	[CustomerNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InputDate] [datetime] NOT NULL,
	[OrderNum] [int] NOT NULL,
	[BasePrice] [float] NOT NULL,
	[DiffPrice] [float] NOT NULL,
	[SalePrice] [float] NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboSaleOrderDetails]', 'P') > 0
    drop proc [sp_MSins_dboSaleOrderDetails]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboSaleOrderDetails'
go
create procedure [sp_MSins_dboSaleOrderDetails]
    @c1 int,
    @c2 varchar(40),
    @c3 varchar(40),
    @c4 varchar(40),
    @c5 varchar(40),
    @c6 varchar(200),
    @c7 varchar(40),
    @c8 datetime,
    @c9 int,
    @c10 float,
    @c11 float,
    @c12 float
as
begin  
	insert into [dbo].[SaleOrderDetails](
		[Id],
		[SaleOrderGuid],
		[SaleOrderNo],
		[ProductNo],
		[ProductName],
		[ProductPhotoUrl],
		[CustomerNo],
		[InputDate],
		[OrderNum],
		[BasePrice],
		[DiffPrice],
		[SalePrice]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6,
    @c7,
    @c8,
    @c9,
    @c10,
    @c11,
    @c12	) 
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
    @object_name = N'sp_MSins_dboSaleOrderDetails',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderDetails'
go
if object_id(N'[dbo].[sp_MSins_dboSaleOrderDetails_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboSaleOrderDetails_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboSaleOrderDetails_msrepl_ccs]
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(40),
		@c4 varchar(40),
		@c5 varchar(40),
		@c6 varchar(200),
		@c7 varchar(40),
		@c8 datetime,
		@c9 int,
		@c10 float,
		@c11 float,
		@c12 float
as
begin
if exists (select * 
             from [dbo].[SaleOrderDetails]
            where [SaleOrderGuid] = @c2)
begin
update [dbo].[SaleOrderDetails] set
		[SaleOrderNo] = @c3,
		[ProductNo] = @c4,
		[ProductName] = @c5,
		[ProductPhotoUrl] = @c6,
		[CustomerNo] = @c7,
		[InputDate] = @c8,
		[OrderNum] = @c9,
		[BasePrice] = @c10,
		[DiffPrice] = @c11,
		[SalePrice] = @c12
where [SaleOrderGuid] = @c2
end
else
begin
	insert into [dbo].[SaleOrderDetails](
		[Id],
		[SaleOrderGuid],
		[SaleOrderNo],
		[ProductNo],
		[ProductName],
		[ProductPhotoUrl],
		[CustomerNo],
		[InputDate],
		[OrderNum],
		[BasePrice],
		[DiffPrice],
		[SalePrice]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6,
    @c7,
    @c8,
    @c9,
    @c10,
    @c11,
    @c12	) 
end
end
go
if object_id(N'[sp_MSupd_dboSaleOrderDetails]', 'P') > 0
    drop proc [sp_MSupd_dboSaleOrderDetails]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboSaleOrderDetails'
go
create procedure [sp_MSupd_dboSaleOrderDetails]
		@c1 int = NULL,
		@c2 varchar(40) = NULL,
		@c3 varchar(40) = NULL,
		@c4 varchar(40) = NULL,
		@c5 varchar(40) = NULL,
		@c6 varchar(200) = NULL,
		@c7 varchar(40) = NULL,
		@c8 datetime = NULL,
		@c9 int = NULL,
		@c10 float = NULL,
		@c11 float = NULL,
		@c12 float = NULL,
		@pkc1 varchar(40) = NULL,
		@bitmap binary(2)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2)
begin 
update [dbo].[SaleOrderDetails] set
		[SaleOrderGuid] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SaleOrderGuid] end,
		[SaleOrderNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [SaleOrderNo] end,
		[ProductNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ProductNo] end,
		[ProductName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ProductName] end,
		[ProductPhotoUrl] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [ProductPhotoUrl] end,
		[CustomerNo] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [CustomerNo] end,
		[InputDate] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [InputDate] end,
		[OrderNum] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [OrderNum] end,
		[BasePrice] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [BasePrice] end,
		[DiffPrice] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [DiffPrice] end,
		[SalePrice] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [SalePrice] end
where [SaleOrderGuid] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[SaleOrderDetails] set
		[SaleOrderNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [SaleOrderNo] end,
		[ProductNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ProductNo] end,
		[ProductName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ProductName] end,
		[ProductPhotoUrl] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [ProductPhotoUrl] end,
		[CustomerNo] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [CustomerNo] end,
		[InputDate] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [InputDate] end,
		[OrderNum] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [OrderNum] end,
		[BasePrice] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [BasePrice] end,
		[DiffPrice] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [DiffPrice] end,
		[SalePrice] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [SalePrice] end
where [SaleOrderGuid] = @pkc1
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
    @object_name = N'sp_MSupd_dboSaleOrderDetails',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderDetails'
go
if object_id(N'[sp_MSdel_dboSaleOrderDetails]', 'P') > 0
    drop proc [sp_MSdel_dboSaleOrderDetails]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboSaleOrderDetails'
go
create procedure [sp_MSdel_dboSaleOrderDetails]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[SaleOrderDetails]
where [SaleOrderGuid] = @pkc1
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
    @object_name = N'sp_MSdel_dboSaleOrderDetails',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderDetails'
go
if object_id(N'[dbo].[sp_MSdel_dboSaleOrderDetails_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboSaleOrderDetails_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboSaleOrderDetails_msrepl_ccs]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[SaleOrderDetails]
where [SaleOrderGuid] = @pkc1
end  
go
