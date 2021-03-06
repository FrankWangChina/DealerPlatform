drop Table [dbo].[CustomerPwds]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerPwds](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CustomerNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CustomerPwd] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboCustomerPwds]', 'P') > 0
    drop proc [sp_MSins_dboCustomerPwds]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboCustomerPwds'
go
create procedure [sp_MSins_dboCustomerPwds]
    @c1 int,
    @c2 varchar(40),
    @c3 varchar(40)
as
begin  
	insert into [dbo].[CustomerPwds](
		[id],
		[CustomerNo],
		[CustomerPwd]
	) values (
    @c1,
    @c2,
    @c3	) 
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
    @object_name = N'sp_MSins_dboCustomerPwds',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'CustomerPwds'
go
if object_id(N'[dbo].[sp_MSins_dboCustomerPwds_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboCustomerPwds_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboCustomerPwds_msrepl_ccs]
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(40)
as
begin
if exists (select * 
             from [dbo].[CustomerPwds]
            where [CustomerNo] = @c2)
begin
update [dbo].[CustomerPwds] set
		[CustomerPwd] = @c3
where [CustomerNo] = @c2
end
else
begin
	insert into [dbo].[CustomerPwds](
		[id],
		[CustomerNo],
		[CustomerPwd]
	) values (
    @c1,
    @c2,
    @c3	) 
end
end
go
if object_id(N'[sp_MSupd_dboCustomerPwds]', 'P') > 0
    drop proc [sp_MSupd_dboCustomerPwds]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboCustomerPwds'
go
create procedure [sp_MSupd_dboCustomerPwds]
		@c1 int = NULL,
		@c2 varchar(40) = NULL,
		@c3 varchar(40) = NULL,
		@pkc1 varchar(40) = NULL,
		@bitmap binary(1)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2)
begin 
update [dbo].[CustomerPwds] set
		[CustomerNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [CustomerNo] end,
		[CustomerPwd] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CustomerPwd] end
where [CustomerNo] = @pkc1
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[CustomerPwds] set
		[CustomerPwd] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [CustomerPwd] end
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
    @object_name = N'sp_MSupd_dboCustomerPwds',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'CustomerPwds'
go
if object_id(N'[sp_MSdel_dboCustomerPwds]', 'P') > 0
    drop proc [sp_MSdel_dboCustomerPwds]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboCustomerPwds'
go
create procedure [sp_MSdel_dboCustomerPwds]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[CustomerPwds]
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
    @object_name = N'sp_MSdel_dboCustomerPwds',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'CustomerPwds'
go
if object_id(N'[dbo].[sp_MSdel_dboCustomerPwds_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboCustomerPwds_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboCustomerPwds_msrepl_ccs]
		@pkc1 varchar(40)
as
begin  
	delete [dbo].[CustomerPwds]
where [CustomerNo] = @pkc1
end  
go
