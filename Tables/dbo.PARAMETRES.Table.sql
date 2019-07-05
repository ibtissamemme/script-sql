
/****** Object:  Table [dbo].[PARAMETRES]    Script Date: 05/07/2019 11:18:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARAMETRES](
	[PREENREG] [int] NULL,
	[SECURITE] [int] NULL,
	[I_PLAN] [int] NULL,
	[IMPRESSION] [int] NULL,
	[INFOBULLES] [int] NULL,
	[CHIMGVT] [varchar](4000) NULL,
	[DATESORTIVI] [datetime] NULL,
	[CHIMGRE] [varchar](4000) NULL,
	[DERNVISITE] [int] NULL,
	[CHIMGPL] [varchar](4000) NULL,
	[SORTIVI] [int] NULL,
	[PURGEVP] [int] NULL,
	[APPETEL] [int] NULL,
	[MONOSOC] [int] NOT NULL,
	[MODULE] [int] NULL,
	[GESPHOTO] [varchar](1) NULL,
	[TRCLUNIK] [int] NULL,
	[TYPEANNU] [varchar](1) NULL,
	[DATEIMP] [datetime] NULL,
	[IMPORTAUTO] [varchar](1) NULL,
	[GESTCASIER] [varchar](1) NULL,
	[NBESSAIS] [int] NOT NULL,
	[REFIMPORTATION] [varchar](48) NULL,
	[SORTIFINVI] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
