﻿CREATE TABLE [dbo].[OFICHIER](
	[OFICHIERID] [int] NOT NULL,
	[LIBELLE] [varchar](200) NULL,
	[DOCUMENT] [image] NULL,
	[TYPEFILE] [int] NULL,
	[CONTENTTYPE] [varchar](100) NULL,
	[DATASIZE] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[OFICHIERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]