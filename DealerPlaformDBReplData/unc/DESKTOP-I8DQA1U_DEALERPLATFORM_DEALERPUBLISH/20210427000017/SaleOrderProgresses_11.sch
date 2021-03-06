drop Table [dbo].[SaleOrderProgresses]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleOrderProgresses](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SaleOrderNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProgressGuid] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StepSn] [int] NOT NULL,
	[StepName] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StepTime] [datetime] NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboSaleOrderProgresses]', 'P') > 0
    drop proc [sp_MSins_dboSaleOrderProgresses]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboSaleOrderProgresses'
go
create procedure [sp_MSins_dboSaleOrderProgresses]
    @c1 int,
    @c2 varchar(40),
    @c3 varchar(40),
    @c4 int,
    @c5 varchar(100),
    @c6 datetime
as
begin  
	insert into [dbo].[SaleOrderProgresses](
		[Id],
		[SaleOrderNo],
		[ProgressGuid],
		[StepSn],
		[StepName],
		[StepTime]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6	) 
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
    @object_name = N'sp_MSins_dboSaleOrderProgresses',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderProgresses'
go
if object_id(N'[dbo].[sp_MSins_dboSaleOrderProgresses_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboSaleOrderProgresses_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboSaleOrderProgresses_msrepl_ccs]
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(40),
		@c4 int,
		@c5 varchar(100),
		@c6 datetime
as
begin
if exists (select * 
             from [dbo].[SaleOrderProgresses]
            where [SaleOrderNo] = @c2
              and [ProgressGuid] = @c3)
begin
update [dbo].[SaleOrderProgresses] set
		[StepSn] = @c4,
		[StepName] = @c5,
		[StepTime] = @c6
where [SaleOrderNo] = @c2
  and [ProgressGuid] = @c3
end
else
begin
	insert into [dbo].[SaleOrderProgresses](
		[Id],
		[SaleOrderNo],
		[ProgressGuid],
		[StepSn],
		[StepName],
		[StepTime]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6	) 
end
end
go
if object_id(N'[sp_MSupd_dboSaleOrderProgresses]', 'P') > 0
    drop proc [sp_MSupd_dboSaleOrderProgresses]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboSaleOrderProgresses'
go
create procedure [sp_MSupd_dboSaleOrderProgresses]
		@c1 int = NULL,
		@c2 varchar(40) = NULL,
		@c3 varchar(40) = NULL,
		@c4 int = NULL,
		@c5 varchar(100) = NULL,
		@c6 datetime = NULL,
		@pkc1 varchar(40) = NULL,
		@pkc2 varchar(40) = NULL,
		@bitmap binary(1)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2) or
 (substring(@bitmap,1,1) & 4 = 4)
begin 
update [dbo].[SaleOrderProgresses] set
		[SaleOrderNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [SaleOrderNo] end,
		[ProgressGuid] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [ProgressGuid] end,
		[StepSn] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [StepSn] end,
		[StepName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [StepName] end,
		[StepTime] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [StepTime] end
where [SaleOrderNo] = @pkc1
  and [ProgressGuid] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[SaleOrderProgresses] set
		[StepSn] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [StepSn] end,
		[StepName] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [StepName] end,
		[StepTime] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [StepTime] end
where [SaleOrderNo] = @pkc1
  and [ProgressGuid] = @pkc2
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
    @object_name = N'sp_MSupd_dboSaleOrderProgresses',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderProgresses'
go
if object_id(N'[sp_MSdel_dboSaleOrderProgresses]', 'P') > 0
    drop proc [sp_MSdel_dboSaleOrderProgresses]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboSaleOrderProgresses'
go
create procedure [sp_MSdel_dboSaleOrderProgresses]
		@pkc1 varchar(40),
		@pkc2 varchar(40)
as
begin  
	delete [dbo].[SaleOrderProgresses]
where [SaleOrderNo] = @pkc1
  and [ProgressGuid] = @pkc2
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
    @object_name = N'sp_MSdel_dboSaleOrderProgresses',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'SaleOrderProgresses'
go
if object_id(N'[dbo].[sp_MSdel_dboSaleOrderProgresses_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboSaleOrderProgresses_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboSaleOrderProgresses_msrepl_ccs]
		@pkc1 varchar(40),
		@pkc2 varchar(40)
as
begin  
	delete [dbo].[SaleOrderProgresses]
where [SaleOrderNo] = @pkc1
  and [ProgressGuid] = @pkc2
end  
go
