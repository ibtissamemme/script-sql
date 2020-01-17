CREATE TABLE [dbo].[VISITES_RESIDANTS](
	[PASSAGERID] [nvarchar](14) NOT NULL,
	[RESIDANTID] [nvarchar](14) NULL,
	[NOMPRENOM] [nvarchar](70) NULL,
	[CODEACCES] [nvarchar](34) NULL,
	[ENTREE] [datetime] NULL,
	[SORTIE] [datetime] NULL,
	[CIRCULATION] [nvarchar](20) NULL,
	[OBSERVATION] [nvarchar](200) NULL,
	[TYPEENTREE] [int] NULL,
	[GUICHET_E] [nvarchar](30) NULL,
	[GUICHET_S] [nvarchar](30) NULL,
	[SITEID] [nvarchar](14) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]