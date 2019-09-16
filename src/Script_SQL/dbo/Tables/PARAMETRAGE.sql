﻿CREATE TABLE [dbo].[PARAMETRAGE](
	[LIBELLE] [varchar](50) NOT NULL,
	[VALEUR] [varchar](max) NULL,
	[SITEID] [varchar](14) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PARAMETRAGE_PK] PRIMARY KEY CLUSTERED
(
	[LIBELLE] ASC,
	[SITEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]