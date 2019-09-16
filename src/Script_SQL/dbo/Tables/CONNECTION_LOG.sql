﻿CREATE TABLE [dbo].[CONNECTION_LOG](
	[ID_CONNECTION_LOG] [int] IDENTITY(1,1) NOT NULL,
	[LOGIN] [varchar](50) NOT NULL,
	[APPLICATION] [varchar](100) NOT NULL,
	[ACTION] [varchar](500) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
 CONSTRAINT [PK_ID_CONNECTION_LOG] PRIMARY KEY CLUSTERED
(
	[ID_CONNECTION_LOG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]