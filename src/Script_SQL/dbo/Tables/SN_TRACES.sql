CREATE TABLE [dbo].[SN_TRACES](
	[TRACEID] [nvarchar](14) NOT NULL,
	[SITEID] [nvarchar](14) NOT NULL,
	[DATEECHECCONNEXION] [datetime] NOT NULL,
	[ADRESSE_IP] [nvarchar](50) NULL,
	[NOM_MACHINE] [nvarchar](50) NULL,
	[LOGIN] [nvarchar](50) NULL,
	[PASSWORD] [nvarchar](50) NULL,
	[NUMERO] [nvarchar](50) NULL,
	[TYPE_TRACE] [nvarchar](50) NULL,
	[CODE] [int] NULL
) ON [PRIMARY]