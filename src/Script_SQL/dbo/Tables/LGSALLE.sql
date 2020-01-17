﻿CREATE TABLE [dbo].[LGSALLE](
	[CODESALLE] [nvarchar](14) NOT NULL,
	[CODEEQUIPEMENTFIXE] [nvarchar](14) NOT NULL,
	[QUANTITE] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CODESALLEEQUIPEMENTFIXE] PRIMARY KEY CLUSTERED
(
	[CODESALLE] ASC,
	[CODEEQUIPEMENTFIXE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]