﻿CREATE TABLE [dbo].[GRPUSER](
	[GRPUSERID] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](50) NULL,
	[NIVEAU] [varchar](14) NULL,
	[STATUT] [varchar](14) NULL,
	[STATUTCHECK] [int] NULL,
	[SURRESERVATION] [varchar](1) NULL,
	[RESAPERIODIQUE] [varchar](1) NULL,
	[ACCESDRAGDROP] [varchar](1) NULL,
	[PLANNING] [varchar](5) NULL,
	[RESA] [varchar](15) NULL,
	[PRESTA] [varchar](15) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[EMAILAUTO] [varchar](1) NULL,
	[VALIDEUR] [int] NULL,
	[PAYANT] [int] NULL,
	[DROITSADM] [varchar](500) NULL,
PRIMARY KEY CLUSTERED
(
	[GRPUSERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GRPUSER] ADD  DEFAULT ((0)) FOR [VALIDEUR]
GO
ALTER TABLE [dbo].[GRPUSER] ADD  DEFAULT ((0)) FOR [PAYANT]