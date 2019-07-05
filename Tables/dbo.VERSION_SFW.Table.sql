
/****** Object:  Table [dbo].[VERSION_SFW]    Script Date: 05/07/2019 11:18:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VERSION_SFW](
	[COMPATIBLE] [varchar](10) NULL,
	[SCHEMAS] [varchar](10) NULL,
	[INFO] [varchar](50) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[FORMATDATE] [varchar](10) NULL,
	[VERSION] [varchar](50) NULL
) ON [PRIMARY]
GO
