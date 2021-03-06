﻿CREATE TABLE [dbo].[TAG](
	[TAGID] [int] NOT NULL,
	[TAG] [varchar](35) NULL,
	[DESCRIPTION] [varchar](100) NULL,
	[TYPE_TAG] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[TAGID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]