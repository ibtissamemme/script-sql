
/****** Object:  Table [dbo].[VISITE_REGLE]    Script Date: 05/07/2019 11:18:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VISITE_REGLE](
	[VISITEID] [varchar](14) NOT NULL,
	[REGLEID] [int] NOT NULL,
	[ARBITRAGE] [int] NULL,
	[ACTIONBLOQUANTE] [int] NULL,
	[RANGREGLE] [int] NULL,
	[MES_RESI] [varchar](4000) NULL,
	[MES_VALI] [varchar](4000) NULL,
	[MES_ACC] [varchar](4000) NULL,
	[CATEGORIE] [varchar](30) NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_VISREGID] PRIMARY KEY CLUSTERED
(
	[VISITEID] ASC,
	[REGLEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
