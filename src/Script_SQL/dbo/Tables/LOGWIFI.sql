﻿CREATE TABLE [dbo].[LOGWIFI](
	[LOGWIFIID] [int] IDENTITY(1,1) NOT NULL,
	[VISITEID] [varchar](15) NULL,
	[SITEID] [varchar](15) NULL,
	[WIFI_LOGIN] [varchar](50) NULL,
	[WIFI_PWD] [varchar](50) NULL,
	[WIFI_ETAT] [varchar](50) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_LOGWIFIID] PRIMARY KEY CLUSTERED
(
	[LOGWIFIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]