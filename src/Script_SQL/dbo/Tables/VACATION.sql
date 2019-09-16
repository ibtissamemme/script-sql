﻿CREATE TABLE [dbo].[VACATION](
	[VACATIONID] [int] NOT NULL,
	[JOUR_SEM] [varchar](20) NULL,
	[VSERVICE] [varchar](40) NULL,
	[HEURE_DEBUT] [datetime] NULL,
	[HEURE_FIN] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL,
	[CL] [int] NULL,
 CONSTRAINT [PK_VACATIONID] PRIMARY KEY CLUSTERED
(
	[VACATIONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]