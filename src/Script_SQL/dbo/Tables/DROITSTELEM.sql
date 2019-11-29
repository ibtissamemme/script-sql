﻿CREATE TABLE [dbo].[DROITSTELEM](
	[ID_DROITSTELEM] [int] NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[DROITS] [varchar](1000) NULL,
	[SITE_RESIDANT] [int] NULL,
	[SITE_PREENREG] [int] NULL,
	[VISITEUR] [varchar](500) NULL,
	[TIMEOUT] [int] NULL,
	[GRPVALIDEURID] [int] NULL,
	[ETRANGER] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ID_DROITSTELEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DROITSTELEM] ADD  DEFAULT ((0)) FOR [ETRANGER]