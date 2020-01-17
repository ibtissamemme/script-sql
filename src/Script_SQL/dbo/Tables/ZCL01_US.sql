CREATE TABLE [dbo].[ZCL01_US](
	[NUMBDG] [nvarchar](14) NOT NULL,
	[NOM] [nvarchar](24) NULL,
	[PRENOM] [nvarchar](24) NULL,
	[TYPEV] [nvarchar](1) NULL,
	[MATRIC] [nvarchar](15) NULL,
	[SERVIC] [nvarchar](24) NULL,
	[NOMSTE] [nvarchar](15) NULL,
	[CH_EXPL01] [nvarchar](26) NULL,
	[CH_EXPL02] [nvarchar](26) NULL,
	[CH_EXPL03] [nvarchar](26) NULL,
	[CH_EXPL04] [nvarchar](26) NULL,
	[CH_EXPL05] [nvarchar](26) NULL,
	[CH_EXPL06] [nvarchar](26) NULL,
	[CH_EXPL07] [nvarchar](26) NULL,
	[CH_EXPL08] [nvarchar](26) NULL,
	[CH_EXPL09] [nvarchar](26) NULL,
	[CH_EXPL10] [nvarchar](26) NULL,
	[CH_EXPL11] [nvarchar](26) NULL,
	[CH_EXPL12] [nvarchar](26) NULL,
	[CH_EXPL13] [nvarchar](26) NULL,
	[CH_EXPL14] [nvarchar](26) NULL,
	[CH_EXPL15] [nvarchar](26) NULL,
	[CH_EXPL16] [nvarchar](26) NULL,
	[CH_EXPL17] [nvarchar](26) NULL,
	[CH_EXPL18] [nvarchar](26) NULL,
	[CH_EXPL19] [nvarchar](26) NULL,
	[CH_EXPL20] [nvarchar](26) NULL,
 CONSTRAINT [PK_NUMBDG] PRIMARY KEY CLUSTERED
(
	[NUMBDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]