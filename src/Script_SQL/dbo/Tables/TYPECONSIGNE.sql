﻿CREATE TABLE [dbo].[TYPECONSIGNE](
	[TYPECONSIGNEID] [int] NOT NULL,
	[TYPECONSIGNE] [varchar](35) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[LIBELLE_EN] [varchar](35) NULL,
 CONSTRAINT [PK_TYPECONSIGNEID] PRIMARY KEY CLUSTERED
(
	[TYPECONSIGNEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]