
/****** Object:  Table [dbo].[OJOURNALLOG]    Script Date: 05/07/2019 11:18:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OJOURNALLOG](
	[OJOURNALID] [int] NULL,
	[ACTION] [int] NULL,
	[PERSONNELID] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL,
	[OBSERVATION] [varchar](max) NULL,
	[DATEMAJ] [datetime] NULL,
	[OBSERVATION2] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
