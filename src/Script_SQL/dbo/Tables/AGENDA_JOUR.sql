﻿CREATE TABLE [dbo].[AGENDA_JOUR](
	[AGENDA_JOURID] [int] NOT NULL,
	[JOURID] [int] NULL,
	[HEURE] [datetime] NULL,
	[TOLERANCE] [datetime] NULL,
	[MISSIONID] [int] NULL,
	[POSTEID] [int] NULL,
	[STATUT] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[SITEID] [nvarchar](14) NULL,
 CONSTRAINT [PK_AGENDA_JOURID] PRIMARY KEY CLUSTERED
(
	[AGENDA_JOURID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]