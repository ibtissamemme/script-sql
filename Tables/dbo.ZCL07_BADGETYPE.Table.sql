
/****** Object:  Table [dbo].[ZCL07_BADGETYPE]    Script Date: 05/07/2019 11:18:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL07_BADGETYPE](
	[ZCL07_BADGETYPEID] [varchar](14) NULL,
	[NAME] [varchar](25) NULL,
	[CLASS] [int] NULL,
	[SERIE] [varchar](10) NULL,
	[CUSTOMERCODE] [varchar](10) NULL,
	[DEBUT] [int] NULL,
	[FIN] [int] NULL
) ON [PRIMARY]
GO
