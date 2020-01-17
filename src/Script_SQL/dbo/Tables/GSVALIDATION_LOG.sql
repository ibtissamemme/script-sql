CREATE TABLE [dbo].[GSVALIDATION_LOG](
	[GSVALIDATION_LOGID] [nvarchar](14) NOT NULL,
	[CODERESERVATION] [nvarchar](14) NULL,
	[REFRESERVATION] [nvarchar](15) NULL,
	[LIBELLESALLE] [nvarchar](70) NULL,
	[DATEDEBUT] [datetime] NULL,
	[DATEFIN] [datetime] NULL,
	[STATUT_OLD] [nvarchar](35) NULL,
	[STATUT] [nvarchar](35) NULL,
	[VALIDEUR] [nvarchar](70) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]