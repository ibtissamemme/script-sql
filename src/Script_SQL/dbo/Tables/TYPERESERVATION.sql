﻿CREATE TABLE [dbo].[TYPERESERVATION](
	[CODETYPERESERVATION] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[LIBELLE_EN] [varchar](35) NULL,
 CONSTRAINT [PK_CODETYPERESERVATION] PRIMARY KEY CLUSTERED
(
	[CODETYPERESERVATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]