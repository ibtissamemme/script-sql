
/****** Object:  Table [dbo].[CFGGSALLESDEFAULT]    Script Date: 05/07/2019 11:18:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CFGGSALLESDEFAULT](
	[CODETYPERESERVATION] [varchar](14) NULL,
	[CODESTATUT] [varchar](14) NULL,
	[CODEAMMENAGEMENT] [varchar](14) NULL,
	[CODETYPETARIF] [varchar](14) NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[PREPARATIONDEFAUT] [datetime] NULL,
	[RANGEMENTDEFAUT] [datetime] NULL
) ON [PRIMARY]
GO
