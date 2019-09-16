CREATE TABLE [dbo].[RPT_0002](
	[RPT_0002ID] [int] NOT NULL,
	[REF] [varchar](20) NULL,
	[VERSION] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[AUTEUR] [varchar](30) NULL,
	[EVENEMENT] [varchar](50) NULL,
	[SOUSEVENEMENT] [varchar](30) NULL,
	[DATEINCIDENT] [datetime] NULL,
	[TITRE] [varchar](50) NULL,
	[PERSONNE] [varchar](30) NULL,
	[MATERIEL] [varchar](30) NULL,
	[SECOURS] [varchar](30) NULL,
	[AGENT] [varchar](30) NULL,
	[LIEU] [varchar](30) NULL,
	[DETAILS1] [varchar](200) NULL,
	[DETAILS2] [varchar](200) NULL
) ON [PRIMARY]