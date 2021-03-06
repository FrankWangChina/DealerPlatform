drop Table [dbo].[ProductSales]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSales](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SysNo] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StockNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NULL,
	[SalePrice] [float] NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboProductSales]', 'P') > 0
    drop proc [sp_MSins_dboProductSales]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboProductSales'
go
create procedure [sp_MSins_dboProductSales]
    @c1 int,
    @c2 varchar(100),
    @c3 varchar(40),
    @c4 varchar(40),
    @c5 float
as
begin  
	insert into [dbo].[ProductSales](
		[Id],
		[SysNo],
		[ProductNo],
		[StockNo],
		[SalePrice]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5	) 
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
    @object_name = N'sp_MSins_dboProductSales',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ProductSales'
go
if object_id(N'[dbo].[sp_MSins_dboProductSales_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboProductSales_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboProductSales_msrepl_ccs]
		@c1 int,
		@c2 varchar(100),
		@c3 varchar(40),
		@c4 varchar(40),
		@c5 float
as
begin
if exists (select * 
             from [dbo].[ProductSales]
            where [SysNo] = @c2
              and [ProductNo] = @c3)
begin
update [dbo].[ProductSales] set
		[StockNo] = @c4,
		[SalePrice] = @c5
where [SysNo] = @c2
  and [ProductNo] = @c3
end
else
begin
	insert into [dbo].[ProductSales](
		[Id],
		[SysNo],
		[ProductNo],
		[StockNo],
		[SalePrice]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5	) 
end
end
go
if object_id(N'[sp_MSupd_dboProductSales]', 'P') > 0
    drop proc [sp_MSupd_dboProductSales]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboProductSales'
go
create procedure [sp_MSupd_dboProductSales]
		@c1 int = NULL,
		@c2 varchar(100) = NULL,
		@c3 varchar(40) = NULL,
		@c4 varchar(40) = NULL,
		@c5 float = NULL,
		@pkc1 varchar(100) = NULL,
		@pkc2 varchar(40) = NULL,
		@bitmap binary(1)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2) or
 (substring(@bitmap,1,1) & 4 = 4)
begin 
update [dbo].[ProductSales] set
		[SysNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SysNo] end,
		[ProductNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ProductNo] end,
		[StockNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [StockNo] end,
		[SalePrice] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [SalePrice] end
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[ProductSales] set
		[StockNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [StockNo] end,
		[SalePrice] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [SalePrice] end
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
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
    @object_name = N'sp_MSupd_dboProductSales',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ProductSales'
go
if object_id(N'[sp_MSdel_dboProductSales]', 'P') > 0
    drop proc [sp_MSdel_dboProductSales]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboProductSales'
go
create procedure [sp_MSdel_dboProductSales]
		@pkc1 varchar(100),
		@pkc2 varchar(40)
as
begin  
	delete [dbo].[ProductSales]
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
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
    @object_name = N'sp_MSdel_dboProductSales',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ProductSales'
go
if object_id(N'[dbo].[sp_MSdel_dboProductSales_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboProductSales_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboProductSales_msrepl_ccs]
		@pkc1 varchar(100),
		@pkc2 varchar(40)
as
begin  
	delete [dbo].[ProductSales]
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
end  
go
