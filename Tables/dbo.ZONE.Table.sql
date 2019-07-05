
/****** Object:  Table [dbo].[ZONE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZONE](
	[ZONEID] [varchar](14) NOT NULL,
	[ZONENOM] [varchar](20) NULL,
	[ZONERESPONSABLE] [varchar](30) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
