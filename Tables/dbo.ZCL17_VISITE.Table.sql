
/****** Object:  Table [dbo].[ZCL17_VISITE]    Script Date: 05/07/2019 11:18:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL17_VISITE](
	[ZCL17_VISITEID] [varchar](14) NOT NULL,
	[ACT] [varchar](14) NULL,
	[NUMERO] [varchar](20) NULL,
	[NOMV] [varchar](35) NULL,
	[PRENOMV] [varchar](35) NULL,
	[SOCIETE] [varchar](35) NULL,
	[NOMR] [varchar](35) NULL,
	[PRENOMR] [varchar](35) NULL,
	[GUICHET] [varchar](40) NULL,
	[PROFIL1] [varchar](35) NULL,
	[PROFIL2] [varchar](35) NULL,
	[PROFIL3] [varchar](35) NULL,
	[PROFIL4] [varchar](35) NULL,
	[DEBUT] [varchar](35) NULL,
	[FIN] [varchar](35) NULL,
	[STATUT] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
