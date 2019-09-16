﻿CREATE TABLE [dbo].[CHECKLIST](
	[CHECKLISTID] [int] NOT NULL,
	[LIBELLE] [varchar](200) NULL,
	[NUMERO] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[CHKPRISEPOSTE] [int] NULL,
PRIMARY KEY CLUSTERED
(
	[CHECKLISTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHECKLIST] ADD  DEFAULT ((0)) FOR [CHKPRISEPOSTE]