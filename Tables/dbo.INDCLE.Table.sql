
/****** Object:  Table [dbo].[INDCLE]    Script Date: 05/07/2019 11:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INDCLE](
	[CLEID] [varchar](14) NULL,
	[INDIVIDUID] [varchar](15) NULL,
	[RESERVANTID] [varchar](15) NULL,
	[INDIVIDU] [varchar](100) NULL,
	[RESERVANT] [varchar](100) NULL,
	[UTILISATEURID] [varchar](100) NULL,
	[JOUR_DEPART] [datetime] NULL,
	[JOUR_RETOUR] [datetime] NULL,
	[ETAT] [int] NULL,
	[OBSERVATIONSALLER] [varchar](2000) NULL,
	[OBSERVATIONSRETOUR] [varchar](2000) NULL,
	[NEMPRUNT] [int] NULL,
	[SIGNATURE_ENTREE] [int] NULL,
	[SIGNATURE_SORTIE] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
