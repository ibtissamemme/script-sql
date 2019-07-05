
/****** Object:  Table [dbo].[CFG_FICHIER]    Script Date: 05/07/2019 11:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CFG_FICHIER](
	[CFG_FICHIERID] [int] NOT NULL,
	[TYPECFG] [varchar](20) NULL,
	[LIBELLE] [varchar](200) NULL,
	[DOCUMENT1] [varchar](4000) NULL,
	[DOCUMENT2] [varchar](4000) NULL,
	[DOCUMENT] [image] NULL,
	[TYPEFILE] [int] NULL,
	[CONTENTTYPE] [varchar](50) NULL,
	[DATASIZE] [int] NULL,
	[STATUT] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[CFG_FICHIERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[CFG_FICHIER] ADD  DEFAULT ((1)) FOR [STATUT]
GO
