CREATE TABLE [dbo].[ETATAPP](
	[ETATID] [nvarchar](50) NOT NULL,
	[ETATNOM] [nvarchar](50) NULL,
	[VISIBLE] [int] NULL,
	[REQUETE] [nvarchar](50) NULL,
	[FILTRE] [nvarchar](250) NULL,
	[APP] [nvarchar](20) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL, 
    CONSTRAINT [PK_ETATAPP] PRIMARY KEY ([ETATID])
) ON [PRIMARY]