CREATE TABLE [dbo].[ZCL09_VISITE](
	[ZCL09_VISITEID] [varchar](14) NOT NULL,
	[LIGNE] [varchar](300) NULL,
	[STATUT] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]