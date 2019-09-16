﻿CREATE TABLE [dbo].[CORRESPONDANCE](
	[CORRESID] [int] NOT NULL,
	[LIBSSRC] [varchar](240) NULL,
	[RANGSSRC] [varchar](20) NULL,
	[LIBDST] [varchar](80) NULL,
	[CFG_FICHIERID] [int] NULL,
	[CORRES_RANG] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[CORRESID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]