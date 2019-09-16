CREATE TABLE [dbo].[SN_TRACES](
	[TRACEID] [varchar](14) NOT NULL,
	[SITEID] [varchar](14) NOT NULL,
	[DATEECHECCONNEXION] [datetime] NOT NULL,
	[ADRESSE_IP] [varchar](50) NULL,
	[NOM_MACHINE] [varchar](50) NULL,
	[LOGIN] [varchar](50) NULL,
	[PASSWORD] [varchar](50) NULL,
	[NUMERO] [varchar](50) NULL,
	[TYPE_TRACE] [varchar](50) NULL,
	[CODE] [int] NULL
) ON [PRIMARY]