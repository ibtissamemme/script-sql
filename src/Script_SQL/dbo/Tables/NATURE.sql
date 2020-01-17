﻿CREATE TABLE [dbo].[NATURE](
	[NATUREID] [nvarchar](14) NOT NULL,
	[LIBELLE] [nvarchar](35) NULL,
	[ABREGE] [nvarchar](6) NULL,
	[TVISITE] [nvarchar](1) NULL,
	[PROFIL] [nvarchar](20) NULL,
	[INTERDIT] [nvarchar](1) NULL,
	[DEBUTINTERDIT] [datetime] NULL,
	[FININTERDIT] [datetime] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[LIBELLE_EN] [nvarchar](35) NULL,
 CONSTRAINT [PK_NATUREID] PRIMARY KEY CLUSTERED
(
	[NATUREID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]