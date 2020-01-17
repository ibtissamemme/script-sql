CREATE TABLE [dbo].[INDCLE](
	[CLEID] [nvarchar](14) NULL,
	[INDIVIDUID] [nvarchar](15) NULL,
	[RESERVANTID] [nvarchar](15) NULL,
	[INDIVIDU] [nvarchar](100) NULL,
	[RESERVANT] [nvarchar](100) NULL,
	[UTILISATEURID] [nvarchar](100) NULL,
	[JOUR_DEPART] [datetime] NULL,
	[JOUR_RETOUR] [datetime] NULL,
	[ETAT] [int] NULL,
	[OBSERVATIONSALLER] [nvarchar](2000) NULL,
	[OBSERVATIONSRETOUR] [nvarchar](2000) NULL,
	[NEMPRUNT] [int] NULL,
	[SIGNATURE_ENTREE] [int] NULL,
	[SIGNATURE_SORTIE] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]