CREATE TABLE TEMPSOC (
TMPID VARCHAR2(14 CHAR) NOT NULL,
TMPNOM  VARCHAR2(35 CHAR) NOT NULL,
TMPRANG INT,
TRAITE VARCHAR2(1 CHAR),
CONSTRAINT PK_TMPID PRIMARY KEY (TMPID));

CREATE TABLE TEMPSOC2 (
TMP2ID VARCHAR2(14 CHAR) NOT NULL,
TMPNOM  VARCHAR2(35 CHAR) NOT NULL,
TMPRANG INT,
TRAITE VARCHAR2(1 CHAR),
CONSTRAINT PK_TMP2ID PRIMARY KEY (TMP2ID)) ;

COMMIT;

CREATE INDEX TEMPSOC_TMPNOM ON TEMPSOC (TMPNOM);
CREATE INDEX TEMPSOC2_TMPNOM ON TEMPSOC2 (TMPNOM);

COMMIT;

CREATE TABLE DEDUP_DEDUP
( DEDUP1ID VARCHAR2(14 CHAR) NOT NULL,
  DEDUP2ID VARCHAR2(14 CHAR) NOT NULL,
  SIMIL_FLAG VARCHAR2(1 CHAR) DEFAULT('1'),
  ENTITE VARCHAR2(50 CHAR),
  JW INT,
 CONSTRAINT PK_DEDUP_DEDUPID PRIMARY KEY (DEDUP1ID,DEDUP2ID)
  ) ;
  COMMIT;

 ALTER TABLE VISITES MODIFY PROFIL_CTRL VARCHAR(4000 CHAR);
 ALTER TABLE VISITES MODIFY PROFIL_CTRL2 VARCHAR(4000 CHAR);
 ALTER TABLE VISITES MODIFY PROFIL_CTRL_ID VARCHAR(4000 CHAR);
 COMMIT;
 
 ALTER TABLE XANNEXE ADD DATESYNCHRO DATE ;
 COMMIT;
 
ALTER TABLE GRPSITE ADD DATESYNCHRO DATE ;
COMMIT;
ALTER TABLE GRPSITE MODIFY GRPSITEID VARCHAR2(14) NOT NULL ;
ALTER TABLE GRPSITE ADD PRiMARY KEY (GRPSITEID) ;
COMMIT;

ALTER TABLE GRPSITE_SITE MODIFY GRPSITEID VARCHAR2(14) NOT NULL;
ALTER TABLE GRPSITE_SITE MODIFY SITEID VARCHAR2(14) NOT NULL ;
COMMIT;
ALTER TABLE GRPSITE_SITE ADD CONSTRAINT PK_GRPSITE_SITE PRIMARY KEY (GRPSITEID,SITEID) ;
COMMIT;

 ALTER TABLE REGLE_ACTION MODIFY REGLEID NUMBER NOT NULL ;
 COMMIT;
 ALTER TABLE REGLE_ACTION MODIFY  ACTIONID NUMBER NOT NULL;
 COMMIT;
 ALTER TABLE REGLE_ACTION ADD CONSTRAINT PK_REGLE_ACTION PRIMARY KEY (REGLEID,ACTIONID);
 COMMIT;
 
ALTER TABLE FORMULAIRE_OFICHIER MODIFY FORMULAIREID INT NOT NULL  ;
 COMMIT;
ALTER TABLE FORMULAIRE_OFICHIER MODIFY  OFICHIERID INT NOT NULL ;
 COMMIT;
ALTER TABLE FORMULAIRE_OFICHIER ADD CONSTRAINT PK_FORMULAIRE_OFICHIERID PRIMARY KEY (FORMULAIREID,OFICHIERID)  ;
 COMMIT;
EXIT;