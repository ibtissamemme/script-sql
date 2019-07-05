
/****** Object:  Table [dbo].[RPT_SEM5]    Script Date: 05/07/2019 11:18:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RPT_SEM5](
	[RPT_SEM5ID] [int] NOT NULL,
	[REF] [varchar](20) NULL,
	[VERSION] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[AUTEUR] [varchar](30) NULL,
	[REPRESENTANT] [varchar](30) NULL,
	[RAISONSOC] [varchar](30) NULL,
	[SELECTDATE] [datetime] NULL,
	[HEUREDEB] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[BATIMENT] [varchar](35) NULL,
	[RUE] [varchar](60) NULL,
	[SECTEUR] [varchar](40) NULL,
	[BAT] [varchar](10) NULL,
	[ORGANEAT] [varchar](30) NULL,
	[OPERATION] [varchar](30) NULL,
	[AGENT] [varchar](30) NULL,
	[OPERATEUR] [varchar](30) NULL,
	[AUXILIAIRE] [varchar](30) NULL,
	[CONSIGNE] [varchar](240) NULL,
	[RISQUE] [varchar](240) NULL,
	[MOYEN] [varchar](240) NULL,
	[MOYENA] [varchar](50) NULL,
	[MOYENI] [varchar](50) NULL,
	[SITEID] [varchar](14) NULL
) ON [PRIMARY]
GO
