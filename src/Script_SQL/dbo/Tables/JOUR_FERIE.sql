﻿CREATE TABLE [dbo].[JOUR_FERIE](
	[JOUR_FERIEID] [int] NOT NULL,
	[LIBELLE] [varchar](100) NULL,
	[DEBUT] [datetime] NULL,
	[FIN] [datetime] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[JOUR_FERIEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]