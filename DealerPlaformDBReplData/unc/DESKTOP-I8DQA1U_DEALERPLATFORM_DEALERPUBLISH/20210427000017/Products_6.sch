drop Table [dbo].[Products]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SysNo] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductNo] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductName] [varchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[TypeNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[TypeName] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductPP] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductXH] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductCZ] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductHB] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductHD] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductGY] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductHS] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductMC] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductDJ] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductCD] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductGG] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductYS] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[UnitNo] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[UnitName] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductNote] [varchar](500) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductBZGG] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[BelongTypeNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[BelongTypeName] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboProducts]', 'P') > 0
    drop proc [sp_MSins_dboProducts]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboProducts'
go
create procedure [sp_MSins_dboProducts]
    @c1 int,
    @c2 varchar(100),
    @c3 varchar(100),
    @c4 varchar(200),
    @c5 varchar(40),
    @c6 varchar(40),
    @c7 varchar(100),
    @c8 varchar(100),
    @c9 varchar(100),
    @c10 varchar(100),
    @c11 varchar(100),
    @c12 varchar(100),
    @c13 varchar(100),
    @c14 varchar(100),
    @c15 varchar(100),
    @c16 varchar(100),
    @c17 varchar(100),
    @c18 varchar(100),
    @c19 varchar(100),
    @c20 varchar(100),
    @c21 varchar(500),
    @c22 varchar(100),
    @c23 varchar(40),
    @c24 varchar(100)
as
begin  
	insert into [dbo].[Products](
		[Id],
		[SysNo],
		[ProductNo],
		[ProductName],
		[TypeNo],
		[TypeName],
		[ProductPP],
		[ProductXH],
		[ProductCZ],
		[ProductHB],
		[ProductHD],
		[ProductGY],
		[ProductHS],
		[ProductMC],
		[ProductDJ],
		[ProductCD],
		[ProductGG],
		[ProductYS],
		[UnitNo],
		[UnitName],
		[ProductNote],
		[ProductBZGG],
		[BelongTypeNo],
		[BelongTypeName]
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
    @c12,
    @c13,
    @c14,
    @c15,
    @c16,
    @c17,
    @c18,
    @c19,
    @c20,
    @c21,
    @c22,
    @c23,
    @c24	) 
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
    @object_name = N'sp_MSins_dboProducts',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Products'
go
if object_id(N'[dbo].[sp_MSins_dboProducts_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboProducts_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboProducts_msrepl_ccs]
		@c1 int,
		@c2 varchar(100),
		@c3 varchar(100),
		@c4 varchar(200),
		@c5 varchar(40),
		@c6 varchar(40),
		@c7 varchar(100),
		@c8 varchar(100),
		@c9 varchar(100),
		@c10 varchar(100),
		@c11 varchar(100),
		@c12 varchar(100),
		@c13 varchar(100),
		@c14 varchar(100),
		@c15 varchar(100),
		@c16 varchar(100),
		@c17 varchar(100),
		@c18 varchar(100),
		@c19 varchar(100),
		@c20 varchar(100),
		@c21 varchar(500),
		@c22 varchar(100),
		@c23 varchar(40),
		@c24 varchar(100)
as
begin
if exists (select * 
             from [dbo].[Products]
            where [SysNo] = @c2
              and [ProductNo] = @c3)
begin
update [dbo].[Products] set
		[ProductName] = @c4,
		[TypeNo] = @c5,
		[TypeName] = @c6,
		[ProductPP] = @c7,
		[ProductXH] = @c8,
		[ProductCZ] = @c9,
		[ProductHB] = @c10,
		[ProductHD] = @c11,
		[ProductGY] = @c12,
		[ProductHS] = @c13,
		[ProductMC] = @c14,
		[ProductDJ] = @c15,
		[ProductCD] = @c16,
		[ProductGG] = @c17,
		[ProductYS] = @c18,
		[UnitNo] = @c19,
		[UnitName] = @c20,
		[ProductNote] = @c21,
		[ProductBZGG] = @c22,
		[BelongTypeNo] = @c23,
		[BelongTypeName] = @c24
where [SysNo] = @c2
  and [ProductNo] = @c3
end
else
begin
	insert into [dbo].[Products](
		[Id],
		[SysNo],
		[ProductNo],
		[ProductName],
		[TypeNo],
		[TypeName],
		[ProductPP],
		[ProductXH],
		[ProductCZ],
		[ProductHB],
		[ProductHD],
		[ProductGY],
		[ProductHS],
		[ProductMC],
		[ProductDJ],
		[ProductCD],
		[ProductGG],
		[ProductYS],
		[UnitNo],
		[UnitName],
		[ProductNote],
		[ProductBZGG],
		[BelongTypeNo],
		[BelongTypeName]
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
    @c12,
    @c13,
    @c14,
    @c15,
    @c16,
    @c17,
    @c18,
    @c19,
    @c20,
    @c21,
    @c22,
    @c23,
    @c24	) 
end
end
go
if object_id(N'[sp_MSupd_dboProducts]', 'P') > 0
    drop proc [sp_MSupd_dboProducts]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboProducts'
go
create procedure [sp_MSupd_dboProducts]
		@c1 int = NULL,
		@c2 varchar(100) = NULL,
		@c3 varchar(100) = NULL,
		@c4 varchar(200) = NULL,
		@c5 varchar(40) = NULL,
		@c6 varchar(40) = NULL,
		@c7 varchar(100) = NULL,
		@c8 varchar(100) = NULL,
		@c9 varchar(100) = NULL,
		@c10 varchar(100) = NULL,
		@c11 varchar(100) = NULL,
		@c12 varchar(100) = NULL,
		@c13 varchar(100) = NULL,
		@c14 varchar(100) = NULL,
		@c15 varchar(100) = NULL,
		@c16 varchar(100) = NULL,
		@c17 varchar(100) = NULL,
		@c18 varchar(100) = NULL,
		@c19 varchar(100) = NULL,
		@c20 varchar(100) = NULL,
		@c21 varchar(500) = NULL,
		@c22 varchar(100) = NULL,
		@c23 varchar(40) = NULL,
		@c24 varchar(100) = NULL,
		@pkc1 varchar(100) = NULL,
		@pkc2 varchar(100) = NULL,
		@bitmap binary(3)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2) or
 (substring(@bitmap,1,1) & 4 = 4)
begin 
update [dbo].[Products] set
		[SysNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SysNo] end,
		[ProductNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ProductNo] end,
		[ProductName] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ProductName] end,
		[TypeNo] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [TypeNo] end,
		[TypeName] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [TypeName] end,
		[ProductPP] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [ProductPP] end,
		[ProductXH] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [ProductXH] end,
		[ProductCZ] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [ProductCZ] end,
		[ProductHB] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [ProductHB] end,
		[ProductHD] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [ProductHD] end,
		[ProductGY] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [ProductGY] end,
		[ProductHS] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [ProductHS] end,
		[ProductMC] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [ProductMC] end,
		[ProductDJ] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [ProductDJ] end,
		[ProductCD] = case substring(@bitmap,2,1) & 128 when 128 then @c16 else [ProductCD] end,
		[ProductGG] = case substring(@bitmap,3,1) & 1 when 1 then @c17 else [ProductGG] end,
		[ProductYS] = case substring(@bitmap,3,1) & 2 when 2 then @c18 else [ProductYS] end,
		[UnitNo] = case substring(@bitmap,3,1) & 4 when 4 then @c19 else [UnitNo] end,
		[UnitName] = case substring(@bitmap,3,1) & 8 when 8 then @c20 else [UnitName] end,
		[ProductNote] = case substring(@bitmap,3,1) & 16 when 16 then @c21 else [ProductNote] end,
		[ProductBZGG] = case substring(@bitmap,3,1) & 32 when 32 then @c22 else [ProductBZGG] end,
		[BelongTypeNo] = case substring(@bitmap,3,1) & 64 when 64 then @c23 else [BelongTypeNo] end,
		[BelongTypeName] = case substring(@bitmap,3,1) & 128 when 128 then @c24 else [BelongTypeName] end
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[Products] set
		[ProductName] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ProductName] end,
		[TypeNo] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [TypeNo] end,
		[TypeName] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [TypeName] end,
		[ProductPP] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [ProductPP] end,
		[ProductXH] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [ProductXH] end,
		[ProductCZ] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [ProductCZ] end,
		[ProductHB] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [ProductHB] end,
		[ProductHD] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [ProductHD] end,
		[ProductGY] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [ProductGY] end,
		[ProductHS] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [ProductHS] end,
		[ProductMC] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [ProductMC] end,
		[ProductDJ] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [ProductDJ] end,
		[ProductCD] = case substring(@bitmap,2,1) & 128 when 128 then @c16 else [ProductCD] end,
		[ProductGG] = case substring(@bitmap,3,1) & 1 when 1 then @c17 else [ProductGG] end,
		[ProductYS] = case substring(@bitmap,3,1) & 2 when 2 then @c18 else [ProductYS] end,
		[UnitNo] = case substring(@bitmap,3,1) & 4 when 4 then @c19 else [UnitNo] end,
		[UnitName] = case substring(@bitmap,3,1) & 8 when 8 then @c20 else [UnitName] end,
		[ProductNote] = case substring(@bitmap,3,1) & 16 when 16 then @c21 else [ProductNote] end,
		[ProductBZGG] = case substring(@bitmap,3,1) & 32 when 32 then @c22 else [ProductBZGG] end,
		[BelongTypeNo] = case substring(@bitmap,3,1) & 64 when 64 then @c23 else [BelongTypeNo] end,
		[BelongTypeName] = case substring(@bitmap,3,1) & 128 when 128 then @c24 else [BelongTypeName] end
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
    @object_name = N'sp_MSupd_dboProducts',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Products'
go
if object_id(N'[sp_MSdel_dboProducts]', 'P') > 0
    drop proc [sp_MSdel_dboProducts]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboProducts'
go
create procedure [sp_MSdel_dboProducts]
		@pkc1 varchar(100),
		@pkc2 varchar(100)
as
begin  
	delete [dbo].[Products]
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
    @object_name = N'sp_MSdel_dboProducts',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Products'
go
if object_id(N'[dbo].[sp_MSdel_dboProducts_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboProducts_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboProducts_msrepl_ccs]
		@pkc1 varchar(100),
		@pkc2 varchar(100)
as
begin  
	delete [dbo].[Products]
where [SysNo] = @pkc1
  and [ProductNo] = @pkc2
end  
go
