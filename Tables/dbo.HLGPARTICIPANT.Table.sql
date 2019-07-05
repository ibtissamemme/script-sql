
/****** Object:  Table [dbo].[HLGPARTICIPANT]    Script Date: 05/07/2019 11:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HLGPARTICIPANT](
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
GO
