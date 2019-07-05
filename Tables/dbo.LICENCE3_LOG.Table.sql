
/****** Object:  Table [dbo].[LICENCE3_LOG]    Script Date: 05/07/2019 11:18:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LICENCE3_LOG](
	[ID_LICENCE3_LOG] [int] IDENTITY(1,1) NOT NULL,
	[LOGIN] [varchar](50) NOT NULL,
	[APPLICATION] [varchar](20) NOT NULL,
	[ACTION] [varchar](50) NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
 CONSTRAINT [PK_ID_LICENCE3_LOG] PRIMARY KEY CLUSTERED
(
	[ID_LICENCE3_LOG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
