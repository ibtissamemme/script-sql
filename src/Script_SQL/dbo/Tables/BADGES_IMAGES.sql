﻿CREATE TABLE [dbo].[BADGES_IMAGES](
	[BADGES_IMAGEID] [varchar](14) NOT NULL,
	[IMAGE] [image] NULL,
	[CONTENTTYPE] [varchar](50) NULL,
	[SOURCEFILENAME] [varchar](100) NULL,
	[DATASIZE] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[BADGES_IMAGEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]