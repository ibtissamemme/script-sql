
/****** Object:  Table [dbo].[SOCMAR]    Script Date: 05/07/2019 11:18:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOCMAR](
	[SOCIETEID] [varchar](14) NOT NULL,
	[MARCHEID] [varchar](14) NOT NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
