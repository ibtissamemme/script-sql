CREATE TABLE [dbo].[ZCL09_VISITE](
	[ZCL09_VISITEID] [nvarchar](14) NOT NULL,
	[LIGNE] [nvarchar](300) NULL,
	[STATUT] [int] NULL,
	[SITEID] [nvarchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]