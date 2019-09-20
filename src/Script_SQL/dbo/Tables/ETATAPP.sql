CREATE TABLE [dbo].[ETATAPP](
	[ETATID] [varchar](50) NOT NULL,
	[ETATNOM] [varchar](50) NULL,
	[VISIBLE] [int] NULL,
	[REQUETE] [varchar](50) NULL,
	[FILTRE] [varchar](250) NULL,
	[APP] [varchar](20) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL, 
    CONSTRAINT [PK_ETATAPP] PRIMARY KEY ([ETATID])
) ON [PRIMARY]