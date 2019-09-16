﻿CREATE TABLE [dbo].[LGFACTURE](
	[CODEFACTURE] [varchar](14) NOT NULL,
	[LGFACTURE] [varchar](14) NOT NULL,
	[CODEPRODUIT] [varchar](14) NOT NULL,
	[CODETVA] [varchar](14) NOT NULL,
	[QUANTITE] [int] NOT NULL,
	[LIBELLE] [varchar](80) NULL,
	[PRIXHT] [float] NOT NULL,
	[REMISE] [float] NULL,
	[PRIXHTREEL] [float] NULL,
	[TAUXTVA] [float] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CODEFACTURELGFACTURE] PRIMARY KEY CLUSTERED
(
	[CODEFACTURE] ASC,
	[LGFACTURE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]