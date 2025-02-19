USE [SemiCity]
GO
/****** Object:  Table [dbo].[actions_num]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[actions_num](
	[min_time] [datetime] NULL,
	[cmt] [varchar](50) NULL,
	[sum_count] [int] NULL,
	[sum_time] [int] NULL,
	[reset_count] [int] NULL,
	[update_time] [datetime] NULL,
	[reset_time] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vi_actions_num]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[vi_actions_num]
as

select 
   CONVERT(varchar(50),[min_time],120) [min_time]
  ,RTRIM(cmt) cmt
  ,sum_count
  ,sum_time
  ,[reset_count]
  ,[update_time]
  ,[reset_time]
  ,reverse(SUBSTRING(REVERSE(part1),charindex(' ',REVERSE(part1))+1,len(part1))) chemical
  ,reverse(SUBSTRING( REVERSE(part1),1,charindex(' ',REVERSE(part1))-1)) [floor]
  ,substring(part2,1,len(part2)-2) vmb
  ,RIGHT(rtrim(part2),1) stick
  from (

  select * 
  ,PARSENAME(REPLACE( cmt,'-VMB-','.'),2) part1
  ,PARSENAME(REPLACE( cmt,'-VMB-','.'),1) part2
  from [dbo].[actions_num] ) as AA

  --,part1,part2
GO
/****** Object:  Table [dbo].[m_pou]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m_pou](
	[dt_1] [datetime] NULL,
	[dt_2] [datetime] NULL,
	[cmt] [char](40) NULL,
	[tagname] [char](40) NULL,
	[tool] [char](131) NULL,
	[id] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[m_stick]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m_stick](
	[num] [int] NULL,
	[cmt] [nvarchar](50) NULL,
	[tag] [nvarchar](50) NULL,
	[tool] [nvarchar](50) NULL,
	[data1] [nvarchar](50) NULL,
	[data2] [nvarchar](50) NULL,
	[data3] [nvarchar](50) NULL,
	[data4] [nvarchar](50) NULL,
	[data5] [nvarchar](50) NULL,
	[factory] [nvarchar](50) NULL,
	[specs] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[menus]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[menus](
	[id] [int] NOT NULL,
	[title] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[path] [nvarchar](255) NULL,
	[component] [nvarchar](255) NULL,
	[redirect] [nvarchar](255) NULL,
	[icon] [nvarchar](255) NULL,
	[parent_id] [int] NULL,
	[parent_ids] [nvarchar](50) NULL,
	[order] [int] NULL,
	[hidden] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reset_log]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reset_log](
	[cmt] [varchar](80) NULL,
	[on_reset_count] [int] NULL,
	[reset_time] [datetime] NULL,
	[reset_user_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_menus]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_menus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[menu_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedTime] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[Avatar] [nvarchar](max) NULL,
	[Email] [nvarchar](50) NULL,
	[WorkNo] [nvarchar](50) NOT NULL,
	[key] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_role](
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[role] ADD  CONSTRAINT [DF_Role_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_user_ID]  DEFAULT ((0)) FOR [ID]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_User_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_User_CreatedBy]  DEFAULT (N'admin') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_User_CreatedTime]  DEFAULT (getdate()) FOR [CreatedTime]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF_User_UpdatedTime]  DEFAULT (getdate()) FOR [UpdatedTime]
GO
ALTER TABLE [dbo].[user] ADD  CONSTRAINT [DF__User__WorkNo__5DCAEF64]  DEFAULT ('') FOR [WorkNo]
GO
/****** Object:  StoredProcedure [dbo].[sp_Sync_m_pou]    Script Date: 2021/6/4 13:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Sync_m_pou]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   DECLARE @maxid_iLab bigint	 -- 获取当前 dbo.m_pou 表中最大的id
	DECLARE @maxid_SCADA bigint  -- 获取SCADA dbo.m_pou 表中最大的id

    -- Insert statements for procedure here
	SELECT @maxid_iLab = ISNULL(max(id),0) FROM dbo.m_pou
	SELECT @maxid_SCADA = ISNULL(max(id),0) FROM [LIPINGXIE-NB\SQL2017].[test].[dbo].[m_pou]

	--INSERT INTO dbo.m_pou ( dt_1, dt_2, cmt, tagname, tool, id ) 
 --     SELECT dt_1, dt_2, cmt, tagname, tool, id
	--  FROM [TOMMYMAO-NB].[TEST].[dbo].[m_pou]
	-- WHERE id > @maxid_iLab AND id <= @maxid_SCADA

	 DECLARE CUR_DATA CURSOR FOR
	 (
		 SELECT dt_1, dt_2, cmt, tagname, tool, id
		 FROM [LIPINGXIE-NB\SQL2017].[test].[dbo].[m_pou]
	     WHERE id > @maxid_iLab AND id <= @maxid_SCADA
	 )

	 DECLARE @dt_1 DATETIME,@dt_2 DATETIME,@cmt VARCHAR(50),@tagname VARCHAR(50),@tool VARCHAR(50), @id BIGINT
	 OPEN CUR_DATA
	 FETCH NEXT FROM CUR_DATA INTO @dt_1,@dt_2,@cmt,@tagname,@tool,@id
	 WHILE @@FETCH_STATUS = 0
	 BEGIN
		INSERT INTO dbo.m_pou ( dt_1, dt_2, cmt, tagname, tool, id ) VALUES(@dt_1,@dt_2,@cmt,@tagname,@tool,@id)

		UPDATE [dbo].[num_of_actions] SET [sum_count] = [sum_count] + 1,[sum_time] = [sum_time] + DATEDIFF(SS,@dt_1,@dt_2),[update_time] = GETDATE()
		WHERE cmt = @cmt
		FETCH NEXT FROM CUR_DATA INTO @dt_1,@dt_2,@cmt,@tagname,@tool,@id
	 END

	 CLOSE CUR_DATA
	 DEALLOCATE CUR_DATA
END
GO
