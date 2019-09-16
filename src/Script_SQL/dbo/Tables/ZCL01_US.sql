CREATE TABLE [dbo].[ZCL01_US](
	[NUMBDG] [varchar](14) NOT NULL,
	[NOM] [varchar](24) NULL,
	[PRENOM] [varchar](24) NULL,
	[TYPEV] [varchar](1) NULL,
	[MATRIC] [varchar](15) NULL,
	[SERVIC] [varchar](24) NULL,
	[NOMSTE] [varchar](15) NULL,
	[CH_EXPL01] [varchar](26) NULL,
	[CH_EXPL02] [varchar](26) NULL,
	[CH_EXPL03] [varchar](26) NULL,
	[CH_EXPL04] [varchar](26) NULL,
	[CH_EXPL05] [varchar](26) NULL,
	[CH_EXPL06] [varchar](26) NULL,
	[CH_EXPL07] [varchar](26) NULL,
	[CH_EXPL08] [varchar](26) NULL,
	[CH_EXPL09] [varchar](26) NULL,
	[CH_EXPL10] [varchar](26) NULL,
	[CH_EXPL11] [varchar](26) NULL,
	[CH_EXPL12] [varchar](26) NULL,
	[CH_EXPL13] [varchar](26) NULL,
	[CH_EXPL14] [varchar](26) NULL,
	[CH_EXPL15] [varchar](26) NULL,
	[CH_EXPL16] [varchar](26) NULL,
	[CH_EXPL17] [varchar](26) NULL,
	[CH_EXPL18] [varchar](26) NULL,
	[CH_EXPL19] [varchar](26) NULL,
	[CH_EXPL20] [varchar](26) NULL,
 CONSTRAINT [PK_NUMBDG] PRIMARY KEY CLUSTERED
(
	[NUMBDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]