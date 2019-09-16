﻿CREATE TABLE [dbo].[OJOURNALLOG](
	[OJOURNALID] [int] NULL,
	[ACTION] [int] NULL,
	[PERSONNELID] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL,
	[OBSERVATION] [varchar](max) NULL,
	[DATEMAJ] [datetime] NULL,
	[OBSERVATION2] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]