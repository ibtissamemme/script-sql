ALTER TABLE OJOURNAL_PERSMVT ADD DATEVALIDITE DATETIME
GO
ALTER TABLE BONTRAVAIL ADD DATEVALIDITE DATETIME
GO

ALTER TABLE RAPPORT ALTER COLUMN DETAILS VARCHAR(8000);
GO
