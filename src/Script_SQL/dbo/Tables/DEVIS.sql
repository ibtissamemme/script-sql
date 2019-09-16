﻿CREATE TABLE [dbo].[DEVIS](
	[CODEDEVIS] [varchar](14) NOT NULL,
	[SOCIETEID] [varchar](14) NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[CODEAFFAIRE] [varchar](14) NULL,
	[CODECLIENT] [varchar](14) NOT NULL,
	[COMMERCIALID] [varchar](14) NULL,
	[CODEMODEPAIE] [varchar](14) NULL,
	[CODEDELAIPAIE] [varchar](14) NULL,
	[CODEINTERVENNANT] [varchar](14) NULL,
	[NODEVIS] [varchar](15) NULL,
	[LIBELLE] [varchar](80) NULL,
	[INDICEDEVIS] [int] NULL,
	[DATEEMISSION] [datetime] NOT NULL,
	[TOTALAR] [float] NULL,
	[REMISE] [float] NULL,
	[TOTALHT] [float] NULL,
	[TOTALTVA] [float] NULL,
	[TOTALTTC] [float] NULL,
	[WIZARD] [int] NULL,
	[OBSERVATION] [image] NULL,
	[ACOMPTE] [float] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[REMISE_SALLE] [float] NULL,
 CONSTRAINT [PK_CODEDEVIS] PRIMARY KEY CLUSTERED
(
	[CODEDEVIS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]