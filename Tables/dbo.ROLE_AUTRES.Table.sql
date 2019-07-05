
/****** Object:  Table [dbo].[ROLE_AUTRES]    Script Date: 05/07/2019 11:18:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE_AUTRES](
	[USERID] [int] NULL,
	[SITE] [int] NULL,
	[SOC_RES] [int] NULL,
	[DIRECTIONS] [int] NULL,
	[PAYS] [int] NULL,
	[UTILISATEURS] [int] NULL,
	[TYPEUSER] [int] NULL,
	[PROFILUSER] [int] NULL,
	[MODIFAFF] [int] NULL,
	[VILLES] [int] NULL,
	[DATECREATION] [datetime] NULL,
	[DATEMAJ] [datetime] NULL,
	[GRPSITE] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ROLE_AUTRES] ADD  DEFAULT ((0)) FOR [GRPSITE]
GO
