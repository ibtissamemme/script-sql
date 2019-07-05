
/****** Object:  Table [dbo].[HRESERVATION]    Script Date: 05/07/2019 11:18:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HRESERVATION](
	[CODERESERVATION] [varchar](14) NULL,
	[CODETYPERESERVATION] [varchar](14) NULL,
	[PRIORITE] [int] NULL,
	[SOCIETEID] [varchar](14) NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[USERID] [varchar](14) NULL,
	[CODEANIMATEUR] [varchar](14) NULL,
	[DATERETROCESSION] [datetime] NULL,
	[CODESTATUT] [varchar](14) NULL,
	[REFRESERVATION] [varchar](15) NULL,
	[NBPERSDEMANDE] [int] NULL,
	[NBPERSREEL] [int] NULL,
	[LIBELLE] [varchar](35) NULL,
	[REMISE] [float] NULL,
	[PRIXRESERVATION] [float] NULL,
	[PRIXFACTUREE] [float] NULL,
	[COMMENTAIRE] [image] NULL,
	[UPDATEDBY] [varchar](14) NULL,
	[DEVIS] [int] NULL,
	[FACTURE] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[DATESYNCHRO] [datetime] NULL,
	[IMPUTATIONID] [varchar](14) NULL,
	[TYPERESERVATION] [varchar](35) NULL,
	[STATUTRESERVATION] [varchar](35) NULL,
	[IMPUTATION] [varchar](35) NULL,
	[TYPEIMPUTATION] [varchar](35) NULL,
	[SOCIETE] [varchar](35) NULL,
	[INTER_NOMP] [varchar](70) NULL,
	[INTER_DEPTSERV] [varchar](70) NULL,
	[INTER_TEL] [varchar](20) NULL,
	[INTER_EMAIL] [varchar](100) NULL,
	[ANIMATEUR_NOMP] [varchar](70) NULL,
	[ANIMATEUR_SOCIETE] [varchar](35) NULL,
	[USER_FULLNAME] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
