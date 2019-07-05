
/****** Object:  Table [dbo].[LU_CSGT]    Script Date: 05/07/2019 11:18:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LU_CSGT](
	[PERSONNELID] [int] NOT NULL,
	[CONSIGNETEMPID] [int] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
