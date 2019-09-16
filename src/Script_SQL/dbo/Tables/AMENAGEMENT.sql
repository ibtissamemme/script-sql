﻿CREATE TABLE [dbo].[AMENAGEMENT](
	[CODEAMENAGEMENT] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[FIXE] [int] NULL,
	[PLANIMPLANTATION] [image] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[COEFFICIENT] [float] NULL,
	[LIBELLE_EN] [varchar](35) NULL,
 CONSTRAINT [PK_CODEAMENAGEMENT] PRIMARY KEY CLUSTERED
(
	[CODEAMENAGEMENT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]