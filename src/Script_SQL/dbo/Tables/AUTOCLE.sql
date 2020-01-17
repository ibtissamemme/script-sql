CREATE TABLE [dbo].[AUTOCLE](
	[CLEID] [nvarchar](14) NULL,
	[INDIVIDUID] [nvarchar](15) NULL,
	[NOM] [nvarchar](100) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]