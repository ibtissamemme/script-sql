﻿CREATE TABLE [dbo].[LGDEVIS](
	[CODEDEVIS] [varchar](14) NOT NULL,
	[CODELGDEVIS] [varchar](14) NOT NULL,
	[OPTIONLEVEL] [int] NULL,
	[GROUPLEVEL] [int] NULL,
	[CODEPRODUIT] [varchar](14) NULL,
	[CODEFOURNISSEUR] [varchar](14) NULL,
	[QUANTITE] [int] NULL,
	[LIBELLE] [varchar](80) NULL,
	[PRIXACHATHT] [float] NULL,
	[MARGE] [float] NULL,
	[PRIXVENTEHT] [float] NULL,
	[REMISE] [float] NULL,
	[PRIXHT] [float] NULL,
	[CODETVA] [varchar](14) NOT NULL,
	[TVA] [float] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CODEDEVISLGDEVIS] PRIMARY KEY CLUSTERED
(
	[CODEDEVIS] ASC,
	[CODELGDEVIS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]