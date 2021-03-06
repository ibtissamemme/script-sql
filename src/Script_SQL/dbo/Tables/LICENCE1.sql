﻿CREATE TABLE [dbo].[LICENCE1](
	[ID_LICENCE1] [int] IDENTITY(1,1) NOT NULL,
	[NOM_POSTE] [varchar](24) NOT NULL,
	[LOGIN] [varchar](50) NOT NULL,
	[APPLICATION] [varchar](20) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
 CONSTRAINT [PK_ID_LICENCE1] PRIMARY KEY CLUSTERED
(
	[ID_LICENCE1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]