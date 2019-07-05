
/****** Object:  Table [dbo].[IMPORT_RESA]    Script Date: 05/07/2019 11:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IMPORT_RESA](
	[ID] [varchar](18) NULL,
	[DATESAISIE] [varchar](30) NULL,
	[RNOM] [varchar](30) NULL,
	[RPRENOM] [varchar](30) NULL,
	[RMATRICULE] [varchar](30) NULL,
	[INOM] [varchar](30) NULL,
	[IPRENOM] [varchar](30) NULL,
	[IMATRICULE] [varchar](30) NULL,
	[SALLE] [varchar](30) NULL,
	[DATERESA] [varchar](30) NULL,
	[HDEBUT] [varchar](30) NULL,
	[HFIN] [varchar](30) NULL,
	[STATUT] [varchar](30) NULL,
	[ROBSERVATION] [varchar](3000) NULL,
	[REFVISITOR] [varchar](30) NULL,
	[USERLOGIN] [varchar](30) NULL
) ON [PRIMARY]
GO
