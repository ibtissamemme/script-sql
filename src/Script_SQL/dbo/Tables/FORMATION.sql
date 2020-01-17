CREATE TABLE [dbo].[FORMATION](
	[FORMATIONID] [int] NOT NULL,
	[PERSONNELID] [int] NULL,
	[LIBELLE] [nvarchar](40) NULL,
	[DATE_DEBUT] [datetime] NULL,
	[DATE_FIN] [datetime] NULL,
	[INSTRUCTEUR] [nvarchar](40) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]