﻿CREATE TABLE [dbo].[FORMULAIRE_OFICHIER](
	[FORMULAIREID] [int] NOT NULL,
	[OFICHIERID] [int] NOT NULL,
 CONSTRAINT [PK_FORMULAIRE_OFICHIERID] PRIMARY KEY CLUSTERED
(
	[FORMULAIREID] ASC,
	[OFICHIERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]