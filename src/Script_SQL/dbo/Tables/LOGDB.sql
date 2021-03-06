﻿CREATE TABLE [dbo].[LOGDB](
	[LOGDBID] [int] IDENTITY(1,1) NOT NULL,
	[QUI] [varchar](50) NULL,
	[IP] [varchar](50) NULL,
	[URL] [varchar](250) NULL,
	[QUAND] [datetime] NULL,
	[REQUETE] [varchar](4000) NULL,
	[LATABLE] [varchar](100) NULL,
	[ACTION] [varchar](100) NULL,
	[ID] [varchar](100) NULL,
	[DONNEES] [varchar](4000) NULL,
	[SITE] [varchar](50) NULL,
	[POSTE] [varchar](50) NULL,
PRIMARY KEY CLUSTERED
(
	[LOGDBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]