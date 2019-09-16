CREATE TABLE [dbo].[MENU](
	[MENUID] [varchar](14) NOT NULL,
	[LIBELLEFR] [varchar](200) NULL,
	[LIBELLEEN] [varchar](200) NULL,
	[DESCRIPTIONFR] [varchar](4000) NULL,
	[DESCRIPTIONEN] [varchar](4000) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[ORDRE] [int] NULL
) ON [PRIMARY]