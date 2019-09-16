﻿CREATE TABLE [dbo].[ZCL08_REPAS](
	[REPASID] [varchar](14) NULL,
	[REPAS] [varchar](10) NULL,
	[NUMEROBADGE] [varchar](20) NOT NULL,
	[DATEPASSAGE] [varchar](20) NULL,
	[DATEPASSAGE2] [varchar](20) NOT NULL,
	[VISITEID] [varchar](14) NULL,
	[DATEREELLE] [datetime] NULL,
 CONSTRAINT [PK_BDG] PRIMARY KEY CLUSTERED
(
	[NUMEROBADGE] ASC,
	[DATEPASSAGE2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]