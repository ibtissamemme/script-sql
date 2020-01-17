﻿CREATE TABLE [dbo].[CHK](
	[CHKID] [int] NOT NULL,
	[LIBELLE] [nvarchar](400) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[CHKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]