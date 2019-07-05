
/****** Object:  Table [dbo].[CFGETAT]    Script Date: 05/07/2019 11:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CFGETAT](
	[CFGETATID] [varchar](50) NULL,
	[ETATNOM] [varchar](50) NULL,
	[VISIBLE] [int] NULL,
	[REQUETE] [varchar](50) NULL,
	[FILTRE] [varchar](250) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]
GO
