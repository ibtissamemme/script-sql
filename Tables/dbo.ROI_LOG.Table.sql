
/****** Object:  Table [dbo].[ROI_LOG]    Script Date: 05/07/2019 11:18:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROI_LOG](
	[ROI_LOGID] [int] NULL,
	[QUI] [varchar](100) NULL,
	[QUAND] [datetime] NULL,
	[ACTION] [varchar](100) NULL,
	[QUOI] [varchar](100) NULL,
	[BADGE] [varchar](100) NULL,
	[MATRICULE] [varchar](100) NULL,
	[NOM] [varchar](100) NULL,
	[PRENOM] [varchar](100) NULL,
	[SOCIETE] [varchar](100) NULL,
	[SITE] [varchar](100) NULL
) ON [PRIMARY]
GO
