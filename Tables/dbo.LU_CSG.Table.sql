
/****** Object:  Table [dbo].[LU_CSG]    Script Date: 05/07/2019 11:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LU_CSG](
	[PERSONNELID] [int] NOT NULL,
	[CONSIGNEID] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
