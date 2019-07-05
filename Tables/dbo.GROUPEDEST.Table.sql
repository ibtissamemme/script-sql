
/****** Object:  Table [dbo].[GROUPEDEST]    Script Date: 05/07/2019 11:18:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROUPEDEST](
	[GROUPEDESTID] [int] NOT NULL,
	[LIBELLE] [varchar](50) NULL,
	[TOADDRESS] [varchar](2000) NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[GROUPEDESTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
