﻿CREATE TABLE [dbo].[GRPVALIDEUR](
	[GRPVALIDEURID] [int] NOT NULL,
	[GRPVALIDEURN] [nvarchar](100) NULL,
	[RANGVALIDEUR] [int] NULL,
	[AVIS] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
 CONSTRAINT [PK_GRPVALIDEURID] PRIMARY KEY CLUSTERED
(
	[GRPVALIDEURID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GRPVALIDEUR] ADD  DEFAULT ((0)) FOR [RANGVALIDEUR]
GO
ALTER TABLE [dbo].[GRPVALIDEUR] ADD  DEFAULT ((0)) FOR [AVIS]