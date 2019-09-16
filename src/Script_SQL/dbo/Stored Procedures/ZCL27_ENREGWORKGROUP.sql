﻿CREATE PROCEDURE [dbo].[ZCL27_ENREGWORKGROUP]
	@Name VARCHAR(40),
	@Id VARCHAR(20),
	@SiteID VARCHAR(14)
AS
	IF EXISTS (SELECT * FROM ZCL27_WORKGROUP WHERE WG_ID = @Id AND SITEID = @SiteID)
		UPDATE ZCL27_WORKGROUP SET WG_NAME = @Name, DATEMAJ = CURRENT_TIMESTAMP
			WHERE WG_ID = @Id AND SITEID = @SiteID
	ELSE
		INSERT INTO ZCL27_WORKGROUP (WG_NAME, WG_ID, SITEID, DATECREATION, DATEMAJ) VALUES (@Name, @Id, @SiteID, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)