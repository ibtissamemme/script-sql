CREATE TABLE [dbo].[ZCL02_VERSLPM](
	[ZCL02_VERSLPMID] [nvarchar](14) NOT NULL,
	[FONCTION] [nvarchar](20) NULL,
	[ID] [nvarchar](20) NULL,
	[CATEGORIE] [nvarchar](20) NULL,
	[DEBUT] [nvarchar](20) NULL,
	[FIN] [nvarchar](20) NULL,
	[PLAQUE] [nvarchar](20) NULL,
	[NOM] [nvarchar](20) NULL,
	[INFO1] [nvarchar](20) NULL,
	[INFO2] [nvarchar](20) NULL,
	[INFO3] [nvarchar](20) NULL,
	[INFO4] [nvarchar](20) NULL,
	[INFO5] [nvarchar](20) NULL,
	[ETAT] [int] NULL,
	[LIEN] [nvarchar](20) NULL,
	[SITEID] [nvarchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[ZCL02_VERSLPMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]