
/****** Object:  Table [dbo].[COLISEMIS]    Script Date: 05/07/2019 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COLISEMIS](
	[COLISID] [varchar](14) NOT NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[RESIDANTID] [varchar](14) NULL,
	[STATUTCOLIS] [varchar](1) NULL,
	[NBCOLIS] [int] NULL,
	[DATEAR] [datetime] NULL,
	[NUMAR] [varchar](20) NULL,
	[LETTRECOLIS] [varchar](1) NULL,
	[TYPEENVOI] [varchar](20) NULL,
	[OBSERVATION] [varchar](4000) NULL,
	[ADRESSEID] [varchar](14) NOT NULL,
	[TICKET] [varchar](50) NULL,
	[POIDS] [varchar](10) NULL,
	[D_ACOURSE] [datetime] NULL,
	[D_ENLPREVU] [datetime] NULL,
	[D_ENLREEL] [datetime] NULL,
	[D_DEPPREVU] [datetime] NULL,
	[D_DEPREELLE] [datetime] NULL,
	[PRIX] [float] NULL,
	[D_APROB] [datetime] NULL,
	[GENRE_PROB] [varchar](14) NULL,
	[GUICHETID] [varchar](14) NULL,
	[ID_STATUTCOLIS] [int] NULL,
	[TRACKING] [varchar](500) NULL,
	[TRACKING_CRM] [varchar](500) NULL,
	[TRACKING_TRANSPORTEUR] [varchar](500) NULL,
	[OFICHIERID] [int] NULL,
	[LIEU] [varchar](50) NULL,
	[SERVICEID] [varchar](14) NULL,
	[NATURECOLISID] [int] NULL,
	[VALEUR] [varchar](10) NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[EMETTEURTYPE] [varchar](15) NULL,
	[CORRESTYPE] [varchar](15) NULL,
 CONSTRAINT [PK_COLISID] PRIMARY KEY CLUSTERED
(
	[COLISID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
