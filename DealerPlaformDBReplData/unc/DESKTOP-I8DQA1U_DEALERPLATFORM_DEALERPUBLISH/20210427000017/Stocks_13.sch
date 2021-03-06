drop Table [dbo].[Stocks]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stocks](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[StockNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StockName] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StockLinkman] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StockTel] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StockPhone] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboStocks]', 'P') > 0
    drop proc [sp_MSins_dboStocks]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboStocks'
go
create procedure [sp_MSins_dboStocks]
    @c1 int,
    @c2 varchar(40),
    @c3 varchar(100),
    @c4 varchar(40),
    @c5 varchar(40),
    @c6 varchar(40)
as
begin  
	insert into [dbo].[Stocks](
		[Id],
		[StockNo],
		[StockName],
		[StockLinkman],
		[StockTel],
		[StockPhone]
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
    @object_name = N'sp_MSins_dboStocks',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Stocks'
go
if object_id(N'[dbo].[sp_MSins_dboStocks_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboStocks_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboStocks_msrepl_ccs]
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(100),
		@c4 varchar(40),
		@c5 varchar(40),
		@c6 varchar(40)
as
begin
if exists (select * 
             from [dbo].[Stocks]
            where [StockNo] = @c2)
begin
update [dbo].[Stocks] set
		[StockName] = @c3,
		[StockLinkman] = @c4,
		[StockTel] = @c5,
		[StockPhone] = @c6
where [StockNo] = @c2
end
else
begin
	insert into [dbo].[Stocks](
		[Id],
		[StockNo],
		[StockName],
		[StockLinkman],
		[StockTel],
		[StockPhone]
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
if object_id(N'[sp_MSupd_dboStocks]', 'P') > 0
    drop proc [sp_MSupd_dboStocks]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboStocks'
go
create procedure [sp_MSupd_dboStocks]
		@c1 int = NULL,
		@c2 varchar(40) = NULL,
		@c3 varchar(100) = NULL,
		@c4 varchar(40) = NULL,
		@c5 varchar(40) = NULL,
		@c6 varchar(40) = NULL,
		@pkc1 varchar(40) = NULL,
		@bitmap binary(1)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2)
begin 
update [dbo].[Stocks] set
		[StockNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [StockNo] end,
		[StockName] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [StockName] end,
		[StockLinkman] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [StockLinkman] end,
		[StockTel] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [StockTel] end,
		[StockPhone] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [StockPhone] end
where [StockNo] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[Stocks] set
		[StockName] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [StockName] end,
		[StockLinkman] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [StockLinkman] end,
		[StockTel] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [StockTel] end,
		[StockPhone] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [StockPhone] end
where [StockNo] = @pkc1
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
    @object_name = N'sp_MSupd_dboStocks',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Stocks'
go
if object_id(N'[sp_MSdel_dboStocks]', 'P') > 0
    drop proc [sp_MSdel_dboStocks]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboStocks'
go
create procedure [sp_MSdel_dboStocks]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[Stocks]
where [StockNo] = @pkc1
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
    @object_name = N'sp_MSdel_dboStocks',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'Stocks'
go
if object_id(N'[dbo].[sp_MSdel_dboStocks_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboStocks_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboStocks_msrepl_ccs]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[Stocks]
where [StockNo] = @pkc1
end  
go
