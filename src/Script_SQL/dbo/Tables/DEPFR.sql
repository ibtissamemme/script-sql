﻿CREATE TABLE [dbo].[DEPFR](
	[DEPFRID] [int] NOT NULL,
	[NUMERO] [varchar](10) NULL,
	[DEPARTEMENT] [varchar](70) NULL,
	[PREFERTURE] [varchar](70) NULL,
	[REGION] [varchar](70) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[DEPFRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]