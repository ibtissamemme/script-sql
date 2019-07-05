
/****** Object:  StoredProcedure [dbo].[ZCL27_UPDATEEMPLOYEE]    Script Date: 05/07/2019 11:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ZCL27_UPDATEEMPLOYEE]
	@ID INT,
	@ECard VARCHAR(45),
	@ECardAssigned INT,
	@EID INT,
	@ELastUpdatedTime VARCHAR(19),
	@EReference INT,
	@EVisitor INT,
	@StatutSortie INT,
	@SiteID VARCHAR(14)
AS
	IF @StatutSortie = 1
		UPDATE ZCL27_BADGE SET B_ASSIGNED = @ECardAssigned WHERE B_CARD_NO = @ECard AND SITEID = @SiteID

	UPDATE ZCL27_EMPLOYEE SET
		E_CARDASSIGNED = @ECardAssigned,
		E_EMPLOYEEID = @EID,
		E_LASTUPDATEDTIME = @ELastUpdatedTime,
		E_REFERENCE = @EReference,
		E_VISITOR = @EVisitor,
		STATUT_SORTIE = @StatutSortie,
		DATEMAJ = CURRENT_TIMESTAMP
		WHERE ID_EMPLOYEE = @ID
GO
