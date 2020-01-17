﻿CREATE TABLE [dbo].[OMESSAGE](
	[OMESSAGEID] [int] NOT NULL,
	[AGENTID] [int] NULL,
	[DATERAPPEL] [datetime] NULL,
	[DATEFIN] [datetime] NULL,
	[ETAT] [int] NULL,
	[MESSAGE] [nvarchar](1000) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[SITEID] [nvarchar](14) NULL,
	[POSTEID] [int] NULL,
 CONSTRAINT [PK_OMESSAGEID] PRIMARY KEY CLUSTERED
(
	[OMESSAGEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]