ALTER TABLE VISITES ADD NATUREVISITE VARCHAR(7) DEFAULT 'VISITE'
GO
UPDATE VISITES SET NATUREVISITE='VISITE' WHERE NATUREVISITE IS NULL
GO
UPDATE VISITES SET NATUREVISITE= (SELECT CASE WHEN TRAVAIL='0' THEN 'VISITE' ELSE 'TRAVAIL' END FROM TYPEVISITE WHERE TYPEVISITEID=VISITES.TYPEVISITEID);
GO
--ALTER TABLE VISITES ALTER COLUMN NATUREVISITE VARCHAR(7) DEFAULT 'VISITE'
--GO
UPDATE REGLES SET NATUREVISITE='-2' WHERE NATUREVISITE IS NULL
GO