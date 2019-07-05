
/****** Object:  Table [dbo].[TRACE_ACTION]    Script Date: 05/07/2019 11:18:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRACE_ACTION](
	[TRACE_ACTIONID] [varchar](14) NOT NULL,
	[USERID] [varchar](14) NULL,
	[NOMPRENOMUSER] [varchar](70) NULL,
	[SITEID] [varchar](14) NULL,
	[SITE] [varchar](35) NULL,
	[ACTION] [varchar](50) NULL,
	[LIEU] [varchar](50) NULL,
	[DETAILS] [varchar](1000) NULL,
	[GENERIQUEID] [varchar](14) NULL,
	[GENERIQUETABLE] [varchar](50) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
