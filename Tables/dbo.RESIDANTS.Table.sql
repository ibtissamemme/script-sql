
/****** Object:  Table [dbo].[RESIDANTS]    Script Date: 05/07/2019 11:17:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESIDANTS](
	[SOCIETEID] [varchar](14) NOT NULL,
	[RESIDANTID] [varchar](14) NOT NULL,
	[PLANID] [varchar](14) NULL,
	[BUREAUID] [varchar](250) NULL,
	[CODECIVILITE] [int] NULL,
	[CODEFONCTION] [int] NULL,
	[PHONKEY] [varchar](35) NULL,
	[EXTERNALID] [varchar](24) NULL,
	[SOCIETE] [varchar](35) NULL,
	[CIVILITE] [varchar](30) NULL,
	[NOMPRENOM] [varchar](70) NULL,
	[NOMJEUNEFILLE] [varchar](35) NULL,
	[CPNOM] [varchar](250) NULL,
	[NOM] [varchar](35) NULL,
	[PRENOM] [varchar](35) NULL,
	[FONCTION] [varchar](35) NULL,
	[SERVICEID] [varchar](14) NULL,
	[TELEPHONE] [varchar](20) NULL,
	[EMAIL] [varchar](150) NULL,
	[GSM] [varchar](20) NULL,
	[FAX] [varchar](20) NULL,
	[CANDIDATMAILING] [varchar](1) NULL,
	[MATRICULE] [varchar](50) NULL,
	[OBSERVATIONS] [image] NULL,
	[PHOTO] [image] NULL,
	[PERSOADRESSE] [image] NULL,
	[PERSOCP] [varchar](10) NULL,
	[PERSOVILLE] [varchar](35) NULL,
	[PERSOPROVINCE] [varchar](35) NULL,
	[PERSOPAYS] [varchar](35) NULL,
	[PERSOTELEPHONE] [varchar](20) NULL,
	[ISUSER] [varchar](10) NULL,
	[MUSTCHANGEPWD] [int] NULL,
	[THEPASSWORD] [varchar](250) NOT NULL,
	[THELOGIN] [varchar](50) NOT NULL,
	[USERTYPE] [int] NULL,
	[SHORTNAME] [int] NULL,
	[ENABLED] [varchar](1) NULL,
	[SITEID] [varchar](14) NULL,
	[SITE] [varchar](40) NULL,
	[SERVICE] [varchar](40) NULL,
	[DEPARTEMENT] [varchar](40) NULL,
	[PLANSLIBELLE] [varchar](40) NULL,
	[DEPTID] [varchar](14) NULL,
	[ETAGEID] [varchar](14) NULL,
	[BATIMENT] [varchar](60) NULL,
	[BATIMENTID] [varchar](14) NULL,
	[ETAGE] [varchar](7) NULL,
	[BUREAU] [varchar](15) NULL,
	[REFIMPORTATION] [varchar](48) NULL,
	[CODEACCES] [varchar](24) NULL,
	[DATEENTREE] [datetime] NULL,
	[DATESORTIE] [datetime] NULL,
	[BOITEPOSTALE] [varchar](7) NULL,
	[PARKING] [varchar](7) NULL,
	[HABILITATIONVISITE] [varchar](1) NULL,
	[LISTEROUGE] [varchar](1) NULL,
	[ISEXTERN] [varchar](1) NULL,
	[ISRESIDENT] [varchar](1) NULL,
	[ISACTIF] [varchar](1) NULL,
	[HARRIVEE] [datetime] NULL,
	[HDEPART] [datetime] NULL,
	[INTERDIT] [varchar](1) NULL,
	[DEBUTINTERDIT] [datetime] NULL,
	[FININTERDIT] [datetime] NULL,
	[NATUREID] [varchar](14) NULL,
	[DATENAISSANCE] [datetime] NULL,
	[LIEUNAISSANCE] [varchar](70) NULL,
	[NATIONALITEID] [varchar](14) NULL,
	[NBBDGIMPR] [int] NULL,
	[DIRECTIONID] [varchar](14) NULL,
	[DIRECTION] [varchar](35) NULL,
	[PASSWORD1] [varchar](250) NULL,
	[PASSWORD2] [varchar](250) NULL,
	[PASSWORD3] [varchar](250) NULL,
	[DATEFINVALPWD] [datetime] NULL,
	[IMMATRICULATION] [varchar](15) NULL,
	[TAG] [varchar](30) NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[VERROU] [int] NULL,
	[VIP] [int] NULL,
	[ETRANGER] [int] NULL,
	[CONTRAT] [varchar](50) NULL,
	[BORNE_ELECTRIQUE] [varchar](10) NULL,
	[PAYSNAISSANCEID] [varchar](14) NULL,
	[PINCODE] [varchar](150) NULL,
 CONSTRAINT [PK_RESIDANTID] PRIMARY KEY CLUSTERED
(
	[RESIDANTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[RESIDANTS] ADD  DEFAULT ('0') FOR [PHONKEY]
GO
ALTER TABLE [dbo].[RESIDANTS] ADD  DEFAULT ('1') FOR [ISRESIDENT]
GO
ALTER TABLE [dbo].[RESIDANTS] ADD  DEFAULT ((0)) FOR [VERROU]
GO
ALTER TABLE [dbo].[RESIDANTS] ADD  DEFAULT ((0)) FOR [VIP]
GO
ALTER TABLE [dbo].[RESIDANTS] ADD  DEFAULT ((0)) FOR [ETRANGER]
GO
ALTER TABLE [dbo].[RESIDANTS] ADD  DEFAULT ((0)) FOR [BORNE_ELECTRIQUE]
GO
ALTER TABLE [dbo].[RESIDANTS]  WITH CHECK ADD  CONSTRAINT [fk_resi_servid] FOREIGN KEY([SERVICEID])
REFERENCES [dbo].[SERVICE] ([SERVICEID])
GO
ALTER TABLE [dbo].[RESIDANTS] CHECK CONSTRAINT [fk_resi_servid]
GO
ALTER TABLE [dbo].[RESIDANTS]  WITH CHECK ADD  CONSTRAINT [fk_resi_siteid] FOREIGN KEY([SITEID])
REFERENCES [dbo].[SITE] ([SITEID])
GO
ALTER TABLE [dbo].[RESIDANTS] CHECK CONSTRAINT [fk_resi_siteid]
GO
ALTER TABLE [dbo].[RESIDANTS]  WITH CHECK ADD  CONSTRAINT [fk_resi_socid] FOREIGN KEY([SOCIETEID])
REFERENCES [dbo].[SOCIETE] ([SOCIETEID])
GO
ALTER TABLE [dbo].[RESIDANTS] CHECK CONSTRAINT [fk_resi_socid]
GO
