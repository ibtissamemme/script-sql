CREATE TABLE [dbo].[LIEU](
	[LIEUID] [int] NOT NULL,
	[LIBELLE] [nvarchar](40) NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[SITEID] [nvarchar](14) NULL, 
    CONSTRAINT [PK_LIEU] PRIMARY KEY ([LIEUID])
) ON [PRIMARY]