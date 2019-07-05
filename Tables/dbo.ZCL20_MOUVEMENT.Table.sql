
/****** Object:  Table [dbo].[ZCL20_MOUVEMENT]    Script Date: 05/07/2019 11:18:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL20_MOUVEMENT](
	[ID] [varchar](14) NULL,
	[VISITEID] [varchar](14) NULL,
	[TYPE_ENREG] [varchar](20) NULL,
	[ENTREE_PARKING] [datetime] NULL,
	[VISITEUR] [varchar](70) NULL,
	[VISITEUR_SOCIETE] [varchar](70) NULL,
	[RESIDANT] [varchar](70) NULL,
	[RESIDANT_TROUVE] [varchar](1) NULL,
	[IMMATRICULATION] [varchar](15) NULL,
	[SORTIE_PARKING] [datetime] NULL,
	[REF_PARKING] [varchar](20) NULL,
	[POSTE_SAISIE] [varchar](20) NULL,
	[USER_TQ] [varchar](35) NULL,
	[OBSERVATION] [varchar](200) NULL,
	[SITEID] [varchar](35) NULL,
	[SITE] [varchar](35) NULL,
	[DATECREATION] [datetime] NULL
) ON [PRIMARY]
GO
