﻿CREATE TABLE [dbo].[VISITE_REGLE](
	[VISITEID] [nvarchar](14) NOT NULL,
	[REGLEID] [int] NOT NULL,
	[ARBITRAGE] [int] NULL,
	[ACTIONBLOQUANTE] [int] NULL,
	[RANGREGLE] [int] NULL,
	[MES_RESI] [nvarchar](4000) NULL,
	[MES_VALI] [nvarchar](4000) NULL,
	[MES_ACC] [nvarchar](4000) NULL,
	[CATEGORIE] [nvarchar](30) NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_VISREGID] PRIMARY KEY CLUSTERED
(
	[VISITEID] ASC,
	[REGLEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]