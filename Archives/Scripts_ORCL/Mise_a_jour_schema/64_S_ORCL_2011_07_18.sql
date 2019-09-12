CREATE TABLE XANNEXE(
	XANNEXEID VARCHAR2(14) PRIMARY KEY,
	XANNEXE_TYPEID INT DEFAULT ('0'),
	ORIGINEID VARCHAR2(14),
	ORIGINE INT,
	OFICHIERID INT,
	STATUTID INT DEFAULT ((0)),
	DATEFIN DATE,
	FREE01 VARCHAR2(50),
	FREE02 VARCHAR2(50),
	FREE03 VARCHAR2(50),
	FREE04 VARCHAR2(50),
	FREE05 VARCHAR2(50),
	FREE06 VARCHAR2(50),
	FREE07 VARCHAR2(50),
	FREE08 VARCHAR2(50),
	FREE09 VARCHAR2(50),
	FREEDATE01 DATE,
	FREEDATE02 DATE,
	INFORMATION_TYPEID INT,
	DATECREATION DATE NOT NULL,
	DATEMAJ DATE NOT NULL
);
COMMIT;

ALTER TABLE XANNEXE ADD ORIGINE_TEMP VARCHAR2(50);
UPDATE XANNEXE SET ORIGINE_TEMP=ORIGINE;
ALTER TABLE XANNEXE DROP COLUMN ORIGINE;
ALTER TABLE XANNEXE ADD ORIGINE VARCHAR2(50);
UPDATE XANNEXE SET ORIGINE=ORIGINE_TEMP;
ALTER TABLE XANNEXE DROP COLUMN ORIGINE_TEMP;
COMMIT;

UPDATE XANNEXE SET ORIGINE='INTERLOCUTEUR' WHERE ORIGINE='0';
UPDATE XANNEXE SET ORIGINE='PERSONNEL' WHERE ORIGINE='1';
COMMIT;

UPDATE XANNEXE SET ORIGINE='INTERLOCUTEUR' WHERE ORIGINE='-1';
UPDATE XANNEXE SET ORIGINE='SOCIETE' WHERE ORIGINE='-2';
UPDATE XANNEXE SET ORIGINE='VISITES' WHERE ORIGINE='-3';
COMMIT;
EXIT;