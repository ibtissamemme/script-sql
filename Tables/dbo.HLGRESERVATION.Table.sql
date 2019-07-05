
/****** Object:  Table [dbo].[HLGRESERVATION]    Script Date: 05/07/2019 11:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HLGRESERVATION](
	[CODERESERVATION] [varchar](14) NULL,
	[CODESALLE] [varchar](14) NULL,
	[CODESTATUT] [varchar](14) NULL,
	[CODELGRESERVATION] [varchar](14) NULL,
	[CODEAMMENAGEMENT] [varchar](14) NULL,
	[DATEDEBUT] [datetime] NULL,
	[DATEFIN] [datetime] NULL,
	[NBJOURS] [int] NULL,
	[PRIX] [float] NULL,
	[CODETYPETARIF] [varchar](14) NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[HEURECONTINU] [int] NULL,
	[REMISE] [float] NULL,
	[LIBELLESALLE] [varchar](35) NULL,
	[NOSALLE] [varchar](15) NULL,
	[PRIXCLIENT] [float] NULL,
	[WIZARD] [int] NULL,
	[CAPACITE] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[AMENAGEMENT] [varchar](35) NULL,
	[TYPETARIF] [varchar](35) NULL,
	[CODESALLEASS] [varchar](14) NULL
) ON [PRIMARY]
GO
