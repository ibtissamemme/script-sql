﻿CREATE TABLE [dbo].[HLGPA](
	[CODERESERVATION] [nvarchar](14) NULL,
	[CODELGRESERVATION] [nvarchar](14) NULL,
	[CODESALLE] [nvarchar](14) NULL,
	[CODELGPA] [nvarchar](14) NULL,
	[CODEARTICLE] [nvarchar](14) NULL,
	[DATEDEBUT] [datetime] NULL,
	[DATEFIN] [datetime] NULL,
	[QUANTITE] [float] NULL,
	[PRIX] [float] NULL,
	[CODETVA] [nvarchar](14) NULL,
	[TAUXTVA] [float] NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[HEURECONTINU] [int] NULL,
	[REMISE] [float] NULL,
	[LIBELLESALLE] [nvarchar](35) NULL,
	[NOSALLE] [nvarchar](15) NULL,
	[PRIXCLIENT] [float] NULL,
	[WIZARD] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[COMMENTAIRE] [nvarchar](3000) NULL,
	[CONFIRMER] [int] NULL,
	[ARTICLE] [nvarchar](50) NULL,
	[TVA] [nvarchar](30) NULL
) ON [PRIMARY]