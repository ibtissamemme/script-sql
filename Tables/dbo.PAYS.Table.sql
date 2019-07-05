
/****** Object:  Table [dbo].[PAYS]    Script Date: 05/07/2019 11:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PAYS](
	[PAYSID] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[LIBELLEGR] [varchar](50) NULL,
	[LIBELLEUS] [varchar](35) NULL,
	[NATIONALITE] [varchar](50) NULL,
	[CODEISO1] [varchar](2) NULL,
	[CODEISO2] [varchar](3) NULL,
	[CODEISO3] [varchar](3) NULL,
	[INDICATIF] [varchar](5) NULL,
	[SHORTLIB] [varchar](3) NULL,
	[DEVISE] [varchar](3) NULL,
	[DEVISELIBELLE] [varchar](35) NULL,
	[INTERDIT] [varchar](1) NULL,
	[DEBUTINTERDIT] [datetime] NULL,
	[FININTERDIT] [datetime] NULL,
	[ENQUETE1] [varchar](10) NULL,
	[STATUT1] [varchar](10) NULL,
	[ENQUETE2] [varchar](10) NULL,
	[STATUT2] [varchar](10) NULL,
	[ENQUETE3] [varchar](10) NULL,
	[STATUT3] [varchar](10) NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[LIBELLE_EN] [varchar](35) NULL,
 CONSTRAINT [PK_PAYSID] PRIMARY KEY CLUSTERED
(
	[PAYSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
