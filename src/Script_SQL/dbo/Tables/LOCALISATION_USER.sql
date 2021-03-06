﻿CREATE TABLE [dbo].[LOCALISATION_USER](
	[LOCALISATIONID] [int] NOT NULL,
	[USERID] [varchar](14) NOT NULL,
 CONSTRAINT [PK_LOCALISATION_USER] PRIMARY KEY CLUSTERED
(
	[USERID] ASC,
	[LOCALISATIONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]