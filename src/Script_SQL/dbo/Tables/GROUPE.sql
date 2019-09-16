﻿CREATE TABLE [dbo].[GROUPE](
	[GROUPEID] [varchar](14) NOT NULL,
	[EXTERNALID] [varchar](24) NULL,
	[GROUPE] [varchar](80) NULL,
	[ADRESSE] [image] NULL,
	[CODEPOSTAL] [varchar](10) NULL,
	[VILLE] [varchar](40) NULL,
	[PROVINCE] [varchar](35) NULL,
	[PAYS] [varchar](35) NULL,
	[INTERDIT] [varchar](1) NULL,
	[DEBUTINTERDIT] [datetime] NULL,
	[FININTERDIT] [datetime] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_GROUPEID] PRIMARY KEY CLUSTERED
(
	[GROUPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]