drop Table [dbo].[ProductSaleAreaDiffs]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSaleAreaDiffs](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SysNo] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductNo] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StockNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[AreaNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[FirstAreaNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[DiffPrice] [float] NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboProductSaleAreaDiffs]', 'P') > 0
    drop proc [sp_MSins_dboProductSaleAreaDiffs]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboProductSaleAreaDiffs'
go
create procedure [sp_MSins_dboProductSaleAreaDiffs]
    @c1 int,
    @c2 varchar(100),
    @c3 varchar(100),
    @c4 varchar(40),
    @c5 varchar(40),
    @c6 varchar(40),
    @c7 float
as
begin  
	insert into [dbo].[ProductSaleAreaDiffs](
		[Id],
		[SysNo],
		[ProductNo],
		[StockNo],
		[AreaNo],
		[FirstAreaNo],
		[DiffPrice]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6,
    @c7	) 
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
    @object_name = N'sp_MSins_dboProductSaleAreaDiffs',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ProductSaleAreaDiffs'
go
if object_id(N'[dbo].[sp_MSins_dboProductSaleAreaDiffs_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboProductSaleAreaDiffs_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboProductSaleAreaDiffs_msrepl_ccs]
		@c1 int,
		@c2 varchar(100),
		@c3 varchar(100),
		@c4 varchar(40),
		@c5 varchar(40),
		@c6 varchar(40),
		@c7 float
as
begin
if exists (select * 
             from [dbo].[ProductSaleAreaDiffs]
            where [SysNo] = @c2
              and [ProductNo] = @c3
              and [StockNo] = @c4
              and [AreaNo] = @c5)
begin
update [dbo].[ProductSaleAreaDiffs] set
		[FirstAreaNo] = @c6,
		[DiffPrice] = @c7
where [SysNo] = @c2
  and [ProductNo] = @c3
  and [StockNo] = @c4
  and [AreaNo] = @c5
end
else
begin
	insert into [dbo].[ProductSaleAreaDiffs](
		[Id],
		[SysNo],
		[ProductNo],
		[StockNo],
		[AreaNo],
		[FirstAreaNo],
		[DiffPrice]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6,
    @c7	) 
end
end
go
if object_id(N'[sp_MSupd_dboProductSaleAreaDiffs]', 'P') > 0
    drop proc [sp_MSupd_dboProductSaleAreaDiffs]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboProductSaleAreaDiffs'
go
create procedure [sp_MSupd_dboProductSaleAreaDiffs]
		@c1 int = NULL,
		@c2 varchar(100) = NULL,
		@c3 varchar(100) = NULL,
		@c4 varchar(40) = NULL,
		@c5 varchar(40) = NULL,
		@c6 varchar(40) = NULL,
		@c7 float = NULL,
		@pkc1 varchar(100) = NULL,
		@pkc2 varchar(100) = NULL,
		@pkc3 varchar(40) = NULL,
		@pkc4 varchar(40) = NULL,
		@bitmap binary(1)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2) or
 (substring(@bitmap,1,1) & 4 = 4) or
 (substring(@bitmap,1,1) & 8 = 8) or
 (substring(@bitmap,1,1) & 16 = 16)
begin 
update [dbo].[ProductSaleAreaDiffs] set
		[SysNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SysNo] end,
		[ProductNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ProductNo] end,
		[StockNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [StockNo] end,
		[AreaNo] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [AreaNo] end,
		[FirstAreaNo] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [FirstAreaNo] end,
		[DiffPrice] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [DiffPrice] end
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
  and [StockNo] = @pkc3
  and [AreaNo] = @pkc4
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[ProductSaleAreaDiffs] set
		[FirstAreaNo] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [FirstAreaNo] end,
		[DiffPrice] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [DiffPrice] end
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
  and [StockNo] = @pkc3
  and [AreaNo] = @pkc4
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
    @object_name = N'sp_MSupd_dboProductSaleAreaDiffs',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ProductSaleAreaDiffs'
go
if object_id(N'[sp_MSdel_dboProductSaleAreaDiffs]', 'P') > 0
    drop proc [sp_MSdel_dboProductSaleAreaDiffs]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboProductSaleAreaDiffs'
go
create procedure [sp_MSdel_dboProductSaleAreaDiffs]
		@pkc1 varchar(100),
		@pkc2 varchar(100),
		@pkc3 varchar(40),
		@pkc4 varchar(40)
as
begin  
	delete [dbo].[ProductSaleAreaDiffs]
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
  and [StockNo] = @pkc3
  and [AreaNo] = @pkc4
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
    @object_name = N'sp_MSdel_dboProductSaleAreaDiffs',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ProductSaleAreaDiffs'
go
if object_id(N'[dbo].[sp_MSdel_dboProductSaleAreaDiffs_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboProductSaleAreaDiffs_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboProductSaleAreaDiffs_msrepl_ccs]
		@pkc1 varchar(100),
		@pkc2 varchar(100),
		@pkc3 varchar(40),
		@pkc4 varchar(40)
as
begin  
	delete [dbo].[ProductSaleAreaDiffs]
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
  and [StockNo] = @pkc3
  and [AreaNo] = @pkc4
end  
go
