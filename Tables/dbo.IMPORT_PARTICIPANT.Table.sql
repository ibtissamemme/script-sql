
/****** Object:  Table [dbo].[IMPORT_PARTICIPANT]    Script Date: 05/07/2019 11:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IMPORT_PARTICIPANT](
	[ID] [varchar](18) NULL,
	[RNOM] [varchar](30) NULL,
	[RPRENOM] [varchar](30) NULL,
	[RMATRICULE] [varchar](30) NULL,
	[RCIVILITE] [varchar](30) NULL,
	[REMAIL] [varchar](70) NULL,
	[RSOCIETE] [varchar](30) NULL,
	[REFRESA] [varchar](30) NULL
) ON [PRIMARY]
GO
