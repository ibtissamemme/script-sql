
/****** Object:  Table [dbo].[PHOTOS]    Script Date: 05/07/2019 11:18:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHOTOS](
	[ID] [varchar](14) NULL,
	[PHOTO] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
