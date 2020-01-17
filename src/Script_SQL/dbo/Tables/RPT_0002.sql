CREATE TABLE [dbo].[RPT_0002](
	[RPT_0002ID] [int] NOT NULL,
	[REF] [nvarchar](20) NULL,
	[VERSION] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[AUTEUR] [nvarchar](30) NULL,
	[EVENEMENT] [nvarchar](50) NULL,
	[SOUSEVENEMENT] [nvarchar](30) NULL,
	[DATEINCIDENT] [datetime] NULL,
	[TITRE] [nvarchar](50) NULL,
	[PERSONNE] [nvarchar](30) NULL,
	[MATERIEL] [nvarchar](30) NULL,
	[SECOURS] [nvarchar](30) NULL,
	[AGENT] [nvarchar](30) NULL,
	[LIEU] [nvarchar](30) NULL,
	[DETAILS1] [nvarchar](200) NULL,
	[DETAILS2] [nvarchar](200) NULL
) ON [PRIMARY]