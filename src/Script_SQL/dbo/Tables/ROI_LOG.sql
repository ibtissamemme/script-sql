CREATE TABLE [dbo].[ROI_LOG](
	[ROI_LOGID] [int] NOT NULL,
	[QUI] [varchar](100) NULL,
	[QUAND] [datetime] NULL,
	[ACTION] [varchar](100) NULL,
	[QUOI] [varchar](100) NULL,
	[BADGE] [varchar](100) NULL,
	[MATRICULE] [varchar](100) NULL,
	[NOM] [varchar](100) NULL,
	[PRENOM] [varchar](100) NULL,
	[SOCIETE] [varchar](100) NULL,
	[SITE] [varchar](100) NULL, 
    CONSTRAINT [PK_ROI_LOG] PRIMARY KEY ([ROI_LOGID])
) ON [PRIMARY]