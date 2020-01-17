CREATE TABLE [dbo].[MARCHE](
	[MARCHEID] [nvarchar](14) NOT NULL,
	[MARCHE] [nvarchar](120) NULL,
	[OBJET] [nvarchar](250) NULL,
	[MANDATAIRE] [nvarchar](35) NULL,
	[MANDATAIREID] [nvarchar](14) NULL,
	[RANG] [nvarchar](20) NULL,
	[FINPREVUE] [datetime] NULL,
	[CSPS] [datetime] NULL,
	[INSPECCOMMUNE] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL, 
    CONSTRAINT [PK_MARCHE] PRIMARY KEY ([MARCHEID])
) ON [PRIMARY]