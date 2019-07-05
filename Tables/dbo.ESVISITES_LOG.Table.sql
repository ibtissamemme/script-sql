
/****** Object:  Table [dbo].[ESVISITES_LOG]    Script Date: 05/07/2019 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESVISITES_LOG](
	[ESVISITES_LOGID] [varchar](14) NOT NULL,
	[QUIID] [varchar](14) NULL,
	[QUITYPE] [varchar](40) NULL,
	[NOMPRENOM] [varchar](70) NULL,
	[SOCIETE] [varchar](70) NULL,
	[NUMBADGE] [varchar](200) NULL,
	[SENS] [varchar](50) NULL,
	[ETAT] [varchar](50) NULL,
	[DETAILS] [varchar](200) NULL,
	[PASSAGE] [datetime] NULL,
	[TYPEINSERT] [varchar](14) NULL,
	[REMOTEDATE] [varchar](20) NULL,
	[SITEID] [varchar](14) NULL,
	[GUICHETID] [varchar](14) NULL,
	[POSTE] [varchar](50) NULL,
	[TYPELECTEUR] [varchar](40) NULL,
	[ZRR_CODE] [varchar](25) NULL,
	[ZRR_LIB] [varchar](255) NULL,
	[ZRR_LS] [varchar](3) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]
GO
