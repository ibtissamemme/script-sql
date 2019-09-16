﻿CREATE TABLE [dbo].[OCONS_ETAT](
	[OCONSIGNEID] [int] NOT NULL,
	[LIBELLE] [varchar](500) NULL,
	[PAGE] [int] NULL,
	[ETAT] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_OCONSIGNEEID] PRIMARY KEY CLUSTERED
(
	[OCONSIGNEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]