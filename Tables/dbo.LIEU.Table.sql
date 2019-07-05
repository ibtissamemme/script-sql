
/****** Object:  Table [dbo].[LIEU]    Script Date: 05/07/2019 11:18:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIEU](
	[LIEUID] [int] NOT NULL,
	[LIBELLE] [varchar](40) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[SITEID] [varchar](14) NULL
) ON [PRIMARY]
GO
