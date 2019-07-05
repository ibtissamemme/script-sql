
/****** Object:  Table [dbo].[MARCHE]    Script Date: 05/07/2019 11:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MARCHE](
	[MARCHEID] [varchar](14) NOT NULL,
	[MARCHE] [varchar](120) NULL,
	[OBJET] [varchar](250) NULL,
	[MANDATAIRE] [varchar](35) NULL,
	[MANDATAIREID] [varchar](14) NULL,
	[RANG] [varchar](20) NULL,
	[FINPREVUE] [datetime] NULL,
	[CSPS] [datetime] NULL,
	[INSPECCOMMUNE] [datetime] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
