﻿CREATE TABLE [dbo].[SOCBAT](
	[BATIMENTID] [varchar](14) NOT NULL,
	[SOCIETEID] [varchar](14) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_BATIMENTIDSOCIETEID] PRIMARY KEY CLUSTERED
(
	[BATIMENTID] ASC,
	[SOCIETEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]