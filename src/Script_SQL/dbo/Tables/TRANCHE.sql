﻿CREATE TABLE [dbo].[TRANCHE](
	[CODETRANCHE] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[CODETARIF] [varchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CODETRANCHE] PRIMARY KEY CLUSTERED
(
	[CODETRANCHE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]