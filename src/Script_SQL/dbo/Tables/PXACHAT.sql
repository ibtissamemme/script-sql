﻿CREATE TABLE [dbo].[PXACHAT](
	[CODEARTICLE] [nvarchar](14) NOT NULL,
	[SOCIETEID] [nvarchar](14) NOT NULL,
	[REFARTICLE] [nvarchar](15) NULL,
	[PRIXHT] [float] NULL,
	[PRIXCATALOGUE] [float] NULL,
	[ACCEPTABLE] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[CONTACTID] [nvarchar](14) NULL,
 CONSTRAINT [PK_CODEARTICLESOCIETEID] PRIMARY KEY CLUSTERED
(
	[CODEARTICLE] ASC,
	[SOCIETEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]