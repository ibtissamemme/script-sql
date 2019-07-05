
/****** Object:  Table [dbo].[GSVALIDATION_LOG]    Script Date: 05/07/2019 11:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GSVALIDATION_LOG](
	[GSVALIDATION_LOGID] [varchar](14) NOT NULL,
	[CODERESERVATION] [varchar](14) NULL,
	[REFRESERVATION] [varchar](15) NULL,
	[LIBELLESALLE] [varchar](70) NULL,
	[DATEDEBUT] [datetime] NULL,
	[DATEFIN] [datetime] NULL,
	[STATUT_OLD] [varchar](35) NULL,
	[STATUT] [varchar](35) NULL,
	[VALIDEUR] [varchar](70) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]
GO
