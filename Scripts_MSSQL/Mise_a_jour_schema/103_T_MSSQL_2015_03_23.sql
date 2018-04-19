ALTER TABLE COLISRECU ADD POIDS VARCHAR(10);
GO

ALTER TABLE COLISRECU ADD SERVICEID VARCHAR(14);
GO
ALTER TABLE COLISEMIS ADD SERVICEID VARCHAR(14);
GO

UPDATE COLISRECU SET SERVICEID='VPARDEFAUT';
GO
UPDATE COLISEMIS SET SERVICEID='VPARDEFAUT';
GO

ALTER TABLE COLISEMIS ADD VALEUR VARCHAR(10);
GO

ALTER TABLE COLISRECU ADD NATURECOLISID INTEGER;
GO
ALTER TABLE COLISEMIS ADD NATURECOLISID INTEGER;
GO

UPDATE COLISRECU SET NATURECOLISID='0';
GO
UPDATE COLISEMIS SET NATURECOLISID='0';
GO
UPDATE COLISEMIS SET NATURECOLISID='-1' WHERE LETTRECOLIS='2';
GO

CREATE TABLE NATURECOLIS (
  NATURECOLISID INTEGER PRIMARY KEY,
  LIBELLE VARCHAR(50),
  DATECREATION DATETIME NOT NULL,
  DATEMAJ DATETIME NOT NULL);
GO

INSERT INTO NATURECOLIS (NATURECOLISID,LIBELLE,DATECREATION,DATEMAJ) VALUES (0,'LETTRE',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
INSERT INTO NATURECOLIS (NATURECOLISID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-1,'COLIS',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
INSERT INTO NATURECOLIS (NATURECOLISID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-2,'PAQUET',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
INSERT INTO NATURECOLIS (NATURECOLISID,LIBELLE,DATECREATION,DATEMAJ) VALUES (-3,'PALETTE',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
GO

ALTER TABLE RESIDANTS ADD CONTRAT VARCHAR(50);
GO