CREATE TABLE [dbo].[TABLEREFERENCE](
	[TABLEREFERENCEID] [int] NULL,
	[ID] [int] NULL,
	[VALEUR] [int] NULL,
	[TEXTE] [nvarchar](100) NULL,
	[TEXTE_FR] [nvarchar](100) NULL,
	[TEXTE_EN] [nvarchar](100) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]