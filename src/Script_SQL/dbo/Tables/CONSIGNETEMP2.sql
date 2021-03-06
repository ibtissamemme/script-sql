﻿CREATE TABLE [dbo].[CONSIGNETEMP2](
	[CONSIGNETEMP2ID] [int] NOT NULL,
	[AUTEURID] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL,
	[QUALIFID] [int] NULL,
	[DEBUT] [datetime] NULL,
	[FIN] [datetime] NULL,
	[OBSERVATION] [varchar](1000) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CONSIGNETEMP2ID] PRIMARY KEY CLUSTERED
(
	[CONSIGNETEMP2ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]