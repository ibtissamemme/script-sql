﻿CREATE TABLE [dbo].[VEHICULE_DEMANDE](
	[VEHICULEID] [varchar](14) NULL,
	[RESIDANTID] [varchar](14) NULL,
	[DATEDEMANDE] [datetime] NULL,
	[IMMATRICULATION] [varchar](14) NULL,
	[MARQUE] [varchar](20) NULL,
	[MODELE] [varchar](40) NULL,
	[COTE] [int] NULL,
	[STATUT] [varchar](40) NULL,
	[DATECREATION] [datetime] NULL
) ON [PRIMARY]