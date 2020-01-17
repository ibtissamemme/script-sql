CREATE TABLE [dbo].[TRACE_ACTION](
	[TRACE_ACTIONID] [nvarchar](14) NOT NULL,
	[USERID] [nvarchar](14) NULL,
	[NOMPRENOMUSER] [nvarchar](70) NULL,
	[SITEID] [nvarchar](14) NULL,
	[SITE] [nvarchar](35) NULL,
	[ACTION] [nvarchar](50) NULL,
	[LIEU] [nvarchar](50) NULL,
	[DETAILS] [nvarchar](1000) NULL,
	[GENERIQUEID] [nvarchar](14) NULL,
	[GENERIQUETABLE] [nvarchar](50) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]