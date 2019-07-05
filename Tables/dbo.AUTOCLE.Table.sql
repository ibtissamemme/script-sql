
/****** Object:  Table [dbo].[AUTOCLE]    Script Date: 05/07/2019 11:18:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AUTOCLE](
	[CLEID] [varchar](14) NULL,
	[INDIVIDUID] [varchar](15) NULL,
	[NOM] [varchar](100) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
