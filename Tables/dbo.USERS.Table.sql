
/****** Object:  Table [dbo].[USERS]    Script Date: 05/07/2019 11:18:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[USERID] [varchar](14) NOT NULL,
	[CIVILITEID] [int] NULL,
	[FIRSTNAME] [varchar](35) NULL,
	[ENABLED] [int] NULL,
	[LASTNAME] [varchar](35) NULL,
	[PHONNAME] [varchar](50) NULL,
	[USERTYPEID] [varchar](24) NULL,
	[GSACCESS] [int] NULL,
	[GVACCESS] [int] NULL,
	[EXTERNALID] [varchar](24) NULL,
	[FULLNAME] [varchar](70) NULL,
	[INTERNETMAILADR] [varchar](120) NULL,
	[MATRICULE] [varchar](50) NULL,
	[OBSERVATIONS] [image] NULL,
	[PHONKEY] [varchar](50) NULL,
	[PROFIL_PARAMCOMPTE] [varchar](14) NULL,
	[PROFIL_ID_ORGA] [varchar](14) NULL,
	[PROFIL_ID_INTER] [varchar](14) NULL,
	[PROFIL_ID_SALLE] [varchar](14) NULL,
	[PROFIL_ID_BATIMENT] [varchar](14) NULL,
	[PROFIL_ID_SITE] [varchar](14) NULL,
	[PROFIL_ETAGE] [varchar](14) NULL,
	[PROFIL_SURBOOKING] [int] NULL,
	[PROFIL_PARAMVALIDE] [varchar](14) NULL,
	[PROFIL_ID_STATUT] [varchar](14) NULL,
	[SHORTNAME] [varchar](5) NULL,
	[THELOGIN] [varchar](50) NULL,
	[THEPASSWORD] [varchar](250) NULL,
	[USERTYPE] [int] NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[GCACCESS] [int] NULL,
	[SITE] [varchar](35) NULL,
	[SITEID] [varchar](14) NULL,
	[GRPUSERID] [varchar](14) NULL,
	[DATEMAJPWD] [datetime] NULL,
	[SOCIETEID] [varchar](14) NULL,
	[SOCIETE] [varchar](35) NULL,
	[TYPEUSERID] [int] NULL,
	[ID_DROITSTAXI] [int] NULL,
	[EMPPK] [image] NULL,
	[EMPPK_LEN] [int] NULL,
	[ID_DROITSTELEM] [int] NULL,
	[TELEPHONE] [varchar](30) NULL,
	[MOBILE] [varchar](30) NULL,
	[BATIMENTID] [varchar](14) NULL,
	[BUREAUID] [varchar](14) NULL,
	[SERVICEID] [varchar](14) NULL,
	[DEPARTEMENTID] [varchar](14) NULL,
	[GRPSITEADM] [varchar](14) NULL,
 CONSTRAINT [PK_USERID] PRIMARY KEY CLUSTERED
(
	[USERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0)) FOR [GSACCESS]
GO
