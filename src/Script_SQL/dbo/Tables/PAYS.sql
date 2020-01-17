CREATE TABLE [dbo].[PAYS](
	[PAYSID] [nvarchar](14) NOT NULL,
	[LIBELLE] [nvarchar](35) NULL,
	[LIBELLEGR] [nvarchar](50) NULL,
	[LIBELLEUS] [nvarchar](35) NULL,
	[NATIONALITE] [nvarchar](50) NULL,
	[CODEISO1] [nvarchar](2) NULL,
	[CODEISO2] [nvarchar](3) NULL,
	[CODEISO3] [nvarchar](3) NULL,
	[INDICATIF] [nvarchar](5) NULL,
	[SHORTLIB] [nvarchar](3) NULL,
	[DEVISE] [nvarchar](3) NULL,
	[DEVISELIBELLE] [nvarchar](35) NULL,
	[INTERDIT] [nvarchar](1) NULL,
	[DEBUTINTERDIT] [datetime] NULL,
	[FININTERDIT] [datetime] NULL,
	[ENQUETE1] [nvarchar](10) NULL,
	[STATUT1] [nvarchar](10) NULL,
	[ENQUETE2] [nvarchar](10) NULL,
	[STATUT2] [nvarchar](10) NULL,
	[ENQUETE3] [nvarchar](10) NULL,
	[STATUT3] [nvarchar](10) NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[LIBELLE_EN] [nvarchar](35) NULL,
 CONSTRAINT [PK_PAYSID] PRIMARY KEY CLUSTERED
(
	[PAYSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]