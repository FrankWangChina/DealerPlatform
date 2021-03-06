drop Table [dbo].[Customers]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CustomerNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CustomerName] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[FirstAreaNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[FirstAreaName] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[AreaNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[AreaName] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Province] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[City] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Tel] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Phone] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Fax] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Address] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[BankAccount] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[BankNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[BankName] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Ein] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CustomerNote] [varchar](500) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[OwnerWorkerNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NULL,
	[OwnerWorkerName] [varchar](100) COLLATE Chinese_PRC_CI_AS NULL,
	[OwnerWorkerTel] [varchar](40) COLLATE Chinese_PRC_CI_AS NULL,
	[OpenId] [varchar](40) COLLATE Chinese_PRC_CI_AS NULL,
	[HeadImgUrl] [varchar](255) COLLATE Chinese_PRC_CI_AS NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboCustomers]', 'P') > 0
    drop proc [sp_MSins_dboCustomers]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboCustomers'
go
create procedure [sp_MSins_dboCustomers]
    @c1 int,
    @c2 varchar(40),
    @c3 varchar(100),
    @c4 varchar(40),
    @c5 varchar(100),
    @c6 varchar(40),
    @c7 varchar(100),
    @c8 varchar(40),
    @c9 varchar(40),
    @c10 varchar(40),
    @c11 varchar(40),
    @c12 varchar(40),
    @c13 varchar(100),
    @c14 varchar(40),
    @c15 varchar(40),
    @c16 varchar(100),
    @c17 varchar(40),
    @c18 varchar(500),
    @c19 varchar(40),
    @c20 varchar(100),
    @c21 varchar(40),
    @c22 varchar(40),
    @c23 varchar(255)
as
begin  
	insert into [dbo].[Customers](
		[Id],
		[CustomerNo],
		[CustomerName],
		[FirstAreaNo],
		[FirstAreaName],
		[AreaNo],
		[AreaName],
		[Province],
		[City],
		[Tel],
		[Phone],
		[Fax],
		[Address],
		[BankAccount],
		[BankNo],
		[BankName],
		[Ein],
		[CustomerNote],
		[OwnerWorkerNo],
		[OwnerWorkerName],
		[OwnerWorkerTel],
		[OpenId],
		[HeadImgUrl]
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
    @c23	) 
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
    @object_name = N'sp_MSins_dboCustomers',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Customers'
go
if object_id(N'[dbo].[sp_MSins_dboCustomers_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboCustomers_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboCustomers_msrepl_ccs]
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(100),
		@c4 varchar(40),
		@c5 varchar(100),
		@c6 varchar(40),
		@c7 varchar(100),
		@c8 varchar(40),
		@c9 varchar(40),
		@c10 varchar(40),
		@c11 varchar(40),
		@c12 varchar(40),
		@c13 varchar(100),
		@c14 varchar(40),
		@c15 varchar(40),
		@c16 varchar(100),
		@c17 varchar(40),
		@c18 varchar(500),
		@c19 varchar(40),
		@c20 varchar(100),
		@c21 varchar(40),
		@c22 varchar(40),
		@c23 varchar(255)
as
begin
if exists (select * 
             from [dbo].[Customers]
            where [CustomerNo] = @c2)
begin
update [dbo].[Customers] set
		[CustomerName] = @c3,
		[FirstAreaNo] = @c4,
		[FirstAreaName] = @c5,
		[AreaNo] = @c6,
		[AreaName] = @c7,
		[Province] = @c8,
		[City] = @c9,
		[Tel] = @c10,
		[Phone] = @c11,
		[Fax] = @c12,
		[Address] = @c13,
		[BankAccount] = @c14,
		[BankNo] = @c15,
		[BankName] = @c16,
		[Ein] = @c17,
		[CustomerNote] = @c18,
		[OwnerWorkerNo] = @c19,
		[OwnerWorkerName] = @c20,
		[OwnerWorkerTel] = @c21,
		[OpenId] = @c22,
		[HeadImgUrl] = @c23
where [CustomerNo] = @c2
end
else
begin
	insert into [dbo].[Customers](
		[Id],
		[CustomerNo],
		[CustomerName],
		[FirstAreaNo],
		[FirstAreaName],
		[AreaNo],
		[AreaName],
		[Province],
		[City],
		[Tel],
		[Phone],
		[Fax],
		[Address],
		[BankAccount],
		[BankNo],
		[BankName],
		[Ein],
		[CustomerNote],
		[OwnerWorkerNo],
		[OwnerWorkerName],
		[OwnerWorkerTel],
		[OpenId],
		[HeadImgUrl]
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
    @c23	) 
end
end
go
if object_id(N'[sp_MSupd_dboCustomers]', 'P') > 0
    drop proc [sp_MSupd_dboCustomers]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboCustomers'
go
create procedure [sp_MSupd_dboCustomers]
		@c1 int = NULL,
		@c2 varchar(40) = NULL,
		@c3 varchar(100) = NULL,
		@c4 varchar(40) = NULL,
		@c5 varchar(100) = NULL,
		@c6 varchar(40) = NULL,
		@c7 varchar(100) = NULL,
		@c8 varchar(40) = NULL,
		@c9 varchar(40) = NULL,
		@c10 varchar(40) = NULL,
		@c11 varchar(40) = NULL,
		@c12 varchar(40) = NULL,
		@c13 varchar(100) = NULL,
		@c14 varchar(40) = NULL,
		@c15 varchar(40) = NULL,
		@c16 varchar(100) = NULL,
		@c17 varchar(40) = NULL,
		@c18 varchar(500) = NULL,
		@c19 varchar(40) = NULL,
		@c20 varchar(100) = NULL,
		@c21 varchar(40) = NULL,
		@c22 varchar(40) = NULL,
		@c23 varchar(255) = NULL,
		@pkc1 varchar(40) = NULL,
		@bitmap binary(3)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2)
begin 
update [dbo].[Customers] set
		[CustomerNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [CustomerNo] end,
		[CustomerName] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CustomerName] end,
		[FirstAreaNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [FirstAreaNo] end,
		[FirstAreaName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [FirstAreaName] end,
		[AreaNo] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [AreaNo] end,
		[AreaName] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [AreaName] end,
		[Province] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [Province] end,
		[City] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [City] end,
		[Tel] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [Tel] end,
		[Phone] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [Phone] end,
		[Fax] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [Fax] end,
		[Address] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [Address] end,
		[BankAccount] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [BankAccount] end,
		[BankNo] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [BankNo] end,
		[BankName] = case substring(@bitmap,2,1) & 128 when 128 then @c16 else [BankName] end,
		[Ein] = case substring(@bitmap,3,1) & 1 when 1 then @c17 else [Ein] end,
		[CustomerNote] = case substring(@bitmap,3,1) & 2 when 2 then @c18 else [CustomerNote] end,
		[OwnerWorkerNo] = case substring(@bitmap,3,1) & 4 when 4 then @c19 else [OwnerWorkerNo] end,
		[OwnerWorkerName] = case substring(@bitmap,3,1) & 8 when 8 then @c20 else [OwnerWorkerName] end,
		[OwnerWorkerTel] = case substring(@bitmap,3,1) & 16 when 16 then @c21 else [OwnerWorkerTel] end,
		[OpenId] = case substring(@bitmap,3,1) & 32 when 32 then @c22 else [OpenId] end,
		[HeadImgUrl] = case substring(@bitmap,3,1) & 64 when 64 then @c23 else [HeadImgUrl] end
where [CustomerNo] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[Customers] set
		[CustomerName] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CustomerName] end,
		[FirstAreaNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [FirstAreaNo] end,
		[FirstAreaName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [FirstAreaName] end,
		[AreaNo] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [AreaNo] end,
		[AreaName] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [AreaName] end,
		[Province] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [Province] end,
		[City] = case substring(@bitmap,2,1) & 1 when 1 then @c9 else [City] end,
		[Tel] = case substring(@bitmap,2,1) & 2 when 2 then @c10 else [Tel] end,
		[Phone] = case substring(@bitmap,2,1) & 4 when 4 then @c11 else [Phone] end,
		[Fax] = case substring(@bitmap,2,1) & 8 when 8 then @c12 else [Fax] end,
		[Address] = case substring(@bitmap,2,1) & 16 when 16 then @c13 else [Address] end,
		[BankAccount] = case substring(@bitmap,2,1) & 32 when 32 then @c14 else [BankAccount] end,
		[BankNo] = case substring(@bitmap,2,1) & 64 when 64 then @c15 else [BankNo] end,
		[BankName] = case substring(@bitmap,2,1) & 128 when 128 then @c16 else [BankName] end,
		[Ein] = case substring(@bitmap,3,1) & 1 when 1 then @c17 else [Ein] end,
		[CustomerNote] = case substring(@bitmap,3,1) & 2 when 2 then @c18 else [CustomerNote] end,
		[OwnerWorkerNo] = case substring(@bitmap,3,1) & 4 when 4 then @c19 else [OwnerWorkerNo] end,
		[OwnerWorkerName] = case substring(@bitmap,3,1) & 8 when 8 then @c20 else [OwnerWorkerName] end,
		[OwnerWorkerTel] = case substring(@bitmap,3,1) & 16 when 16 then @c21 else [OwnerWorkerTel] end,
		[OpenId] = case substring(@bitmap,3,1) & 32 when 32 then @c22 else [OpenId] end,
		[HeadImgUrl] = case substring(@bitmap,3,1) & 64 when 64 then @c23 else [HeadImgUrl] end
where [CustomerNo] = @pkc1
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
    @object_name = N'sp_MSupd_dboCustomers',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Customers'
go
if object_id(N'[sp_MSdel_dboCustomers]', 'P') > 0
    drop proc [sp_MSdel_dboCustomers]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboCustomers'
go
create procedure [sp_MSdel_dboCustomers]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[Customers]
where [CustomerNo] = @pkc1
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
    @object_name = N'sp_MSdel_dboCustomers',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Customers'
go
if object_id(N'[dbo].[sp_MSdel_dboCustomers_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboCustomers_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboCustomers_msrepl_ccs]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[Customers]
where [CustomerNo] = @pkc1
end  
go
