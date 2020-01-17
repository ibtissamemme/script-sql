CREATE TABLE [dbo].[ZCL18_VISITES](
	[ID] [nvarchar](14) NULL,
	[ACTION] [nvarchar](3) NULL,
	[BADGE] [nvarchar](10) NULL,
	[NOMVIS] [nvarchar](50) NULL,
	[PRENOMVIS] [nvarchar](50) NULL,
	[SOCVIS] [nvarchar](50) NULL,
	[STATUT] [nvarchar](50) NULL,
	[IMMATR] [nvarchar](50) NULL,
	[DEBUT] [datetime] NULL,
	[FIN] [datetime] NULL,
	[MATRICULE] [nvarchar](50) NULL,
	[NOMRES] [nvarchar](50) NULL,
	[PRENOMRES] [nvarchar](50) NULL,
	[TELRES] [nvarchar](50) NULL,
	[BUREAU] [nvarchar](50) NULL,
	[SITE] [nvarchar](50) NULL,
	[PROFIL] [nvarchar](50) NULL,
	[GUICHET] [nvarchar](50) NULL,
	[UTILISATEUR] [nvarchar](50) NULL,
	[LECTEUR] [nvarchar](50) NULL,
	[SORTIE_AVALEUSE] [int] NULL,
	[ETAT] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZCL18_VISITES] ADD  DEFAULT ((0)) FOR [SORTIE_AVALEUSE]
GO
ALTER TABLE [dbo].[ZCL18_VISITES] ADD  DEFAULT ((0)) FOR [ETAT]