﻿CREATE TABLE [dbo].[BONTRAVAIL](
	[BONTRAVAILID] [int] NOT NULL,
	[BTR] [varchar](50) NULL,
	[SITEID] [varchar](14) NULL,
	[DATEVALIDITE] [datetime] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[BONTRAVAILID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]