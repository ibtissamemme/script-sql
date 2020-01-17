CREATE TABLE [dbo].[ROI_LOG](
	[ROI_LOGID] [int] NOT NULL,
	[QUI] [nvarchar](100) NULL,
	[QUAND] [datetime] NULL,
	[ACTION] [nvarchar](100) NULL,
	[QUOI] [nvarchar](100) NULL,
	[BADGE] [nvarchar](100) NULL,
	[MATRICULE] [nvarchar](100) NULL,
	[NOM] [nvarchar](100) NULL,
	[PRENOM] [nvarchar](100) NULL,
	[SOCIETE] [nvarchar](100) NULL,
	[SITE] [nvarchar](100) NULL, 
    CONSTRAINT [PK_ROI_LOG] PRIMARY KEY ([ROI_LOGID])
) ON [PRIMARY]