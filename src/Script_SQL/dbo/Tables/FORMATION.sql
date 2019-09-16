CREATE TABLE [dbo].[FORMATION](
	[FORMATIONID] [int] NOT NULL,
	[PERSONNELID] [int] NULL,
	[LIBELLE] [varchar](40) NULL,
	[DATE_DEBUT] [datetime] NULL,
	[DATE_FIN] [datetime] NULL,
	[INSTRUCTEUR] [varchar](40) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]