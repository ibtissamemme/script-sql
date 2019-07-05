
/****** Object:  Table [dbo].[RELATION]    Script Date: 05/07/2019 11:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RELATION](
	[RELATIONID] [int] NOT NULL,
	[RELATION] [varchar](15) NULL,
 CONSTRAINT [PK_RELATIONID] PRIMARY KEY CLUSTERED
(
	[RELATIONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
