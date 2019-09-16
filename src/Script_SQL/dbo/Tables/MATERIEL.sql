﻿CREATE TABLE [dbo].[MATERIEL](
	[MATERIELID] [int] NOT NULL,
	[LIBELLE] [varchar](40) NULL,
	[OBSERVATION] [varchar](250) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[SITEID] [varchar](14) NULL,
 CONSTRAINT [PK_MATERIELID] PRIMARY KEY CLUSTERED
(
	[MATERIELID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]