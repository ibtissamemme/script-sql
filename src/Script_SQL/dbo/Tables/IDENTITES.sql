﻿CREATE TABLE [dbo].[IDENTITES](
	[IDENTITEID] [varchar](14) NOT NULL,
	[TYPEIDENTITEID] [int] NULL,
	[DELIVREPAR] [varchar](80) NULL,
	[FINVALIDITE] [datetime] NULL,
	[NUMERO] [varchar](20) NULL,
	[IMAGE] [image] NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[OFICHIERID] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_IDENTITEID] PRIMARY KEY CLUSTERED
(
	[IDENTITEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]