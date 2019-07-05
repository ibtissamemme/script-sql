
/****** Object:  Table [dbo].[ZCL15_CPPA]    Script Date: 05/07/2019 11:18:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZCL15_CPPA](
	[IDCPPA] [varchar](14) NULL,
	[REGLEID] [varchar](14) NULL,
	[SITEID] [varchar](14) NULL,
	[SITE] [varchar](35) NULL,
	[SOCIETEID] [varchar](14) NULL,
	[SOCIETE] [varchar](35) NULL,
	[PAYSID] [varchar](14) NULL,
	[PAYS] [varchar](35) NULL,
	[TYPEVISITEID] [int] NULL,
	[TYPEVISITE] [varchar](70) NULL,
	[ETAT] [varchar](3) NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
