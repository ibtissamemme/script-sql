
/****** Object:  Table [dbo].[ETATAPP]    Script Date: 05/07/2019 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETATAPP](
	[ETATID] [varchar](50) NULL,
	[ETATNOM] [varchar](50) NULL,
	[VISIBLE] [int] NULL,
	[REQUETE] [varchar](50) NULL,
	[FILTRE] [varchar](250) NULL,
	[APP] [varchar](20) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]
GO
