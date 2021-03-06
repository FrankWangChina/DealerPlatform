drop Table [dbo].[CustomerInvoices]
go
SET ANSI_PADDING ON
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerInvoices](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CustomerNo] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InvoiceNo] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InvoiceEin] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InvoiceBank] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InvoiceAccount] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InvoiceAddress] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[InvoicePhone] [varchar](40) COLLATE Chinese_PRC_CI_AS NOT NULL
)

GO
SET ANSI_NULLS ON

go

SET QUOTED_IDENTIFIER ON

go

SET QUOTED_IDENTIFIER ON

go

if object_id(N'[sp_MSins_dboCustomerInvoices]', 'P') > 0
    drop proc [sp_MSins_dboCustomerInvoices]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSins_dboCustomerInvoices'
go
create procedure [sp_MSins_dboCustomerInvoices]
    @c1 int,
    @c2 varchar(40),
    @c3 varchar(100),
    @c4 varchar(40),
    @c5 varchar(100),
    @c6 varchar(40),
    @c7 varchar(100),
    @c8 varchar(40)
as
begin  
	insert into [dbo].[CustomerInvoices](
		[Id],
		[CustomerNo],
		[InvoiceNo],
		[InvoiceEin],
		[InvoiceBank],
		[InvoiceAccount],
		[InvoiceAddress],
		[InvoicePhone]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6,
    @c7,
    @c8	) 
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
    @object_name = N'sp_MSins_dboCustomerInvoices',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'CustomerInvoices'
go
if object_id(N'[dbo].[sp_MSins_dboCustomerInvoices_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSins_dboCustomerInvoices_msrepl_ccs]
go
create procedure [dbo].[sp_MSins_dboCustomerInvoices_msrepl_ccs]
		@c1 int,
		@c2 varchar(40),
		@c3 varchar(100),
		@c4 varchar(40),
		@c5 varchar(100),
		@c6 varchar(40),
		@c7 varchar(100),
		@c8 varchar(40)
as
begin
if exists (select * 
             from [dbo].[CustomerInvoices]
            where [CustomerNo] = @c2
              and [InvoiceNo] = @c3)
begin
update [dbo].[CustomerInvoices] set
		[InvoiceEin] = @c4,
		[InvoiceBank] = @c5,
		[InvoiceAccount] = @c6,
		[InvoiceAddress] = @c7,
		[InvoicePhone] = @c8
where [CustomerNo] = @c2
  and [InvoiceNo] = @c3
end
else
begin
	insert into [dbo].[CustomerInvoices](
		[Id],
		[CustomerNo],
		[InvoiceNo],
		[InvoiceEin],
		[InvoiceBank],
		[InvoiceAccount],
		[InvoiceAddress],
		[InvoicePhone]
	) values (
    @c1,
    @c2,
    @c3,
    @c4,
    @c5,
    @c6,
    @c7,
    @c8	) 
end
end
go
if object_id(N'[sp_MSupd_dboCustomerInvoices]', 'P') > 0
    drop proc [sp_MSupd_dboCustomerInvoices]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSupd_dboCustomerInvoices'
go
create procedure [sp_MSupd_dboCustomerInvoices]
		@c1 int = NULL,
		@c2 varchar(40) = NULL,
		@c3 varchar(100) = NULL,
		@c4 varchar(40) = NULL,
		@c5 varchar(100) = NULL,
		@c6 varchar(40) = NULL,
		@c7 varchar(100) = NULL,
		@c8 varchar(40) = NULL,
		@pkc1 varchar(40) = NULL,
		@pkc2 varchar(100) = NULL,
		@bitmap binary(1)
as
begin  
if (substring(@bitmap,1,1) & 2 = 2) or
 (substring(@bitmap,1,1) & 4 = 4)
begin 
update [dbo].[CustomerInvoices] set
		[CustomerNo] = case substring(@bitmap,1,1) & 2 when 2 then @c2 else [CustomerNo] end,
		[InvoiceNo] = case substring(@bitmap,1,1) & 4 when 4 then @c3 else [InvoiceNo] end,
		[InvoiceEin] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [InvoiceEin] end,
		[InvoiceBank] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [InvoiceBank] end,
		[InvoiceAccount] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [InvoiceAccount] end,
		[InvoiceAddress] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [InvoiceAddress] end,
		[InvoicePhone] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [InvoicePhone] end
where [CustomerNo] = @pkc1
  and [InvoiceNo] = @pkc2
if @@rowcount = 0
    if @@microsoftversion>0x07320000
        exec sp_MSreplraiserror 20598
end  
else
begin 
update [dbo].[CustomerInvoices] set
		[InvoiceEin] = case substring(@bitmap,1,1) & 8 when 8 then @c4 else [InvoiceEin] end,
		[InvoiceBank] = case substring(@bitmap,1,1) & 16 when 16 then @c5 else [InvoiceBank] end,
		[InvoiceAccount] = case substring(@bitmap,1,1) & 32 when 32 then @c6 else [InvoiceAccount] end,
		[InvoiceAddress] = case substring(@bitmap,1,1) & 64 when 64 then @c7 else [InvoiceAddress] end,
		[InvoicePhone] = case substring(@bitmap,1,1) & 128 when 128 then @c8 else [InvoicePhone] end
where [CustomerNo] = @pkc1
  and [InvoiceNo] = @pkc2
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
    @object_name = N'sp_MSupd_dboCustomerInvoices',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'CustomerInvoices'
go
if object_id(N'[sp_MSdel_dboCustomerInvoices]', 'P') > 0
    drop proc [sp_MSdel_dboCustomerInvoices]
go
if object_id(N'dbo.MSreplication_objects') is not null
    delete from dbo.MSreplication_objects where object_name = N'sp_MSdel_dboCustomerInvoices'
go
create procedure [sp_MSdel_dboCustomerInvoices]
		@pkc1 varchar(40),
		@pkc2 varchar(100)
as
begin  
	delete [dbo].[CustomerInvoices]
where [CustomerNo] = @pkc1
  and [InvoiceNo] = @pkc2
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
    @object_name = N'sp_MSdel_dboCustomerInvoices',
    @publisher = N'DESKTOP-I8DQA1U',
    @publisher_db = N'DealerPlatform',
    @publication = N'DealerPublish',
    @article = N'CustomerInvoices'
go
if object_id(N'[dbo].[sp_MSdel_dboCustomerInvoices_msrepl_ccs]', 'P') > 0
    drop proc [dbo].[sp_MSdel_dboCustomerInvoices_msrepl_ccs]
go
create procedure [dbo].[sp_MSdel_dboCustomerInvoices_msrepl_ccs]
		@pkc1 varchar(40),
		@pkc2 varchar(100)
as
begin  
	delete [dbo].[CustomerInvoices]
where [CustomerNo] = @pkc1
  and [InvoiceNo] = @pkc2
end  
go
