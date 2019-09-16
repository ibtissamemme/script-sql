CREATE TABLE [dbo].[PASSAGER](
	[PASSAGERID] [varchar](14) NOT NULL,
	[RESIDANTID] [varchar](14) NULL,
	[NOMPRENOM] [varchar](35) NULL,
	[CODEACCES] [varchar](34) NULL,
	[PASSAGE] [datetime] NULL,
	[CIRCULATION] [varchar](20) NULL,
	[OBSERVATION] [varchar](200) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]