CREATE TABLE [dbo].[ARMOIRE](
	[ARMOIREID] [nvarchar](14) NOT NULL,
	[LIBELLE] [nvarchar](35) NULL,
	[NUMERO] [int] NULL,
	[CAPACITE] [int] NULL,
	[NBELEMENT] [int] NULL,
	[ISACTIF] [int] NULL,
	[SITEID] [nvarchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]