ALTER TABLE VISITES ADD NATUREVISITE VARCHAR2(7 CHAR) DEFAULT('VISITE');
COMMIT;
UPDATE VISITES SET NATUREVISITE='VISITE' WHERE NATUREVISITE IS NULL;
COMMIT;

UPDATE VISITES SET NATUREVISITE= (SELECT CASE WHEN TRAVAIL='0' THEN 'VISITE' ELSE 'TRAVAIL' END FROM TYPEVISITE WHERE TYPEVISITEID=VISITES.TYPEVISITEID);
COMMIT;

UPDATE VISITES SET NATUREVISITE='TRAVAIL' WHERE TYPEVISITEID='1';
COMMIT;
UPDATE VISITES SET NATUREVISITE='VISITE' WHERE TYPEVISITEID<>'1';
COMMIT;

--ALTER TABLE VISITES MODIFY NATUREVISITE VARCHAR2(7) DEFAULT ('VISITE');
--COMMIT;

UPDATE REGLES SET NATUREVISITE='-2' ;
COMMIT;