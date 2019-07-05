
/****** Object:  Table [dbo].[HLGPA]    Script Date: 05/07/2019 11:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HLGPA](
	[CODERESERVATION] [varchar](14) NULL,
	[CODELGRESERVATION] [varchar](14) NULL,
	[CODESALLE] [varchar](14) NULL,
	[CODELGPA] [varchar](14) NULL,
	[CODEARTICLE] [varchar](14) NULL,
	[DATEDEBUT] [datetime] NULL,
	[DATEFIN] [datetime] NULL,
	[QUANTITE] [float] NULL,
	[PRIX] [float] NULL,
	[CODETVA] [varchar](14) NULL,
	[TAUXTVA] [float] NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[HEURECONTINU] [int] NULL,
	[REMISE] [float] NULL,
	[LIBELLESALLE] [varchar](35) NULL,
	[NOSALLE] [varchar](15) NULL,
	[PRIXCLIENT] [float] NULL,
	[WIZARD] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[COMMENTAIRE] [varchar](3000) NULL,
	[CONFIRMER] [int] NULL,
	[ARTICLE] [varchar](50) NULL,
	[TVA] [varchar](30) NULL
) ON [PRIMARY]
GO
