﻿CREATE TABLE [dbo].[PAGENT](
	[PAGENTID] [int] NOT NULL,
	[DATE_PLANNING] [datetime] NULL,
	[SEMAINE] [int] NULL,
	[VACATIONID] [int] NULL,
	[AGENTID] [int] NULL,
	[POSTEID] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_PAGENTID] PRIMARY KEY CLUSTERED
(
	[PAGENTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]