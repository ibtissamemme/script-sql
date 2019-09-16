﻿CREATE TABLE [dbo].[ARTICLEDEFAULT](
	[CODEARTICLEDEFAULT] [varchar](14) NOT NULL,
	[CODETYPEDEFAULT] [varchar](14) NULL,
	[CODEARTICLE] [varchar](14) NULL,
	[QUANTITE] [int] NULL,
	[SORTORDER] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CODEARTICLEDEFAULT] PRIMARY KEY CLUSTERED
(
	[CODEARTICLEDEFAULT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]