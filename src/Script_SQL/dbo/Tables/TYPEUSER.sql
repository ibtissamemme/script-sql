CREATE TABLE [dbo].[TYPEUSER](
	[USERID] [int] NULL,
	[LIBELLE] [varchar](50) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]