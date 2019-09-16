CREATE TABLE [dbo].[ZCL02_VERSLPM](
	[ZCL02_VERSLPMID] [varchar](14) NOT NULL,
	[FONCTION] [varchar](20) NULL,
	[ID] [varchar](20) NULL,
	[CATEGORIE] [varchar](20) NULL,
	[DEBUT] [varchar](20) NULL,
	[FIN] [varchar](20) NULL,
	[PLAQUE] [varchar](20) NULL,
	[NOM] [varchar](20) NULL,
	[INFO1] [varchar](20) NULL,
	[INFO2] [varchar](20) NULL,
	[INFO3] [varchar](20) NULL,
	[INFO4] [varchar](20) NULL,
	[INFO5] [varchar](20) NULL,
	[ETAT] [int] NULL,
	[LIEN] [varchar](20) NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[ZCL02_VERSLPMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]