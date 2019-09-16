﻿CREATE TABLE [dbo].[CHK_CHECKLIST](
	[CHKID] [int] NOT NULL,
	[CHECKLISTID] [int] NULL,
	[NORDER] [int] NULL,
PRIMARY KEY CLUSTERED
(
	[CHKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]