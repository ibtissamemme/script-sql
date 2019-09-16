﻿CREATE TABLE [dbo].[FORMULAIRE_MODELE](
	[FORMULAIRE_MODELEID] [int] NOT NULL,
	[LIBELLE] [varchar](50) NULL,
	[XML] [varchar](4000) NULL,
	[OFICHIERID_WORD] [int] NULL,
	[OFICHIERID_EXCEL] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[TYPEVISITEID] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[FORMULAIRE_MODELEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]