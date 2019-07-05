
/****** Object:  Table [dbo].[RESIDANT_CTRL]    Script Date: 05/07/2019 11:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESIDANT_CTRL](
	[RESIDANT_CTRLID] [int] NOT NULL,
	[RESIDANTID] [varchar](14) NULL,
	[ACTION] [int] NOT NULL,
	[SITEID] [varchar](14) NULL,
	[SITE] [varchar](80) NULL,
	[EMETTEUR] [varchar](80) NULL,
	[DH_POST] [datetime] NOT NULL,
	[DH_PROCEED] [datetime] NULL,
	[IDENT] [varchar](80) NOT NULL,
	[STATUT] [int] NULL,
	[TXT_ERR] [varchar](80) NULL,
	[DEB_VAL] [datetime] NULL,
	[FIN_VAL] [datetime] NULL,
	[NOM] [varchar](40) NULL,
	[PRENOM] [varchar](40) NULL,
	[SOCIETE] [varchar](40) NULL,
	[CODE_ANTENNE] [varchar](40) NULL,
	[MATRICULE] [varchar](40) NULL,
	[ANTI_RETOUR] [int] NULL,
	[CODE_CLASSE] [int] NULL,
	[DATA_01] [varchar](80) NULL,
	[DATA_02] [varchar](80) NULL,
	[DATA_03] [varchar](80) NULL,
	[DATA_04] [varchar](80) NULL,
	[DATA_05] [varchar](80) NULL,
	[DATA_06] [varchar](80) NULL,
	[DATA_07] [varchar](80) NULL,
	[DATA_08] [varchar](80) NULL,
	[DATA_09] [varchar](80) NULL,
	[DATA_10] [varchar](80) NULL,
	[ACCES_01] [varchar](4000) NULL,
	[ACCES_02] [varchar](4000) NULL,
	[ACCES_03] [varchar](4000) NULL,
	[ACCES_04] [varchar](4000) NULL,
	[ACCES_05] [varchar](4000) NULL,
	[ACCES_06] [varchar](4000) NULL,
	[ACCES_07] [varchar](4000) NULL,
	[ACCES_08] [varchar](4000) NULL,
	[ACCES_09] [varchar](4000) NULL,
	[ACCES_10] [varchar](4000) NULL,
PRIMARY KEY CLUSTERED
(
	[RESIDANT_CTRLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
