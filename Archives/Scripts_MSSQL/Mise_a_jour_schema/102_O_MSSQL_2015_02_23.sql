ALTER TABLE POSTE ADD CODESALLE VARCHAR(14)
GO

ALTER TABLE POSTE ADD BATIMENTID VARCHAR(14)
GO

CREATE TABLE MISSION_AGENT (
  MISSIONID INT,
  PERSONNELID INT
);
GO
