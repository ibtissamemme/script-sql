﻿CREATE TABLE [dbo].[CONSIGNE](
	[CONSIGNEID] [varchar](14) NOT NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[RESIDANTID] [varchar](14) NULL,
	[OBJET] [image] NULL,
	[DATELU] [datetime] NULL,
	[OBSERVATION] [image] NULL,
	[STATUTCONSIGNE] [varchar](1) NULL,
	[TYPECONSIGNE] [varchar](35) NULL,
	[TYPECONSIGNEID] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[EMETTEUR_NOM] [varchar](70) NULL,
	[EMETTEUR_PROFIL] [varchar](50) NULL,
	[TYPEOBJET] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CONSIGNEID] PRIMARY KEY CLUSTERED
(
	[CONSIGNEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]