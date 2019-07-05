
/****** Object:  Table [dbo].[ZCL27_SITE]    Script Date: 05/07/2019 11:18:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL27_SITE](
	[ID_SITE] [int] IDENTITY(1,1) NOT NULL,
	[SITEID] [varchar](14) NULL,
	[SERVICEURL] [varchar](300) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ID_SITE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
