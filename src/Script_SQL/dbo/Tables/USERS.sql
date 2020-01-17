﻿CREATE TABLE [dbo].[USERS](
	[USERID] [nvarchar](14) NOT NULL,
	[CIVILITEID] [int] NULL,
	[FIRSTNAME] [nvarchar](35) NULL,
	[ENABLED] [int] NULL,
	[LASTNAME] [nvarchar](35) NULL,
	[PHONNAME] [nvarchar](50) NULL,
	[USERTYPEID] [nvarchar](24) NULL,
	[GSACCESS] [int] NULL,
	[GVACCESS] [int] NULL,
	[EXTERNALID] [nvarchar](24) NULL,
	[FULLNAME] [nvarchar](70) NULL,
	[INTERNETMAILADR] [nvarchar](120) NULL,
	[MATRICULE] [nvarchar](50) NULL,
	[OBSERVATIONS] [image] NULL,
	[PHONKEY] [nvarchar](50) NULL,
	[PROFIL_PARAMCOMPTE] [nvarchar](14) NULL,
	[PROFIL_ID_ORGA] [nvarchar](14) NULL,
	[PROFIL_ID_INTER] [nvarchar](14) NULL,
	[PROFIL_ID_SALLE] [nvarchar](14) NULL,
	[PROFIL_ID_BATIMENT] [nvarchar](14) NULL,
	[PROFIL_ID_SITE] [nvarchar](14) NULL,
	[PROFIL_ETAGE] [nvarchar](14) NULL,
	[PROFIL_SURBOOKING] [int] NULL,
	[PROFIL_PARAMVALIDE] [nvarchar](14) NULL,
	[PROFIL_ID_STATUT] [nvarchar](14) NULL,
	[SHORTNAME] [nvarchar](5) NULL,
	[THELOGIN] [nvarchar](50) NULL,
	[THEPASSWORD] [nvarchar](250) NULL,
	[USERTYPE] [int] NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[GCACCESS] [int] NULL,
	[SITE] [nvarchar](35) NULL,
	[SITEID] [nvarchar](14) NULL,
	[GRPUSERID] [nvarchar](14) NULL,
	[DATEMAJPWD] [datetime] NULL,
	[SOCIETEID] [nvarchar](14) NULL,
	[SOCIETE] [nvarchar](35) NULL,
	[TYPEUSERID] [int] NULL,
	[ID_DROITSTAXI] [int] NULL,
	[EMPPK] [image] NULL,
	[EMPPK_LEN] [int] NULL,
	[ID_DROITSTELEM] [int] NULL,
	[TELEPHONE] [nvarchar](30) NULL,
	[MOBILE] [nvarchar](30) NULL,
	[BATIMENTID] [nvarchar](14) NULL,
	[BUREAUID] [nvarchar](14) NULL,
	[SERVICEID] [nvarchar](14) NULL,
	[DEPARTEMENTID] [nvarchar](14) NULL,
	[GRPSITEADM] [nvarchar](14) NULL,
 CONSTRAINT [PK_USERID] PRIMARY KEY CLUSTERED
(
	[USERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0)) FOR [GSACCESS]