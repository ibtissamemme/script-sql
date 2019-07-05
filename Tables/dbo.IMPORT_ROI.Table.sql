
/****** Object:  Table [dbo].[IMPORT_ROI]    Script Date: 05/07/2019 11:18:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IMPORT_ROI](
	[IMPORT_ROIID] [varchar](14) NOT NULL,
	[MVT] [varchar](3) NULL,
	[SOURCE] [varchar](12) NULL,
	[ETAT] [varchar](6) NULL,
	[RAISON] [varchar](10) NULL,
	[IDENTIFIANT] [varchar](10) NULL,
	[QUALITECIVILITE] [varchar](5) NULL,
	[NOM] [varchar](50) NULL,
	[PRENOM] [varchar](32) NULL,
	[SOCIETE] [varchar](5) NULL,
	[UNITEMANAGERIALE] [varchar](20) NULL,
	[LABELUNITEMANAGERIALE] [varchar](100) NULL,
	[TYPEPOPULATION] [varchar](2) NULL,
	[TYPEPERSONNE] [varchar](30) NULL,
	[IESOCIETEPRESTATION] [varchar](100) NULL,
	[IEDEBUTMISSION] [varchar](17) NULL,
	[IEFINMISSION] [varchar](17) NULL,
	[MAIL] [varchar](100) NULL,
	[CODEFONCTION] [varchar](4) NULL,
	[FONCTION] [varchar](50) NULL,
	[SITE] [varchar](3) NULL,
	[LIBELLESITE] [varchar](32) NULL,
	[BATIMENT] [varchar](3) NULL,
	[ETAGE] [varchar](3) NULL,
	[NUMEROBUREAU] [varchar](6) NULL,
	[RUE] [varchar](120) NULL,
	[CODEPOSTAL] [varchar](5) NULL,
	[VILLE] [varchar](32) NULL,
	[PAYS] [varchar](3) NULL,
	[TELEPHONE] [varchar](13) NULL,
	[TELEPHONEINTERNE] [varchar](6) NULL,
	[FAX] [varchar](13) NULL,
	[CODENATURECONTRATTRAVAIL] [varchar](5) NULL,
	[INDABSENCELONGUEDUREE] [varchar](1) NULL,
	[STATUTPERSONNE] [varchar](2) NULL,
	[CODEANTENNE] [varchar](20) NULL,
	[ANCIENSITE] [varchar](3) NULL,
	[ANCIENCODEANTENNE] [varchar](20) NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[THELOGIN] [varchar](50) NULL,
	[MANAGER] [varchar](20) NULL,
PRIMARY KEY CLUSTERED
(
	[IMPORT_ROIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
