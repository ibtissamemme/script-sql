
/****** Object:  Table [dbo].[LGPARTICIPANT_RESSOURCE]    Script Date: 05/07/2019 11:18:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LGPARTICIPANT_RESSOURCE](
	[LGPARTICIPANTID] [varchar](100) NOT NULL,
	[CODELGRESERVATION] [varchar](14) NULL,
	[RESIDANTID] [varchar](14) NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[CIVILITE] [varchar](14) NULL,
	[NOM] [varchar](35) NULL,
	[PRENOM] [varchar](35) NULL,
	[SOCIETE] [varchar](35) NULL,
	[EMAIL] [varchar](150) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
