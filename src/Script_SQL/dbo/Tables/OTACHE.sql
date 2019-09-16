﻿CREATE TABLE [dbo].[OTACHE](
	[OTACHEID] [int] NOT NULL,
	[TYPEJOUR] [varchar](20) NULL,
	[HEUREEXECUTION] [datetime] NULL,
	[ACTION] [varchar](20) NULL,
	[HEUREDEBUT] [datetime] NULL,
	[HEUREFIN] [datetime] NULL,
	[NBJOURMOINS] [int] NULL,
	[MODEA] [int] NULL,
	[ACTIF] [int] NULL,
	[PROCHAINEEXECUTION] [datetime] NULL,
	[DERNIEREEXECUTION] [datetime] NULL,
	[DERNIERRESULTAT] [int] NULL,
	[SITEID] [varchar](20) NULL,
	[GROUPEDESTID] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[OTACHEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OTACHE] ADD  DEFAULT ((0)) FOR [NBJOURMOINS]
GO
ALTER TABLE [dbo].[OTACHE] ADD  DEFAULT ((0)) FOR [MODEA]
GO
ALTER TABLE [dbo].[OTACHE] ADD  DEFAULT ((1)) FOR [ACTIF]
GO
ALTER TABLE [dbo].[OTACHE] ADD  DEFAULT ((0)) FOR [DERNIERRESULTAT]