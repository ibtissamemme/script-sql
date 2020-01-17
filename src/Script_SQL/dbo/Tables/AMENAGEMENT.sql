﻿CREATE TABLE [dbo].[AMENAGEMENT](
	[CODEAMENAGEMENT] [nvarchar](14) NOT NULL,
	[LIBELLE] [nvarchar](35) NULL,
	[FIXE] [int] NULL,
	[PLANIMPLANTATION] [image] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[COEFFICIENT] [float] NULL,
	[LIBELLE_EN] [nvarchar](35) NULL,
 CONSTRAINT [PK_CODEAMENAGEMENT] PRIMARY KEY CLUSTERED
(
	[CODEAMENAGEMENT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]