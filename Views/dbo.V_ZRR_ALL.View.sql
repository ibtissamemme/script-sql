
/****** Object:  View [dbo].[V_ZRR_ALL]    Script Date: 05/07/2019 11:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ZRR_ALL]  AS
  SELECT [ID_ZRR],[CODE],SUBSTRING([LIBELLE],0,50) AS LIBELLE,[DEB_VALITE],[FIN_VALIDITE],[ACTIVE],[ZONE_PARTENAIRE],[CENTRE],[SITEID],[LOCAUX_SENSIBLES],[DCREA],[DDERMAJ] FROM ZRR
GO
