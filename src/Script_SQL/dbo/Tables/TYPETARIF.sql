CREATE TABLE [dbo].[TYPETARIF](
	[CODETYPETARIF] [varchar](24) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[COEFICIENT] [float] NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]