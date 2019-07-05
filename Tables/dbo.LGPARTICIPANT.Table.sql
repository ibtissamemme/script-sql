
/****** Object:  Table [dbo].[LGPARTICIPANT]    Script Date: 05/07/2019 11:18:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LGPARTICIPANT](
	[LGPARTICIPANTID] [varchar](14) NOT NULL,
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
	[DATESYNCHRO] [datetime] NULL,
	[LGPERSONNETYPE] [varchar](30) NULL,
	[RVEHICULE] [varchar](20) NULL,
	[RIMMAT] [varchar](20) NULL,
	[OPERSONNEID] [varchar](20) NULL,
	[RPHONE] [varchar](20) NULL,
	[RMOBILEPHONE] [varchar](20) NULL,
	[SESA] [varchar](20) NULL
) ON [PRIMARY]
GO
