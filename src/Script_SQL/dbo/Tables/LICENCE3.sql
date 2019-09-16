﻿CREATE TABLE [dbo].[LICENCE3](
	[ID_LICENCE3] [int] IDENTITY(1,1) NOT NULL,
	[LOGIN] [varchar](50) NOT NULL,
	[APPLICATION] [varchar](20) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
 CONSTRAINT [PK_ID_LICENCE3] PRIMARY KEY CLUSTERED
(
	[ID_LICENCE3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]