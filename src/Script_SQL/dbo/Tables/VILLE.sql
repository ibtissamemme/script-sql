﻿CREATE TABLE [dbo].[VILLE](
	[CODEVILLE] [varchar](14) NOT NULL,
	[CODEPOSTAL] [varchar](5) NULL,
	[PHONKEY] [varchar](35) NULL,
	[VILLE] [varchar](35) NULL,
	[PAYSID] [varchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_CODEVILLE] PRIMARY KEY CLUSTERED
(
	[CODEVILLE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]