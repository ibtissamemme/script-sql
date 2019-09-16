CREATE TABLE [dbo].[PLAT](
	[PLATID] [varchar](14) NOT NULL,
	[NATUREID] [int] NULL,
	[LIBELLEFR] [varchar](200) NULL,
	[LIBELLEEN] [varchar](200) NULL,
	[DESCRIPTIONFR] [varchar](4000) NULL,
	[DESCRIPTIONEN] [varchar](4000) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[image] [image] NULL,
	[COLOR] [varchar](14) NULL,
	[ORDRE] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]