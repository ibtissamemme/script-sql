
/****** Object:  Table [dbo].[SN_SITE_ACTION]    Script Date: 05/07/2019 11:18:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SN_SITE_ACTION](
	[SITEID] [varchar](14) NOT NULL,
	[ACTION] [varchar](50) NOT NULL,
	[DATEMAJ] [datetime] NULL,
	[NOM_TABLE] [varchar](50) NULL,
	[ID] [varchar](50) NULL
) ON [PRIMARY]
GO
