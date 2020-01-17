﻿CREATE TABLE [dbo].[ZCL17_VISITE](
	[ZCL17_VISITEID] [nvarchar](14) NOT NULL,
	[ACT] [nvarchar](14) NULL,
	[NUMERO] [nvarchar](20) NULL,
	[NOMV] [nvarchar](35) NULL,
	[PRENOMV] [nvarchar](35) NULL,
	[SOCIETE] [nvarchar](35) NULL,
	[NOMR] [nvarchar](35) NULL,
	[PRENOMR] [nvarchar](35) NULL,
	[GUICHET] [nvarchar](40) NULL,
	[PROFIL1] [nvarchar](35) NULL,
	[PROFIL2] [nvarchar](35) NULL,
	[PROFIL3] [nvarchar](35) NULL,
	[PROFIL4] [nvarchar](35) NULL,
	[DEBUT] [nvarchar](35) NULL,
	[FIN] [nvarchar](35) NULL,
	[STATUT] [int] NULL,
	[SITEID] [nvarchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]