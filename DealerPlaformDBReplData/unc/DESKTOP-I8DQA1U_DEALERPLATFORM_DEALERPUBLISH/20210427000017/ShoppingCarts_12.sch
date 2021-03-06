drop Table [dbo].[ShoppingCarts]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCarts](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CartGuid] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CustomerNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProductNum] [int] NOT NULL,
	[CartSelected] [bit] NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboShoppingCarts]', 'P') > 0
    drop proc [sp_MSins_dboShoppingCarts]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboShoppingCarts'
go
create procedure [sp_MSins_dboShoppingCarts]
    @c1 int,
    @c2 varchar(40),
    @c3 varchar(40),
    @c4 varchar(40),
    @c5 int,
    @c6 bit
as
begin  
	insert into [dbo].[ShoppingCarts](
		[Id],
		[CartGuid],
		[CustomerNo],
		[ProductNo],
		[ProductNum],
		[CartSelected]
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
    @object_name = N'sp_MSins_dboShoppingCarts',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ShoppingCarts'
go
if object_id(N'[dbo].[sp_MSins_dboShoppingCarts_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboShoppingCarts_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboShoppingCarts_msrepl_ccs]
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(40),
		@c4 varchar(40),
		@c5 int,
		@c6 bit
as
begin
if exists (select * 
             from [dbo].[ShoppingCarts]
            where [CartGuid] = @c2)
begin
update [dbo].[ShoppingCarts] set
		[CustomerNo] = @c3,
		[ProductNo] = @c4,
		[ProductNum] = @c5,
		[CartSelected] = @c6
where [CartGuid] = @c2
end
else
begin
	insert into [dbo].[ShoppingCarts](
		[Id],
		[CartGuid],
		[CustomerNo],
		[ProductNo],
		[ProductNum],
		[CartSelected]
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
if object_id(N'[sp_MSupd_dboShoppingCarts]', 'P') > 0
    drop proc [sp_MSupd_dboShoppingCarts]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboShoppingCarts'
go
create procedure [sp_MSupd_dboShoppingCarts]
		@c1 int = NULL,
		@c2 varchar(40) = NULL,
		@c3 varchar(40) = NULL,
		@c4 varchar(40) = NULL,
		@c5 int = NULL,
		@c6 bit = NULL,
		@pkc1 varchar(40) = NULL,
		@bitmap binary(1)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2)
begin 
update [dbo].[ShoppingCarts] set
		[CartGuid] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [CartGuid] end,
		[CustomerNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CustomerNo] end,
		[ProductNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ProductNo] end,
		[ProductNum] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ProductNum] end,
		[CartSelected] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [CartSelected] end
where [CartGuid] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[ShoppingCarts] set
		[CustomerNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CustomerNo] end,
		[ProductNo] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [ProductNo] end,
		[ProductNum] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [ProductNum] end,
		[CartSelected] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [CartSelected] end
where [CartGuid] = @pkc1
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
    @object_name = N'sp_MSupd_dboShoppingCarts',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ShoppingCarts'
go
if object_id(N'[sp_MSdel_dboShoppingCarts]', 'P') > 0
    drop proc [sp_MSdel_dboShoppingCarts]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboShoppingCarts'
go
create procedure [sp_MSdel_dboShoppingCarts]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[ShoppingCarts]
where [CartGuid] = @pkc1
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
    @object_name = N'sp_MSdel_dboShoppingCarts',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'ShoppingCarts'
go
if object_id(N'[dbo].[sp_MSdel_dboShoppingCarts_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboShoppingCarts_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboShoppingCarts_msrepl_ccs]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[ShoppingCarts]
where [CartGuid] = @pkc1
end  
go
