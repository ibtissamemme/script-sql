CREATE TABLE [dbo].[PASSAGER](
	[PASSAGERID] [nvarchar](14) NOT NULL,
	[RESIDANTID] [nvarchar](14) NULL,
	[NOMPRENOM] [nvarchar](35) NULL,
	[CODEACCES] [nvarchar](34) NULL,
	[PASSAGE] [datetime] NULL,
	[CIRCULATION] [nvarchar](20) NULL,
	[OBSERVATION] [nvarchar](200) NULL,
	[DATECREATION] [datetime] NOT NULL,
	[DATEMAJ] [datetime] NOT NULL,
	[DATESYNCHRO] [datetime] NULL
) ON [PRIMARY]