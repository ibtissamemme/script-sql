﻿CREATE TABLE [dbo].[ZCL27_EMPLOYEE](
	[ID_EMPLOYEE] [int] IDENTITY(1,1) NOT NULL,
	[SITEID] [varchar](14) NULL,
	[INTERLOCUTEURID] [varchar](14) NOT NULL,
	[E_CARDNUMBER] [varchar](20) NOT NULL,
	[E_CARDASSIGNED] [int] NOT NULL,
	[E_FIRSTNAME] [varchar](30) NULL,
	[E_LASTNAME] [varchar](30) NULL,
	[E_EMPLOYEEID] [int] NULL,
	[E_STARTDATE] [datetime] NULL,
	[E_STARTDATETIME] [datetime] NULL,
	[E_ENDDATE] [datetime] NULL,
	[E_ENDDATETIME] [datetime] NULL,
	[E_WG_ID] [varchar](20) NULL,
	[E_LASTUPDATEDTIME] [varchar](19) NULL,
	[E_REFERENCE] [int] NULL,
	[E_VISITOR] [int] NULL,
	[STATUT_ENTREE] [int] NULL,
	[STATUT_SORTIE] [int] NOT NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
PRIMARY KEY CLUSTERED
(
	[ID_EMPLOYEE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZCL27_EMPLOYEE] ADD  DEFAULT ((0)) FOR [E_CARDASSIGNED]
GO
ALTER TABLE [dbo].[ZCL27_EMPLOYEE] ADD  DEFAULT ((0)) FOR [STATUT_SORTIE]