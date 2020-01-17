﻿CREATE TABLE [dbo].[LICENCE1_LOG](
	[ID_LICENCE1_LOG] [int] IDENTITY(1,1) NOT NULL,
	[NOM_POSTE] [nvarchar](50) NOT NULL,
	[APPLICATION] [nvarchar](20) NOT NULL,
	[ACTION] [nvarchar](50) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
 CONSTRAINT [PK_ID_LICENCE1_LOG] PRIMARY KEY CLUSTERED
(
	[ID_LICENCE1_LOG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]