CREATE TABLE [dbo].[TABLEREFERENCE](
	[TABLEREFERENCEID] [int] NULL,
	[ID] [int] NULL,
	[VALEUR] [int] NULL,
	[TEXTE] [varchar](100) NULL,
	[TEXTE_FR] [varchar](100) NULL,
	[TEXTE_EN] [varchar](100) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]