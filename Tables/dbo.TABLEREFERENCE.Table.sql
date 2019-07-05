
/****** Object:  Table [dbo].[TABLEREFERENCE]    Script Date: 05/07/2019 11:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLEREFERENCE](
	[TABLEREFERENCEID] [int] NULL,
	[ID] [int] NULL,
	[VALEUR] [int] NULL,
	[TEXTE] [varchar](100) NULL,
	[TEXTE_FR] [varchar](100) NULL,
	[TEXTE_EN] [varchar](100) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
