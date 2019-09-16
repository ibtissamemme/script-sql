﻿CREATE TABLE [dbo].[HLGPARTICIPANT](
	[LGPARTICIPANTID] [varchar](14) NULL,
	[CODELGRESERVATION] [varchar](14) NULL,
	[RESIDANTID] [varchar](14) NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[CIVILITE] [varchar](14) NULL,
	[NOM] [varchar](35) NULL,
	[PRENOM] [varchar](35) NULL,
	[SOCIETE] [varchar](35) NULL,
	[EMAIL] [varchar](50) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]