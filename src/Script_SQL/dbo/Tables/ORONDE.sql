﻿CREATE TABLE [dbo].[ORONDE](
	[ORONDEID] [int] NOT NULL,
	[RONDIERID] [int] NULL,
	[RONDIERLIB] [varchar](50) NULL,
	[RONDENUM] [int] NULL,
	[RONDELIB] [varchar](50) NULL,
	[SITEID] [varchar](14) NULL,
	[RONDEDATE] [datetime] NULL,
	[DETAILS] [varchar](4000) NULL,
	[ETAT] [int] NULL,
	[RONDEAGENT] [varchar](50) NULL,
	[AGENTID] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ORONDEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]