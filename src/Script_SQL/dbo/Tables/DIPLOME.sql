CREATE TABLE [dbo].[DIPLOME](
	[DIPLOMEID] [int] NOT NULL,
	[PERSONNELID] [int] NULL,
	[LIBELLE] [nvarchar](40) NULL,
	[OBTENTION] [datetime] NULL,
	[RENOUVELLEMENT] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]