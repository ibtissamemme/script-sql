ALTER TABLE OJOURNAL ADD CODESALLE VARCHAR(14) DEFAULT ('VPARDEFAUT')
GO

UPDATE OJOURNAL SET CODESALLE='VPARDEFAUT' WHERE CODESALLE IS NULL
GO
