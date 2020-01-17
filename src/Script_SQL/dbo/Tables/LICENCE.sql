﻿CREATE TABLE [dbo].[LICENCE](
	[ID_LICENCE] [int] NOT NULL,
	[CLE] [nvarchar](30) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
 CONSTRAINT [PK_ID_LICENCE] PRIMARY KEY CLUSTERED
(
	[ID_LICENCE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]