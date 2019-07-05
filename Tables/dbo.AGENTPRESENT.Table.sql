
/****** Object:  Table [dbo].[AGENTPRESENT]    Script Date: 05/07/2019 11:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AGENTPRESENT](
	[PERSONNELID] [int] NULL,
	[NOMPRENOM] [varchar](50) NULL,
	[ENTREE] [datetime] NULL,
	[SORTIE] [datetime] NULL,
	[SURSITE] [int] NULL,
	[PARPRISE] [int] NULL,
	[FONCTION] [varchar](35) NULL,
	[SITEID] [varchar](14) NULL,
	[POSTEID] [int] NULL
) ON [PRIMARY]
GO
