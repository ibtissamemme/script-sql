ALTER TABLE DROITSTELEM ADD ETRANGER INT DEFAULT 0
GO

ALTER TABLE RESIDANTS ADD ETRANGER INT DEFAULT 0
GO

UPDATE DROITSTELEM SET ETRANGER=0
GO
UPDATE RESIDANTS SET ETRANGER=0
GO