﻿CREATE TABLE [dbo].[MISSION](
	[MISSIONID] [int] NOT NULL,
	[DUREE] [datetime] NULL,
	[TYPE_MISSIONID] [int] NULL,
	[LIBELLE] [varchar](80) NULL,
	[DESCRIPTION] [varchar](1000) NULL,
	[PRIORITE] [int] NULL,
	[QUALIFID] [int] NULL,
	[DOUBLE_SIGNATURE] [int] NULL,
	[CONSIGNEID] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[RAPPORTID] [int] NULL,
	[ISRAPPORT] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL,
 CONSTRAINT [PK_MISSIONID] PRIMARY KEY CLUSTERED
(
	[MISSIONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]