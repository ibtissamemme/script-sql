CREATE TABLE [dbo].[ONOTE](
	[ONOTEID] [int] NOT NULL,
	[EXPEDITEURID] [int] NULL,
	[DESTINATAIREID] [int] NULL,
	[EXPEDITEUR] [varchar](70) NULL,
	[DESTINATAIRE] [varchar](70) NULL,
	[OBJET] [varchar](70) NULL,
	[CORPS] [varchar](2000) NULL,
	[SUPPEXP] [int] NULL,
	[SUPPDEST] [int] NULL,
	[NEW] [int] NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NULL
) ON [PRIMARY]