
/****** Object:  Table [dbo].[ZCL01_EMISSION]    Script Date: 05/07/2019 11:18:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL01_EMISSION](
	[EMI_COD] [varchar](14) NOT NULL,
	[EMI_DEST1] [varchar](100) NULL,
	[EMI_DEST2] [varchar](100) NULL,
	[EMI_DEST3] [varchar](100) NULL,
	[EMI_DEST4] [varchar](100) NULL,
	[EMI_DEST5] [varchar](100) NULL,
	[EMI_OBJET] [varchar](100) NULL,
	[EMI_TEXTE] [varchar](500) NULL
) ON [PRIMARY]
GO
