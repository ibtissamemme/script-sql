
/****** Object:  Table [dbo].[ROLE_PARAMETRAGES]    Script Date: 05/07/2019 11:18:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE_PARAMETRAGES](
	[USERID] [int] NULL,
	[PARAMETRAGES_GENERAUX] [int] NULL,
	[PERIPHERIQUES] [int] NULL,
	[PRESENTATION] [int] NULL,
	[OPTIONS] [int] NULL,
	[BADGES] [int] NULL,
	[PARAM_ETATS] [int] NULL,
	[CTRL_ACCES] [int] NULL,
	[ES_VEHICULE] [int] NULL,
	[PARAMETRAGES_CHAMPS] [int] NULL,
	[AUTORISATION_ACCES] [int] NULL,
	[REGLES] [int] NULL,
	[ENVOI_MAIL] [int] NULL,
	[PROFIL_ACCUEIL] [int] NULL,
	[CHAMPS_VISITEUR] [varchar](4000) NULL,
	[SECOND_ACCUEIL] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]
GO
