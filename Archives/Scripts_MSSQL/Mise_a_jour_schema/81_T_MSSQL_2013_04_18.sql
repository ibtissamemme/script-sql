ALTER TABLE VISITES ADD REFIMPORTATION VARCHAR(30) DEFAULT('UNIS');
GO
UPDATE VISITES SET REFIMPORTATION='UNIS' WHERE REFIMPORTATION IS NULL;
GO
