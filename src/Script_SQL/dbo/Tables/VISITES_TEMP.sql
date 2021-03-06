﻿CREATE TABLE [dbo].[VISITES_TEMP](
	[VISITEID] [varchar](14) NOT NULL,
	[INTERLOCUTEURID] [varchar](14) NULL,
	[RESIDANTID] [varchar](14) NULL,
	[CODESALLE] [varchar](14) NULL,
	[SITEID] [varchar](14) NULL,
	[STATUTID] [int] NULL,
	[EXTERNALID] [varchar](24) NULL,
	[SOCIETERESID] [varchar](35) NULL,
	[NOMPRENOMRESID] [varchar](35) NULL,
	[SOCIETEVISIT] [varchar](35) NULL,
	[NOMPRENOMVISIT] [varchar](35) NULL,
	[DEBUTPREVU] [datetime] NULL,
	[FINPREVU] [datetime] NULL,
	[HDEBUTPREVU] [datetime] NULL,
	[HFINPREVU] [datetime] NULL,
	[NUMEROBADGE] [varchar](200) NULL,
	[NUMEROVISITE] [int] NULL,
	[DEBUTVISITE] [datetime] NULL,
	[FINVISITE] [datetime] NULL,
	[HDEBUT] [datetime] NULL,
	[HFIN] [datetime] NULL,
	[STATUTVISITE] [varchar](50) NULL,
	[TYPEVISITEID] [int] NULL,
	[BOITE] [varchar](6) NULL,
	[CASIER] [varchar](6) NULL,
	[OBJET] [varchar](200) NULL,
	[CASIERID] [int] NULL,
	[PIECE] [varchar](35) NULL,
	[NUMERO] [varchar](20) NULL,
	[VALIDITE] [datetime] NULL,
	[PARKING] [varchar](6) NULL,
	[IMMATRICULATION] [varchar](15) NULL,
	[GUICHETID] [varchar](14) NULL,
	[OBSERVATION] [varchar](200) NULL,
	[BUREAUID] [varchar](14) NULL,
	[LIEU] [varchar](50) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL,
	[ORIGINEVISITE] [int] NULL,
	[NBBDGIMPR] [int] NULL,
	[NBBDGIMPRTOTAL] [int] NULL,
	[FREE1] [varchar](50) NULL,
	[FREE2] [varchar](50) NULL,
	[FREE3] [varchar](50) NULL,
	[FREE4] [varchar](50) NULL,
	[FREE5] [varchar](50) NULL,
	[FREE6] [varchar](50) NULL,
	[FREE7] [varchar](50) NULL,
	[FREE8] [varchar](50) NULL,
	[FREE9] [varchar](50) NULL,
	[FREE10] [varchar](50) NULL,
	[ETATVISITE] [varchar](1) NULL
) ON [PRIMARY]