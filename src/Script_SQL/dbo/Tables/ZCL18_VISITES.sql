CREATE TABLE [dbo].[ZCL18_VISITES](
	[ID] [varchar](14) NULL,
	[ACTION] [varchar](3) NULL,
	[BADGE] [varchar](10) NULL,
	[NOMVIS] [varchar](50) NULL,
	[PRENOMVIS] [varchar](50) NULL,
	[SOCVIS] [varchar](50) NULL,
	[STATUT] [varchar](50) NULL,
	[IMMATR] [varchar](50) NULL,
	[DEBUT] [datetime] NULL,
	[FIN] [datetime] NULL,
	[MATRICULE] [varchar](50) NULL,
	[NOMRES] [varchar](50) NULL,
	[PRENOMRES] [varchar](50) NULL,
	[TELRES] [varchar](50) NULL,
	[BUREAU] [varchar](50) NULL,
	[SITE] [varchar](50) NULL,
	[PROFIL] [varchar](50) NULL,
	[GUICHET] [varchar](50) NULL,
	[UTILISATEUR] [varchar](50) NULL,
	[LECTEUR] [varchar](50) NULL,
	[SORTIE_AVALEUSE] [int] NULL,
	[ETAT] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZCL18_VISITES] ADD  DEFAULT ((0)) FOR [SORTIE_AVALEUSE]
GO
ALTER TABLE [dbo].[ZCL18_VISITES] ADD  DEFAULT ((0)) FOR [ETAT]