﻿CREATE TABLE [dbo].[LOCALISATION](
	[LOCALISATIONID] [int] NOT NULL,
	[LIBELLE] [varchar](100) NULL,
	[SITEID] [varchar](14) NULL,
	[SALLE_CAGE] [varchar](100) NULL,
	[BAIE] [varchar](100) NULL,
	[LOCALISATION_TYPE] [varchar](50) NULL,
	[CODE] [varchar](100) NULL,
	[EMPREINTE] [varchar](100) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[LOCALISATIONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]