
/****** Object:  View [dbo].[V_LISTE_GRPVALIDEUR]    Script Date: 05/07/2019 11:18:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_LISTE_GRPVALIDEUR] AS (
	SELECT DISTINCT G.GRPVALIDEURID,G.GRPVALIDEURN FROM GRPVALIDEUR G,DROITSTELEM D WHERE G.GRPVALIDEURID=D.GRPVALIDEURID
)
GO
