
/****** Object:  Table [dbo].[RPT_STD006]    Script Date: 05/07/2019 11:18:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RPT_STD006](
	[RPT_STD006ID] [int] NOT NULL,
	[REF] [varchar](20) NULL,
	[VERSION] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[AUTEUR] [varchar](30) NULL,
	[TITRE] [varchar](50) NULL,
	[EVENEMENT] [varchar](50) NULL,
	[FREEDATA01] [varchar](50) NULL,
	[FREEDATA02] [varchar](50) NULL,
	[FREEDATA03] [varchar](50) NULL,
	[FREEDATA04] [varchar](50) NULL,
	[FREEDATA05] [varchar](50) NULL,
	[FREEDATA06] [varchar](50) NULL,
	[FREEDATA07] [varchar](50) NULL,
	[FREEDATA08] [varchar](50) NULL,
	[FREEDATA09] [varchar](50) NULL,
	[FREEDATA10] [varchar](50) NULL,
	[FREEDATA11] [varchar](50) NULL,
	[FREEDATA12] [varchar](50) NULL,
	[FREEDATA13] [varchar](50) NULL,
	[FREEDATA14] [varchar](50) NULL,
	[FREEDATA15] [varchar](50) NULL,
	[FREEDATA16] [varchar](50) NULL,
	[FREEDATA17] [varchar](50) NULL,
	[FREEDATA18] [varchar](50) NULL,
	[FREEDATA19] [varchar](50) NULL,
	[FREEDATA20] [varchar](50) NULL,
	[FREEDATE01] [datetime] NULL,
	[FREEDATE02] [datetime] NULL,
	[FREEDATE03] [datetime] NULL,
	[FREEDATE04] [datetime] NULL,
	[FREEDATE05] [datetime] NULL,
	[FREEMEMO01] [varchar](4000) NULL,
	[FREEMEMO02] [varchar](4000) NULL,
PRIMARY KEY CLUSTERED
(
	[RPT_STD006ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
