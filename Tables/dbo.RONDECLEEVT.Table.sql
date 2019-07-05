
/****** Object:  Table [dbo].[RONDECLEEVT]    Script Date: 05/07/2019 11:18:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RONDECLEEVT](
	[RONDECLEEVTID] [int] NOT NULL,
	[MOTCLE] [varchar](50) NULL,
	[EVENEMENTID] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[RONDECLEEVTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
