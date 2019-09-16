﻿CREATE TABLE [dbo].[ZCL15_DEMANDE_LPE](
	[ZCL15_DEMANDE_LPEID] [varchar](14) NOT NULL,
	[CONSIGNE1_ID] [varchar](14) NULL,
	[CONSIGNE2_ID] [varchar](14) NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[EME_SITEID] [varchar](14) NULL,
	[REM_SITEID] [varchar](14) NULL,
	[REC_SITEID] [varchar](14) NULL,
	[LPE_SAISIE_DCS] [datetime] NULL,
	[LPE_SAISIE_CACS] [datetime] NULL,
	[LPE_REMISE] [datetime] NULL,
	[LPE_ENVOI] [datetime] NULL,
	[LPE_INTERDICTION] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ZCL15_DEMANDE_LPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]