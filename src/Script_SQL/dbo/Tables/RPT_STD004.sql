﻿CREATE TABLE [dbo].[RPT_STD004](
	[RPT_STD004ID] [int] NOT NULL,
	[REF] [nvarchar](20) NULL,
	[VERSION] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[AUTEUR] [nvarchar](30) NULL,
	[TITRE] [nvarchar](50) NULL,
	[EVENEMENT] [nvarchar](50) NULL,
	[FREEDATA01] [nvarchar](50) NULL,
	[FREEDATA02] [nvarchar](50) NULL,
	[FREEDATA03] [nvarchar](50) NULL,
	[FREEDATA04] [nvarchar](50) NULL,
	[FREEDATA05] [nvarchar](50) NULL,
	[FREEDATA06] [nvarchar](50) NULL,
	[FREEDATA07] [nvarchar](50) NULL,
	[FREEDATA08] [nvarchar](50) NULL,
	[FREEDATA09] [nvarchar](50) NULL,
	[FREEDATA10] [nvarchar](50) NULL,
	[FREEDATA11] [nvarchar](50) NULL,
	[FREEDATA12] [nvarchar](50) NULL,
	[FREEDATA13] [nvarchar](50) NULL,
	[FREEDATA14] [nvarchar](50) NULL,
	[FREEDATA15] [nvarchar](50) NULL,
	[FREEDATA16] [nvarchar](50) NULL,
	[FREEDATA17] [nvarchar](50) NULL,
	[FREEDATA18] [nvarchar](50) NULL,
	[FREEDATA19] [nvarchar](50) NULL,
	[FREEDATA20] [nvarchar](50) NULL,
	[FREEDATE01] [datetime] NULL,
	[FREEDATE02] [datetime] NULL,
	[FREEDATE03] [datetime] NULL,
	[FREEDATE04] [datetime] NULL,
	[FREEDATE05] [datetime] NULL,
	[FREEMEMO01] [nvarchar](4000) NULL,
	[FREEMEMO02] [nvarchar](4000) NULL,
PRIMARY KEY CLUSTERED
(
	[RPT_STD004ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]