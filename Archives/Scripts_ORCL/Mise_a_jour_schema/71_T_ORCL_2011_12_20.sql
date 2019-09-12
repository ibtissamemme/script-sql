ALTER TABLE VISITES  MODIFY LIEU VARCHAR2(60);
COMMIT; 
ALTER TABLE RESIDANTS MODIFY CPNOM VARCHAR2(250);
COMMIT; 
ALTER TABLE XANNEXE ADD ETAT NUMBER DEFAULT 1;
COMMIT;
ALTER TABLE XANNEXE ADD DATERETOUR DATE;
COMMIT;
ALTER TABLE XANNEXE MODIFY ETAT NUMBER DEFAULT 1 ;		   
COMMIT;

UPDATE XANNEXE SET ETAT=1 WHERE 1=1;
COMMIT;




ALTER TABLE TYPEDOCUMENT MODIFY IN_PREENREG NUMBER DEFAULT 2 ;		   
COMMIT;

UPDATE TYPEDOCUMENT SET IN_PREENREG=2 WHERE TYPEDOCUMENTID<>-2 ;
COMMIT;


UPDATE XANNEXE SET INFORMATION_TYPEID=1 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-1; 
UPDATE XANNEXE SET INFORMATION_TYPEID=2 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-2;
UPDATE XANNEXE SET INFORMATION_TYPEID=3 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-3;
UPDATE XANNEXE SET INFORMATION_TYPEID=4 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-4;
UPDATE XANNEXE SET INFORMATION_TYPEID=5 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-5;
UPDATE XANNEXE SET INFORMATION_TYPEID=6 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-6;
UPDATE XANNEXE SET INFORMATION_TYPEID=7 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-7;
UPDATE XANNEXE SET INFORMATION_TYPEID=8 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-8;
UPDATE XANNEXE SET INFORMATION_TYPEID=9 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-9;
UPDATE XANNEXE SET INFORMATION_TYPEID=10 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-10;
UPDATE XANNEXE SET INFORMATION_TYPEID=11 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-11;
UPDATE XANNEXE SET INFORMATION_TYPEID=12 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-12;
UPDATE XANNEXE SET INFORMATION_TYPEID=13 WHERE XANNEXE_TYPEID=-2 AND ORIGINE='VISITES' AND INFORMATION_TYPEID=-13;
COMMIT;

ALTER TABLE SITE ADD WIFI_PRESENT INT;
ALTER TABLE SITE ADD WIFI_LIB VARCHAR2(250);
ALTER TABLE SITE ADD WIFI_HOST VARCHAR2(250);
ALTER TABLE SITE ADD WIFI_LOGIN VARCHAR2(50);
ALTER TABLE SITE ADD WIFI_PWD VARCHAR2(50);
ALTER TABLE SITE ADD WIFI_GRP VARCHAR2(50);
ALTER TABLE SITE ADD WIFI_HFIN VARCHAR2(10);
COMMIT;

ALTER TABLE VISITES ADD WIFI_LOGIN VARCHAR2(50);
ALTER TABLE VISITES ADD WIFI_PWD VARCHAR2(50);
COMMIT;

ALTER TABLE SITE ADD TLMQ_SORTIE_FVISITE INT;
ALTER TABLE SITE ADD TLMQ_SORTIE_JOUR INT;
ALTER TABLE SITE ADD TLMQ_PURGE_PREENRG INT;
ALTER TABLE SITE ADD TLMQ_HEURE_FIN VARCHAR2(50);
ALTER TABLE SITE ADD TLMQ_HEURE_EXEC VARCHAR2(50);
ALTER TABLE SITE ADD TLMQ_DERN_EXEC DATE;
COMMIT;

CREATE TABLE LOGWIFI (
  LOGWIFIID NUMBER NOT NULL,
  VISITEID VARCHAR2(15 CHAR),
  SITEID VARCHAR2(15 CHAR),
  WIFI_LOGIN VARCHAR2(50 CHAR),
  WIFI_PWD VARCHAR2(50 CHAR),
  WIFI_ETAT VARCHAR2(50 CHAR),
  DATECREATION DATE,
  DATEMAJ DATE,
  DATESYNCHRO DATE,
CONSTRAINT PK_LOGWIFIID PRIMARY KEY (LOGWIFIID));

CREATE SEQUENCE SEQ_LOGWIFI;

EXIT;