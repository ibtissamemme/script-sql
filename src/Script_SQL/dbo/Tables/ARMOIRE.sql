CREATE TABLE [dbo].[ARMOIRE](
	[ARMOIREID] [varchar](14) NOT NULL,
	[LIBELLE] [varchar](35) NULL,
	[NUMERO] [int] NULL,
	[CAPACITE] [int] NULL,
	[NBELEMENT] [int] NULL,
	[ISACTIF] [int] NULL,
	[SITEID] [varchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]