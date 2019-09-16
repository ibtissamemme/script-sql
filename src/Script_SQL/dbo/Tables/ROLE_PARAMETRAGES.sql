﻿CREATE TABLE [dbo].[ROLE_PARAMETRAGES](
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