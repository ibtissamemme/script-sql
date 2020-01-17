﻿CREATE TABLE [dbo].[GRPUSER_TYPEDOCUMENT](
	[GRPUSERID] [nvarchar](14) NOT NULL,
	[TYPEDOCUMENTID] [int] NOT NULL,
 CONSTRAINT [PK_GRPUSER_TYPDOC] PRIMARY KEY CLUSTERED
(
	[GRPUSERID] ASC,
	[TYPEDOCUMENTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]