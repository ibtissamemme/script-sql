
/****** Object:  Table [dbo].[JRAPPORTLOG]    Script Date: 05/07/2019 11:18:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JRAPPORTLOG](
	[OJOURNALID] [int] NULL,
	[RAPPORTID] [int] NULL,
	[RPTID] [int] NULL,
	[RPTNOM] [varchar](20) NULL,
	[REF] [varchar](20) NULL,
	[VERSION] [int] NULL,
	[PERSONNELID] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]
GO
