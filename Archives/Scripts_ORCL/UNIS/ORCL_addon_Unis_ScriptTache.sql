- Auparavant exécuter le script ORLC_4_Unis_tablereference.sql

CREATE TABLE TACHE (
TACHEID	INTEGER PRIMARY KEY,
TACHE_NOM	VARCHAR2(200 CHAR),
TACHE_RANG	INTEGER DEFAULT 0,
TYPEJOUR	VARCHAR2(20 CHAR),
HEUREEXECUTION	DATE,
ACT_NOM	VARCHAR2(50 CHAR),
ACT_PARAM	VARCHAR2(100 CHAR),
FREE01 VARCHAR2(50 CHAR),
FREE02 VARCHAR2(50 CHAR),
FREE03 VARCHAR2(50 CHAR),
MODEA	INTEGER DEFAULT 0,
ACTIF	INTEGER DEFAULT 1,
PROCHAINEEXECUTION DATE,
DERNIEREEXECUTION DATE,
DERNIERRESULTAT	INTEGER DEFAULT 1,
SITEID	VARCHAR2(20 CHAR),
GROUPEDESTID	INTEGER,
NUMSESSIONPROCHAINEEXECUTION INTEGER,
DATECREATION DATE NOT NULL,
DATEMAJ DATE
);
COMMIT;
CREATE SEQUENCE SEQ_TACHE;
COMMIT;
 
CREATE TABLE CORRESPONDANCE(
	Corresid int primary key,
	libsSrc varchar2(240),
	rangsSrc varchar2(20),
	libDst varchar2(80),
	cfg_fichierid int,
	corres_rang int,
	datemaj date,
	datecreation date
);
commit;
CREATE SEQUENCE SEQ_CORRESPONDANCE;
COMMIT;

CREATE TABLE CFG_FICHIER (
  CFG_FICHIERID NUMBER PRIMARY KEY,
  TYPECFG VARCHAR2(20),
  LIBELLE VARCHAR2(200 CHAR),
  DOCUMENT1 VARCHAR2(4000 CHAR),
  DOCUMENT2 VARCHAR2(4000 CHAR),
  DOCUMENT BLOB,
  TYPEFILE INTEGER,
  CONTENTTYPE VARCHAR2(50 CHAR),
  DATASIZE INTEGER,
  STATUT INTEGER DEFAULT 1,
  DATEMAJ DATE,
  DATECREATION DATE,
  DATESYNCHRO DATE
);
COMMIT;

CREATE SEQUENCE SEQ_CFG_FICHIER;
COMMIT;

DROP TABLE ETATS;
COMMIT;
CREATE TABLE ETATS
(
ETATID		INT	PRIMARY KEY,
LIBELLE		VARCHAR2(100 CHAR),
REQUETE_MSSQL		VARCHAR2(4000 CHAR),
REQUETE_ORACLE		VARCHAR2(4000 CHAR),
MODIFICATION	VARCHAR2(1000 CHAR),
MODIFICATION_OPERATEUR	VARCHAR2(1000 CHAR),
MODIFICATION_VALEUR	VARCHAR2(1000 CHAR),
DATECREATION	DATE NOT NULL,
DATEMAJ			DATE NOT NULL
);
COMMIT;

CREATE SEQUENCE SEQ_ETATS;
COMMIT;

CREATE TABLE TACHE_LOG(
	logid NUMBER NOT NULL,
	tacheid NUMBER ,
	numsession NUMBER ,
	userid varchar2(14),
	datecreation DATE,
	freeflag01 NUMBER,
	freeflag02 NUMBER,
	freeflag03 NUMBER,
	freeflag04 NUMBER,
	idligne varchar2(14),
	niveausecu NUMBER,
	commentaire varchar2(4000),
	PRIMARY KEY (logid) );
COMMIT;

CREATE SEQUENCE SEQ_TACHE_LOG;
COMMIT;

CREATE OR REPLACE function split(input_list varchar2, ret_this_one number, delimiter varchar2)
return varchar2
is
 v_list varchar2(32767) := delimiter || input_list;
 start_position number;
 end_position number;
begin
 start_position := instr(v_list, delimiter, 1, ret_this_one);
 if start_position > 0 then
  end_position := instr( v_list, delimiter, 1, ret_this_one + 1);
  if end_position = 0 then
   end_position := length(v_list) + 1;
  end if;
  return(substr(v_list, start_position + 1, end_position - start_position - 1));
 else
  return NULL;
 end if;
end split;
/
COMMIT;

CREATE OR REPLACE PROCEDURE PS_SITE(
 E_flagin IN INT,
 E_siteid IN VARCHAR2,
 E_ID OUT VARCHAR2
)

IS
TMP INT;
BEGIN
	E_ID:=null;
	SELECT COUNT(*) INTO TMP FROM SITE  WHERE SITEID = E_siteid;
	IF TMP>0 THEN
		SELECT siteid INTO E_ID FROM SITE  WHERE SITEID = E_siteid;
	ELSE
		SELECT COUNT(*) INTO TMP FROM SITE  WHERE UPPER(LIBELLE) = UPPER(E_siteid);
		IF TMP>0 THEN
		 SELECT *  INTO E_ID  FROM(SELECT siteid FROM SITE  WHERE UPPER(LIBELLE) = UPPER(E_siteid)) WHERE ROWNUM=1;
		ELSE
			IF E_flagin=0 THEN
				E_ID := 'VPARDEFAUT';
			ELSE
				E_ID := NULL;
			END IF;
		END IF;
	END IF;
END;
/
COMMIT;

CREATE OR REPLACE PROCEDURE PS_NATURE(
E_flagin INT,
E_champctrl IN varchar2,
 E_nature IN VARCHAR2,
 E_abrege IN VARCHAR2,
 E_tvisite VARCHAR2,
 E_interdit VARCHAR2,
 E_ID out VARCHAR2
)
IS
 flag VARCHAR2(14);
 myid VARCHAR2(14);
 interd VARCHAR2(1);
 TMP INT;
BEGIN
	E_ID:= null;
	SELECT COUNT(*) INTO TMP FROM NATURE WHERE NATUREID= E_nature;
	IF TMP>0 THEN
		SELECT NATUREID INTO E_ID FROM nature WHERE natureid = E_nature and rownum=1;
	END IF;
	IF E_ID IS NOT NULL THEN
		E_ID := E_nature + ',0,0';
	ELSE
		IF (E_nature IS NULL) OR LTRIM(E_nature) is null THEN
			E_ID := 'VPARDEFAUT,0,0';
		ELSE
			--nature1 := UPPER(nature1);
			SELECT COUNT(*) INTO TMP FROM NATURE WHERE UPPER(libelle) =  UPPER(E_nature);
			IF TMP>0 THEN
				SELECT NATUREID INTO E_ID FROM nature WHERE UPPER(libelle) =  UPPER(E_nature) and rownum=1;
			END IF;
			IF E_ID IS NOT NULL THEN
				SELECT natureid INTO E_ID FROM nature WHERE libelle = UPPER(E_nature) AND ROWNUM = 1;
				E_ID := E_ID || ',0,0';
			ELSE
			--INSERT INTO SEQ_myid(libelle) VALUES ('OK');
				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;
				interd := E_interdit;
				IF (interd IS NULL) OR (LTRIM(interd) IS NULL) THEN
					interd := '0';
				END IF;
				INSERT INTO nature(natureid, libelle,abrege,tvisite, interdit, debutinterdit, fininterdit, datecreation, datemaj) VALUES(E_ID, UPPER(E_nature),E_abrege,E_tvisite,interd, SYSDATE - 1, SYSDATE + 36525, SYSDATE, SYSDATE);
				COMMIT;
				E_ID := E_ID || ',1,0';
			END IF;
		END IF;
	END IF;
END;
/

COMMIT;

CREATE OR REPLACE PROCEDURE PS_PAYS(
   E_flagin INT,
	E_champctrl IN varchar2,
	E_libelle VARCHAR2,
	E_libellegr VARCHAR2,
	E_libelleus VARCHAR2,
	E_nationalite VARCHAR2,
	E_codeiso1 VARCHAR2,
	E_codeiso2 VARCHAR2,
	E_codeiso3 VARCHAR2,
	E_indicatif VARCHAR2,
	E_shortlib VARCHAR2,
	E_devise VARCHAR2,
	E_deviselibelle VARCHAR2,
	E_interdit VARCHAR2,
	E_debutinterdit DATE,
	E_fininterdit DATE,
	E_enquete1 VARCHAR2,
	E_statut1 VARCHAR2,
	E_enquete2 VARCHAR2,
	E_statut2 VARCHAR2,
	E_enquete3 VARCHAR2,
	E_statut3 VARCHAR2,
	E_ID OUT VARCHAR2
)
IS
 flag VARCHAR2(14);
 myid VARCHAR2(14);
 TMP INT;
BEGIN
	SELECT COUNT(*) INTO TMP FROM PAYS WHERE PAYSID = E_libelle;
	IF TMP>0 THEN
		SELECT PAYSID INTO E_ID FROM PAYS WHERE PAYSID = E_libelle  and rownum=1;
		E_ID := E_libelle ||',0,0';
	ELSE
		IF (E_libelle IS NULL) OR LTRIM(E_libelle) IS NULL THEN
			E_ID := 'VPARDEFAUT,0,0';
		ELSE
			SELECT COUNT(*) INTO TMP FROM PAYS WHERE UPPER(libelle) = UPPER(E_libelle);
			IF TMP>0 THEN
				SELECT PAYSID INTO E_ID FROM pays WHERE UPPER(libelle) = UPPER(E_libelle) AND ROWNUM=1;
				UPDATE pays SET libelle = UPPER(E_libelle), libellegr = E_libellegr, libelleus = E_libelleus, nationalite = E_nationalite, codeiso2 = E_codeiso2, codeiso3 = E_codeiso3, indicatif = E_indicatif, deviselibelle = E_deviselibelle, datemaj = SYSDATE WHERE paysid = E_ID;
				COMMIT;
				E_ID := E_ID || ',0,1';
			ELSE
				SELECT COUNT(*) INTO TMP FROM PAYS  WHERE UPPER(NATIONALITE) = UPPER(E_nationalite);
				IF TMP>0 THEN
					SELECT PAYSID INTO E_ID FROM pays  WHERE UPPER(nationalite) = UPPER(E_nationalite) AND ROWNUM = 1;
					E_ID := E_ID || ',0,0';
				ELSE
					SELECT COUNT(*) INTO TMP  FROM PAYS  WHERE UPPER(libelle) ='INCONNU';
					IF TMP>0 THEN
						SELECT PAYSID INTO E_ID FROM pays WHERE UPPER(libelle) ='INCONNU' AND ROWNUM = 1;
						E_ID := E_ID || ',0,0';
					ELSE
						IF E_flagin=1  THEN
						--INSERT INTO SEQ_IDENTITY(libelle) VALUES ('OK');
							SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
							SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
							E_ID := flag || myid;
							INSERT INTO pays (paysid, libelle, libellegr, libelleus, nationalite, codeiso1,codeiso2, codeiso3, indicatif, shortlib,devise,deviselibelle,interdit, debutinterdit, fininterdit, enquete1,statut1,enquete2,statut2,enquete3,statut3,datecreation, datemaj)
							VALUES(E_ID, E_libelle, E_libellegr,E_libelleus, E_nationalite, E_codeiso1,E_codeiso2, E_codeiso3,E_indicatif,E_shortlib,E_devise,E_deviselibelle,0, E_debutinterdit, E_fininterdit, E_enquete1,E_statut1,E_enquete2,E_statut2,E_enquete3,E_statut3,SYSDATE,SYSDATE);

							COMMIT;
							E_ID := E_ID || ',1,0';
						ELSE
							E_ID:='VPARDEFAUT,0,0';
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;
END;
/
COMMIT;

CREATE OR REPLACE PROCEDURE PS_VILLE(
	E_flagin INT,
	E_champctrl VARCHAR2,
	E_codepostal VARCHAR2,
	E_phonkey IN VARCHAR2,
	E_ville IN VARCHAR2,
	E_paysid IN VARCHAR2,
	E_ID OUT VARCHAR2
	)
IS
	idpays VARCHAR2(14);
	flag VARCHAR2(14);
	myid VARCHAR2(14);
	TMP INT;
	nbinsert INT;
	nbupdate INT;
	datejour DATE;

BEGIN
	datejour:=SYSDATE;
	nbinsert:=0;
	nbupdate:=0;
	SELECT COUNT(*) INTO TMP FROM VILLE WHERE CODEVILLE=E_ville;
	IF TMP>0 THEN
		E_ID := E_ville || ',0,0';
	ELSE
		IF (E_ville IS NULL) OR (LTRIM(E_ville) IS NULL) THEN
			E_ID := '0,0,0';
		ELSE
			SELECT COUNT(*) INTO TMP FROM ville WHERE UPPER(ville) = UPPER(E_ville) AND codepostal = E_codepostal ;
			IF TMP>0 THEN
				SELECT * INTO E_ID FROM (SELECT codeville FROM ville WHERE UPPER(ville) = UPPER(E_ville) AND codepostal = E_codepostal) WHERE ROWNUM=1;

				   PS_PAYS(0,'',E_paysid, E_paysid,'',E_paysid, E_paysid,'','','','','','','',datejour,datejour,'','','','','','',idpays);

				nbinsert:=nbinsert+CAST(split(idpays,2,',') AS int) ;
				nbupdate:=nbupdate+CAST(split(idpays,3,',') AS int) ;
				idpays := Split(idpays,1,',') ;

				UPDATE ville SET paysid = idpays, datemaj = SYSDATE WHERE codeville = E_ID;
				COMMIT;
				E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate + 1) ;
			ELSE
			    PS_PAYS(0,'',E_paysid, E_paysid,'',E_paysid, E_paysid,'','','','','','','',datejour,datejour,'','','','','','',idpays);
				--PS_PAYS(0,paysE_ID, paysE_ID, '', paysE_ID, '', '', '', idpays);

				nbinsert:=nbinsert+CAST(split(idpays,2,',') AS int) ;
				nbupdate:=nbupdate+CAST(split(idpays,3,',') AS int) ;
				idpays := Split(idpays,1,',') ;

				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;

				INSERT INTO ville(codeville, ville, codepostal, paysid,phonkey, datecreation, datemaj) VALUES(E_ID, UPPER(E_ville), E_codepostal, idpays,E_phonkey, SYSDATE, SYSDATE);
				COMMIT;
				 E_ID := E_ID || ',' || TO_CHAR(nbinsert + 1) || ',' || TO_CHAR(nbupdate);
			END IF;
		END IF;
	END	IF;
END;
/

COMMIT;


CREATE OR REPLACE PROCEDURE PS_SOCIETE(
 E_flagin INT,
 E_champctrl VARCHAR2,
 E_natureid IN  varchar2,
 E_nom IN OUT VARCHAR2,
 E_siret IN VARCHAR2,
 E_departement IN VARCHAR2,
 E_adresse2 IN VARCHAR2,
 E_cp IN VARCHAR2,
 E_ville IN VARCHAR2,
 E_pays IN VARCHAR2,
 E_province IN varchar2,
 E_telephone IN varchar2,
 E_fax IN varchar2,
 E_email IN varchar2,
 E_web IN varchar2,
 E_isresidant IN varchar2,

 E_ID OUT varchar2)
IS
 nbupdate int;
 nbinsert int;
 flag VARCHAR2(14);
 myid VARCHAR2(14);
 TMP  int;
 locid VARCHAR2(40);
 interdit NUMBER;
 externalid VARCHAR2(24);
BEGIN
	interdit:= 0;
	externalid:= 'VPARDEFAUT';
   nbupdate :=0;
	nbinsert :=0;
	SELECT count(*) INTO TMP FROM societe WHERE societeid = E_nom;
	IF TMP>0 THEN
		SELECT SOCIETEID INTO E_ID FROM SOCIETE WHERE SOCIETEID=E_nom AND ROWNUM=1;
		E_ID:= E_ID ||',0,0';
	ELSE
		IF (E_nom IS NULL) OR LTRIM(E_nom) IS NULL THEN
			E_ID := 'VPARDEFAUT,0,0';
		ELSE
			--E_nom := UPPER(E_nom);
			PS_NATURE (0,'',E_natureid,'','','',locid);

			nbupdate := nbupdate + CAST( Split(locid,3,',')  as int);
			nbinsert := nbinsert + CAST( Split(locid,2,',')  as int);
			locid := Split(locid,1,',') ;

			SELECT count(*) INTO TMP FROM societe WHERE UPPER(nom) = UPPER(E_nom) ;
			IF TMP>0 THEN
				SELECT * INTO E_ID FROM( SELECT societeid FROM societe WHERE UPPER(nom) = UPPER(E_nom)) WHERE ROWNUM=1;
				UPDATE societe SET siret = E_siret, departement = E_departement, adresse = E_adresse2, cp = E_cp, ville = E_ville, pays = E_pays, natureid = locid, telephone = E_telephone, fax = E_fax, email = E_email, web = E_web,province = E_province,isresidant = E_isresidant
				WHERE societeid = E_ID;

				E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate+1);
				COMMIT;
			ELSE
					SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
					SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
					E_ID := flag || myid;
					INSERT INTO societe(societeid, nom, interdit, isresidant,externalid,debutinterdit, fininterdit, datecreation, datemaj,fax,email,web,natureid,adresse2,cp,ville,pays,province,telephone)
					VALUES(E_ID, E_nom, interdit,E_isresidant,'VPARDEFAUT', SYSDATE - 1, SYSDATE + 36525, SYSDATE, SYSDATE,E_fax,E_email,E_web,locid,E_adresse2,E_cp,E_ville,E_pays,E_province,E_telephone);
					nbinsert:=nbinsert+1;
					E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
					COMMIT;
			END IF;
		END IF;
	END IF;
END ;
/
COMMIT;



CREATE OR REPLACE PROCEDURE PS_DEPARTEMENT(
E_flagin INT,
E_champctrl VARCHAR2,
E_societeid IN VARCHAR2,
E_libelle IN VARCHAR2,
E_ID OUT VARCHAR2
)
IS
nbupdate int;
nbinsert int;
 flag VARCHAR2(14);
 myid VARCHAR2(14);
idsociete VARCHAR2(35);
libel VARCHAR2(40);
TMP INT;
BEGIN
	nbupdate := 0;
	nbinsert := 0;
	SELECT COUNT(*) INTO TMP FROM DEPARTEMENT	WHERE  DEPTID = E_libelle ;
	IF TMP>0 THEN
		SELECT DEPTID INTO E_ID	FROM DEPARTEMENT WHERE DEPTID = E_libelle and rownum=1;
		E_ID := E_ID||',1,0';
	ELSE
		idsociete := E_societeid;
		PS_SOCIETE(0,'','',idsociete,'','','','','','','','','','','','',idsociete);
		nbupdate := nbupdate + CAST( Split(idsociete,3,',') as int);
		nbinsert := nbinsert + CAST( Split(idsociete,2,',') as int);
		idsociete := Split(idsociete,1,',');
		libel:=E_libelle;
		--idsociete:='VPARDEFAUT';
		SELECT COUNT(*) INTO TMP FROM DEPARTEMENT WHERE UPPER(LIBELLE) = UPPER(E_libelle) AND SOCIETEID=idsociete;
		IF TMP>0 THEN
			SELECT * INTO E_ID FROM (SELECT DEPTID FROM DEPARTEMENT WHERE UPPER(LIBELLE) = UPPER(E_libelle) AND SOCIETEID=idsociete ) WHERE ROWNUM=1;
			E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
		ELSE
			 IF (libel IS NOT NULL) OR ((E_libelle IS NOT NULL) AND LTRIM(E_libelle) IS NOT NULL) THEN
				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;
				INSERT INTO DEPARTEMENT (DEPTID,LIBELLE,SOCIETEID,DATECREATION,DATEMAJ) VALUES (E_ID,libel,idsociete,SYSDATE,SYSDATE);
				COMMIT;
				nbinsert:=nbinsert+1;
				E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
			ELSE
				E_ID:='VPARDEFAUT';
				E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
			END IF;
		END IF;
	END IF;
END;
/
COMMIT;

CREATE OR REPLACE PROCEDURE PS_SERVICE(
E_flagin INT,
E_champctrl VARCHAR2,
E_deptid IN VARCHAR2,
E_libelle IN VARCHAR2,
E_ID OUT VARCHAR2
)
IS
nbupdate int;
nbinsert int;
flag VARCHAR2(14);
myid VARCHAR2(14);
iddepartement VARCHAR2(40);
TMP INT;
BEGIN
	nbinsert:=0;
	nbupdate:=0;
	SELECT COUNT(*) INTO TMP FROM SERVICE S,DEPARTEMENT D WHERE S.DEPTID = D.DEPTID AND SERVICEID = E_libelle AND (S.DEPTID = E_deptid or D.LIBELLE = E_deptid);
	IF TMP>0 THEN
		E_ID := E_libelle || ',0,0';
	ELSE

		PS_DEPARTEMENT(0,'','',E_deptid,iddepartement);
		nbupdate := nbupdate + CAST( Split(iddepartement,3,',') as int);
		nbinsert := nbinsert + CAST( Split(iddepartement,2,',') as int);
		iddepartement := Split(iddepartement,1,',');

		SELECT COUNT(*) INTO TMP FROM SERVICE WHERE UPPER(LIBELLE) = UPPER(E_libelle) AND DEPTID=iddepartement;
		IF TMP>0 THEN
			SELECT SERVICEID INTO E_ID	FROM SERVICE WHERE UPPER(LIBELLE) = UPPER(E_libelle) AND DEPTID=iddepartement AND ROWNUM=1;
			E_ID := E_ID ||',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
		ELSE
			 IF (E_libelle IS NOT NULL) AND LTRIM(E_libelle) IS NOT NULL THEN
				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;
				INSERT INTO SERVICE (SERVICEID,LIBELLE,DEPTID,DATECREATION,DATEMAJ) VALUES (E_ID,E_libelle,iddepartement,SYSDATE,SYSDATE);
				COMMIT;
				nbinsert:=nbinsert+1;
				E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
			ELSE
				E_ID := 'VPARDEFAUT'||',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
			END IF;
		END IF;
	END IF;

END;
/

COMMIT;

CREATE OR REPLACE PROCEDURE PS_BATIMENT(
E_flagin INT,
E_champctrl VARCHAR2,
E_siteid IN VARCHAR2,
E_LIBELLE IN VARCHAR2,
E_ADRESSE varchar2,
E_ID OUT VARCHAR2
)
as
flag VARCHAR2(14);
myid VARCHAR2(14);
idsite VARCHAR2(18);
TMP INT;
nbupdate int;
nbinsert int;
E_blobADRESSE blob;
BEGIN
SELECT COUNT(*) INTO TMP FROM BATIMENT 	WHERE BATIMENTID = E_LIBELLE ;
	IF TMP>0 THEN
		SELECT BATIMENTID INTO E_ID	FROM BATIMENT WHERE BATIMENTID = E_LIBELLE and rownum=1;
		E_ID := E_ID ||',0,0';
	ELSE
		idsite := E_siteid;

		PS_SITE(0,E_siteid,idsite);

		SELECT COUNT(*) INTO TMP FROM BATIMENT WHERE UPPER(LIBELLE) = UPPER(E_LIBELLE) AND SITEID=idsite;
		IF TMP>0 THEN
			SELECT * INTO E_ID FROM (SELECT BATIMENTID FROM BATIMENT WHERE UPPER(LIBELLE )= UPPER(E_LIBELLE) AND SITEID=idsite) WHERE ROWNUM=1;
			E_ID := E_ID || ',0,0';
		ELSE
			 IF (E_LIBELLE IS NOT NULL) AND (LTRIM(E_LIBELLE) IS NOT NULL) THEN
				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;

				--E_blobADRESSE := TO_BLOB(E_ADRESSE);

				INSERT INTO BATIMENT (BATIMENTID,LIBELLE,SITEID,DATECREATION,DATEMAJ,ADRESSE) VALUES (E_ID,E_LIBELLE,idsite,SYSDATE,SYSDATE,E_ADRESSE);
				COMMIT;
				E_ID := E_ID || ',1,0';
			ELSE
				E_ID := 'VPARDEFAUT,0,0';
			END IF;
		END IF;
	END IF;

END;
/

COMMIT;

CREATE OR REPLACE PROCEDURE PS_ETAGE(
E_flagin INT,
E_champctrl VARCHAR2,
E_batimentid IN VARCHAR2,
E_libelle IN VARCHAR2,
E_ID OUT VARCHAR2
)
IS
nbupdate int;
nbinsert int;
flag VARCHAR2(14);
myid VARCHAR2(14);

TMP INT;
BEGIN
	nbinsert:=0;
	nbupdate:=0;
	SELECT COUNT(*) INTO TMP FROM ETAGES WHERE ETAGEID = E_libelle ;
	IF TMP>0 THEN
		E_ID := E_libelle || ',0,0';
	ELSE
		SELECT COUNT(*) INTO TMP FROM ETAGES WHERE UPPER(ETAGE) = UPPER(E_libelle) AND BATIMENTID=E_batimentid;
		IF TMP>0 THEN
			SELECT * INTO E_ID FROM (SELECT ETAGEID FROM ETAGES WHERE UPPER(ETAGE) = UPPER(E_libelle) AND BATIMENTID=E_batimentid) WHERE ROWNUM=1;
			E_ID := E_ID ||',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
		ELSE
			 IF (E_libelle IS NOT NULL) AND LTRIM(E_libelle) IS NOT NULL  THEN
				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;
				INSERT INTO ETAGES (ETAGEID,ETAGE,BATIMENTID,DATECREATION,DATEMAJ) VALUES (E_ID,E_libelle,E_batimentid,SYSDATE,SYSDATE);
				COMMIT;
				nbinsert:=nbinsert+1;
				E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
			ELSE
				E_ID := 'VPARDEFAUT'||',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
			END IF;
		END IF;
	END IF;

END;
/

COMMIT;

CREATE OR REPLACE PROCEDURE PS_SALLE(
E_flagin INT,
E_champctrl VARCHAR2,
E_siteid IN VARCHAR2,
E_batimentid IN VARCHAR2,
E_nosalle IN VARCHAR2,
E_Telephone IN VARCHAR2,
E_porte_cle IN VARCHAR2,
E_Porte_option IN VARCHAR2,
E_LIBELLE IN VARCHAR2,
E_ID OUT VARCHAR2
)
as
flag VARCHAR2(14);
myid VARCHAR2(14);
idsite VARCHAR2(18);
idbatiment VARCHAR2(20);
libbatiment VARCHAR2(35);
libsite VARCHAR2(35);
mysortorder NUMBER;
mynosalle VARCHAR2(15);
TMP INT;
nbupdate int;
nbinsert int;
BEGIN
	SELECT COUNT(*) INTO TMP FROM SALLE WHERE CODESALLE = E_LIBELLE ;
	IF TMP>0 THEN
		SELECT CODESALLE INTO E_ID	FROM SALLE WHERE CODESALLE = E_LIBELLE and rownum=1;
		E_ID := E_ID ||',0,0';
	ELSE
		idsite := E_siteid;
		PS_SITE(0,E_siteid,idsite);
		IF idsite='VPARDEFAUT' THEN
			SELECT LIBELLE INTO libsite FROM SITE WHERE SITEID='VPARDEFAUT' and rownum=1;
		END IF;
		PS_BATIMENT(0,'',idsite,E_batimentid,'',idbatiment);
		nbupdate := nbupdate + CAST( Split(idbatiment,3,',') as int);
		nbinsert := nbinsert + CAST( Split(idbatiment,2,',') as int);
		idbatiment := SUBSTR(Split(idbatiment,1,','),1,14);
		IF idbatiment='VPARDEFAUT' THEN
			SELECT LIBELLE INTO libbatiment FROM BATIMENT WHERE BATIMENTID='VPARDEFAUT' and rownum=1;
		END IF;
		SELECT COUNT(*) INTO TMP FROM SALLE WHERE UPPER(LIBELLE) = UPPER(E_LIBELLE) AND BATIMENTID=idbatiment AND SITEID=idsite;
		IF TMP>0 THEN
			SELECT * INTO E_ID FROM (SELECT CODESALLE FROM SALLE WHERE UPPER(LIBELLE )= UPPER(E_LIBELLE) AND BATIMENTID=idbatiment AND SITEID=idsite) WHERE ROWNUM=1;
			E_ID := E_ID || ',0,0';
		ELSE
			IF (E_LIBELLE IS NOT NULL) AND (LTRIM(E_LIBELLE) IS NOT NULL) THEN
				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;
				SELECT NVL(MAX(SORTORDER),0)+1 INTO mysortorder FROM SALLE ;
				IF E_nosalle IS NULL THEN
					SELECT NVL(MAX(SORTORDER),0)+1 INTO mynosalle FROM SALLE ;
				ELSE
				   mynosalle:=E_nosalle ;
				END IF;
				INSERT INTO SALLE (CODESALLE,LIBELLE,SITEID,BATIMENTID,SORTORDER,NOSALLE,TELEPHONE,PORTE_CLE,PORTE_OPTION,DATECREATION,DATEMAJ) VALUES (E_ID,E_LIBELLE,idsite,idbatiment,mysortorder,mynosalle,E_telephone,E_porte_cle,E_porte_option,SYSDATE,SYSDATE);
				COMMIT;
				INSERT INTO AMENAGSALLE (CODESALLE,CODEAMENAGEMENT,DATEMAJ,DATECREATION) VALUES(E_ID,'VPARDEFAUT',SYSDATE,SYSDATE);
				COMMIT;
					E_ID := E_ID || ',1,0';
			ELSE
					E_ID := 'VPARDEFAUT,0,0';
			END IF;
		END IF;
	END IF;

END;
/

COMMIT;

CREATE OR REPLACE PROCEDURE PS_BUREAUX(
E_flagin INT,
E_champctrl VARCHAR2,
E_etageid IN VARCHAR2,
E_bureau IN VARCHAR2,
E_ID OUT VARCHAR2
)
IS
nbupdate int;
nbinsert int;
flag VARCHAR2(14);
myid VARCHAR2(14);

TMP INT;
BEGIN
 nbinsert:=0;
 nbupdate:=0;
 SELECT COUNT(*) INTO TMP FROM BUREAUX WHERE BUREAUID = E_bureau ;
 IF TMP>0 THEN
  E_ID := E_bureau || ',0,0';
 ELSE
  SELECT COUNT(*) INTO TMP FROM BUREAUX WHERE UPPER(BUREAU) = UPPER(E_bureau) AND ETAGEID=E_etageid;
  IF TMP>0 THEN
   SELECT * INTO E_ID FROM (SELECT BUREAUID FROM BUREAUX WHERE UPPER(BUREAU) = UPPER(E_bureau) AND ETAGEID=E_etageid) WHERE ROWNUM=1;
   E_ID := E_ID ||',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
  ELSE
	IF ((E_bureau IS NOT NULL)) AND (LTRIM(E_bureau) IS NOT NULL) THEN
       SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
       SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
       E_ID := flag || myid;
       INSERT INTO BUREAUX (BUREAUID,BUREAU,ETAGEID,DATECREATION,DATEMAJ) VALUES (E_ID,E_bureau,E_etageid,SYSDATE,SYSDATE);
       COMMIT;
       nbinsert:=nbinsert+1;
       E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
    ELSE
       E_ID := 'VPARDEFAUT'||',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
    END IF;
  END IF;
 END IF;

END;
/

COMMIT ;

create or replace PROCEDURE PS_CIVILITE(
 E_flagin INT,
 E_champctrl IN varchar2,
 E_civilite IN  VARCHAR2,
 E_libellecourt IN VARCHAR2,
 E_ID OUT varchar2
)

IS
 flag VARCHAR2(14);
 myid VARCHAR2(14);
 TMP INT;
BEGIN
	E_ID:=null;
	if(not(E_civilite is null and E_libellecourt is null)) then
		--LENGTH(TRIM(TRANSLATE(civilite, ' +-.0123456789', ' '))) retourn null si civilite est numéric
		IF LENGTH(TRIM(TRANSLATE(E_civilite, ' +-.0123456789', ' '))) is null THEN
			SELECT COUNT(*)  INTO TMP FROM civilite WHERE CODECIVILITE = TO_NUMBER(E_civilite);
			IF TMP>0 THEN
				SELECT TO_CHAR(CODECIVILITE) INTO E_ID FROM civilite WHERE CODECIVILITE = To_NUMBER(E_civilite) and rownum=1;
				E_ID := E_civilite || ',0,0';
			END IF;
		ELSE
			IF ((E_civilite IS NULL) OR LTRIM(E_civilite) is null) AND ((E_libellecourt IS NULL) OR LTRIM(E_libellecourt) is null) THEN
				E_ID := '0,0,0';
			ELSE
				SELECT COUNT(*) INTO TMP FROM civilite  WHERE UPPER(civilite) =UPPER(E_civilite)  AND UPPER(libellecourt) = UPPER(E_libellecourt);
				IF TMP>0 THEN
					SELECT TO_CHAR(CODECIVILITE) INTO E_ID FROM civilite  WHERE UPPER(civilite) =UPPER(E_civilite)  AND UPPER(libellecourt) = UPPER(E_libellecourt) and rownum=1;
				END IF;
				IF E_ID IS NOT NULL THEN
					SELECT TO_CHAR(CODECIVILITE) INTO E_ID FROM civilite WHERE libellecourt = UPPER(E_civilite) OR UPPER(libellecourt) = UPPER(E_libellecourt) AND ROWNUM = 1;
					E_ID := E_ID || ',0,0';
				ELSE
					SELECT COUNT(*) INTO TMP FROM civilite WHERE UPPER(civilite) = UPPER(E_civilite);
					IF TMP>0 THEN
						SELECT TO_CHAR(CODECIVILITE) INTO E_ID FROM civilite WHERE UPPER(civilite) = UPPER(E_civilite) and rownum=1;
					END IF;
					IF E_ID IS NOT NULL THEN
						SELECT TO_CHAR(codecivilite) INTO E_ID FROM civilite WHERE UPPER(civilite) = UPPER(E_civilite) AND ROWNUM = 1;
						UPDATE civilite SET libellecourt = UPPER(E_libellecourt), datemaj = SYSDATE WHERE TO_CHAR(CODECIVILITE) = E_ID;
						COMMIT;
						E_ID:=E_ID || ',0,1';
					ELSE
						SELECT COUNT(*) INTO TMP FROM civilite WHERE UPPER(libellecourt) = UPPER(E_libellecourt);
						IF TMP>0 THEN
							SELECT TO_CHAR(CODECIVILITE) INTO E_ID FROM civilite WHERE UPPER(libellecourt) = UPPER(E_libellecourt) AND ROWNUM = 1;
							UPDATE civilite SET civilite = UPPER(E_civilite), datemaj = SYSDATE WHERE TO_CHAR(CODECIVILITE) = E_ID;
							COMMIT;
							E_ID:=E_ID || ',0,1';
						ELSE
							SELECT TO_CHAR((NVL(MAX(CODECIVILITE),0))+1) INTO E_ID FROM CIVILITE;
							INSERT INTO civilite(codecivilite, civilite, libellecourt, datecreation, datemaj) VALUES(E_ID, UPPER(E_civilite), UPPER(E_libellecourt), SYSDATE, SYSDATE);
							COMMIT;
							E_ID:=E_ID || ',1,0';
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
	ELSE
		E_ID:='0,0,0';
	END IF;
END;
/

COMMIT;


CREATE OR REPLACE PROCEDURE PS_FONCTION(
 E_flagin INT,
 E_champctrl IN varchar2,
 E_fonction IN VARCHAR2,
 E_ID out varchar2
)
IS
 flag VARCHAR2(14);
 myid VARCHAR2(14);
 TMP INT;
BEGIN
     E_ID:=null;

       SELECT COUNT(*) INTO TMP FROM FONCTION WHERE TO_CHAR(codefonction) = E_fonction  and (E_FONCTION IS NOT NULL AND LTRIM(E_FONCTION) IS NOT NULL) ;

        IF TMP>0 THEN
            E_ID := E_fonction || '0,0';
		ELSE
			IF (E_fonction IS NULL) OR LTRIM(E_fonction) IS NULL THEN
				E_ID := '0,0,0';
			ELSE
				SELECT COUNT(*) INTO TMP FROM FONCTION  WHERE UPPER(libelle) = UPPER(E_fonction);
				IF TMP>0 THEN
					SELECT TO_CHAR(codefonction) INTO E_ID   FROM FONCTION   WHERE UPPER(libelle) = UPPER(E_fonction) and rownum=1;
					E_ID:=E_ID||',0,0';
				ELSE
					SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
					SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
					E_ID := flag || myid;
					INSERT INTO FONCTION(codefonction, libelle, datecreation, datemaj)    VALUES(TO_NUMBER(E_ID), E_fonction, SYSDATE, SYSDATE);
					COMMIT;
					E_ID := E_ID || ',1,0';
				END IF;
			END IF;
		END IF;

END;
/

COMMIT;


CREATE OR REPLACE PROCEDURE PS_SECRETARIAT(

	E_IDRES VARCHAR2,
	E_IDRESAJOINDRE VARCHAR2,
	E_insertion IN OUT INT
)
IS

	resid VARCHAR2(14);
	TMP INT;
BEGIN
	resid:=null;
	SELECT COUNT(*) INTO TMP FROM (SELECT residantid FROM SECRETARIAT WHERE RESIDANTID = E_IDRES AND RESIDANTID2 = E_IDRESAJOINDRE) WHERE ROWNUM = 1;
	IF TMP=0 THEN
		INSERT INTO SECRETARIAT(RESIDANTID,RESIDANTID2,RELATION,DATECREATION,DATEMAJ) VALUES(E_IDRES,E_IDRESAJOINDRE,'A JOINDRE',SYSDATE,SYSDATE);
		COMMIT;
		E_insertion := E_insertion + 1;
	END IF;

END;
/

COMMIT;


CREATE OR REPLACE PROCEDURE PS_RESIDANTS
(	E_flagin IN INT,
	E_champctrl IN VARCHAR2,
	E_societe IN VARCHAR2,
	E_civilite IN VARCHAR2,
	E_nomjeunefille IN VARCHAR2,
	E_nom IN VARCHAR2,
	E_prenom IN VARCHAR2,
	E_fonction IN VARCHAR2,
	E_telephone IN VARCHAR2,
	E_email IN VARCHAR2,

	E_gsm IN VARCHAR2,
	E_fax IN VARCHAR2,
	E_matricule IN VARCHAR2,
	--E_photo IN VARCHAR2,
	E_persoadresse IN VARCHAR2,
	E_persocp IN VARCHAR2,
	E_persoville IN VARCHAR2,
	E_persoprovince IN VARCHAR2,
	E_persopays IN VARCHAR2,
	E_persotelephone IN VARCHAR2,

	E_thepassword IN VARCHAR2,
	E_thelogin IN VARCHAR2,
	E_site IN VARCHAR2,
	E_service IN VARCHAR2,
	E_departement IN VARCHAR2,
	E_batiment IN VARCHAR2,
	E_etage IN VARCHAR2,
	E_bureau IN VARCHAR2,
	E_codeacces IN VARCHAR2,
	E_boitepostale IN VARCHAR2,
	E_candidatmailing IN VARCHAR2,

	--Secrétariat
	E_matriculeAJ IN VARCHAR2,
	E_prenomAJ IN VARCHAR2,
	E_nomAJ IN VARCHAR2,
	E_telephoneAJ IN VARCHAR2,

	--Flag
	--E_flagsuppression VARCHAR2(1),
	E_refimportation IN VARCHAR2,
	E_usertype int,
	E_ID OUT VARCHAR2
)
IS

	flag VARCHAR2(14);
	myid VARCHAR2(14);
	E_societeid VARCHAR2(40);
	fonctionid VARCHAR2(50);
	departementid VARCHAR2(40);
	serviceid1 VARCHAR2(40);
	civiliteid VARCHAR2(18);
	natureid VARCHAR2(14);
	libcodeacces VARCHAR2(30);
	nationaliteid VARCHAR2(14);
	siteid1 VARCHAR2(14);
	vehiculeid VARCHAR2(14);
	ResIdAj VARCHAR2(14);
    locid VARCHAR2(14);
	nbupdate int;
	nbinsert int;
	TMP int;
	loc_thelogin VARCHAR2(50);
	loc_thepassword VARCHAR2(250);
	interdit VARCHAR2(1);
	habilitationvisite VARCHAR2(1);
	externalid VARCHAR2(24);
	listerouge VARCHAR2(1);
	isextern VARCHAR2(1);
	isresident VARCHAR2(1);
	planid VARCHAR2(14);
	batimentid1 VARCHAR2(20);
	etageid1 VARCHAR2(18);
	bureauid1 VARCHAR2(18);
	libnom VARCHAR2(35);
	libprenom VARCHAR2(35);
	libnomprenom VARCHAR2(70);
	libetage VARCHAR2(7);
	libbatiment VARCHAR2(60);
	libservice varchar(60);
	libsite varchar(35);
	libdepartement varchar2(40);
	libsociete varchar2(35);
	libfonction varchar2(50);
	libbureau varchar2(15);
	libcivilite varchar2(30);
	isactif varchar2(1);
	libmatricule varchar2(15);
	libnomjeunefille varchar2(35);
	libtelephone varchar2(20);
	libemail varchar2(150);
	libgsm varchar2(20);
	libfax varchar2(20);
	libphoto varchar2(150);
	libpersoadresse varchar2(150);
	libpersocp varchar2(9);
	libpersoville varchar2(50);
	libpersoprovince varchar2(50);
	libpersopays varchar2(35);
    libpersotelephone varchar2(20);
	libboitepostale varchar2(10);
	libcandidatmailing varchar2(2);
	libusertype int;
	TMP2 int;

BEGIN
	nbupdate := 0;
	nbinsert := 0;
		-- valuers par défaut des champs dans residant
    isactif:='1';
    interdit:='0';
    habilitationvisite:='1';
    externalid:='VPARDEFAUT';
    listerouge:='0';
    isextern:='0';
	isresident:='1';
    planid:='VPARDEFAUT';

	-- Initiallisation
	libnom:=UPPER(E_nom);
	libprenom:=E_prenom;
	libnomprenom:=libnom||' '||libprenom;
	loc_thelogin:=E_thelogin;
	loc_thepassword:=E_thepassword;
	libmatricule:=E_matricule;
	libcivilite:=E_civilite;
	libfonction:=E_fonction;
	libsite:=E_site;
	libsociete:=E_societe;
	libdepartement:=E_departement;
	libservice:=E_service;
	libbatiment:=E_batiment;
	libetage:=E_etage;
	libbureau:=E_bureau;
	libpersopays:=E_persopays;
	libcodeacces:=E_codeacces;
	libnomjeunefille:=E_nomjeunefille;
	libtelephone:= E_telephone;
	libemail:=E_email;
	libgsm:=E_gsm;
	libfax:=E_fax;

	libpersoadresse:=E_persoadresse;
	libpersocp:=E_persocp;
	libpersoville:=E_persoville;
	libpersoprovince:=E_persoprovince;
	libpersopays:=E_persopays;
	libpersotelephone:=E_persotelephone;
	libboitepostale:=E_boitepostale;
	libcandidatmailing:=E_candidatmailing;
	libusertype:=E_usertype;
	IF loc_thelogin='##' THEN
		loc_thelogin:='';
	END IF;
	IF loc_thepassword='##' THEN
		loc_thepassword:='';
	END IF;
	IF libmatricule='##' THEN
		libmatricule:='';
	END IF;
	IF libcivilite='##' THEN
		libcivilite:='';
	END IF;
	IF libfonction='##' THEN
		libfonction:='';
	END IF;
	IF libsite='##' THEN
		libsite:='';
	END IF;
	IF libsociete='##' THEN
		libsociete:='';
	END IF;
	IF libdepartement='##' THEN
		libdepartement:='';
	END IF;
	IF libservice='##' THEN
		libservice:='';
	END IF;
	IF libbatiment='##' THEN
		libbatiment:='';
	END IF;
	IF libetage='##' THEN
		libetage:='';
	END IF;
	IF libbureau='##' THEN
		libbureau:='';
	END IF;
	IF libpersopays='##' THEN
		libpersopays:='';
	END IF;
	IF libemail='##' THEN
		libemail:='';
	END IF;
	IF libcodeacces='##' THEN
		libcodeacces:='';
	END IF;

    IF libpersopays IS NULL or LTRIM(libpersopays) IS NULL THEN
		SELECT LIBELLE INTO libpersopays FROM PAYS WHERE PAYSID='VPARDEFAUT';
	END IF;

	--
	IF loc_thelogin IS NULL THEN
		loc_thelogin:=libmatricule;
	END IF;
	IF loc_thepassword IS NULL THEN
		loc_thepassword:=libmatricule;
	END IF;
	IF loc_thelogin IS NULL THEN
		loc_thelogin:=UPPER(E_nom);
	END IF;
	IF loc_thepassword IS NULL THEN
		loc_thepassword:=E_prenom;
	END IF;
	IF loc_thelogin IS NULL THEN
		loc_thelogin:='XXX';
	END IF;
	IF loc_thepassword IS NULL THEN
		loc_thepassword:='XXX';
	END IF;
	IF libcandidatmailing='##' THEN
		libcandidatmailing:='';
	END IF;

	-- Civilite
	PS_CIVILITE (0,'',libcivilite,libcivilite, civiliteid);
	nbupdate := nbupdate + CAST( Split(civiliteid,3,',') as int);
	nbinsert := nbinsert + CAST( Split(civiliteid,2,',') as int);
	civiliteid := Split(civiliteid,1,',');

	IF civiliteid>-1 THEN
		SELECT CIVILITE INTO libcivilite FROM CIVILITE WHERE CODECIVILITE=civiliteid;
	END IF;
	-- Fonction

	PS_FONCTION (0,'',libfonction, fonctionid);
	nbupdate := nbupdate + CAST( Split(fonctionid,3,',') as int);
	nbinsert := nbinsert + CAST( Split(fonctionid,2,',') as int);
	fonctionid := Split(fonctionid,1,',');
	IF fonctionid='0' THEN
		SELECT LIBELLE INTO libfonction FROM FONCTION WHERE CODEFONCTION=0;
	END IF;
	-- Site
	PS_SITE (0,libsite,siteid1);
	IF siteid1='VPARDEFAUT' THEN
	   SELECT LIBELLE INTO libsite FROM SITE WHERE SITEID='VPARDEFAUT';
	END IF;

	-- Societe
	PS_SOCIETE (0,'','',libsociete,'','','','','','','1','','','','','1',E_societeid);
	nbupdate := nbupdate + CAST( Split(E_societeid,3,',') as int);
	nbinsert := nbinsert + CAST( Split(E_societeid,2,',') as int);

	E_societeid := Split(E_societeid,1,',');

	IF E_societeid='VPARDEFAUT' THEN
		SELECT NOM INTO libsociete FROM SOCIETE WHERE SOCIETEID='VPARDEFAUT';
	END IF;
	-- Departement
	PS_DEPARTEMENT(0,'',E_societeid,libdepartement,departementid);
	nbupdate := nbupdate + CAST( Split(departementid,3,',') as int);
	nbinsert := nbinsert + CAST( Split(departementid,2,',') as int);

	departementid := Split(departementid,1,',');

	IF departementid='VPARDEFAUT' THEN
	   SELECT LIBELLE INTO libdepartement FROM DEPARTEMENT WHERE DEPTID='VPARDEFAUT';
	END IF;

	-- Service
	PS_SERVICE(0,'',departementid,libservice,serviceid1);
	nbupdate := nbupdate + CAST( Split(serviceid1,3,',') as int);
	nbinsert := nbinsert + CAST( Split(serviceid1,2,',') as int);

	serviceid1 := Split(serviceid1,1,',');

	IF serviceid1='VPARDEFAUT' THEN
		SELECT LIBELLE INTO libservice FROM SERVICE WHERE SERVICEID='VPARDEFAUT';
	END IF;
	-- Batiment
	PS_BATIMENT(0,'',siteid1,libbatiment,'',batimentid1);
	nbupdate := nbupdate + CAST( Split(batimentid1,3,',') as int);
	nbinsert := nbinsert + CAST( Split(batimentid1,2,',') as int);

	batimentid1 :=SUBSTR(Split(batimentid1,1,','),1,14);

	IF batimentid1='VPARDEFAUT' THEN
		SELECT LIBELLE INTO libbatiment FROM BATIMENT WHERE BATIMENTID='VPARDEFAUT';
	END IF;
	-- Etage
	PS_ETAGE(0,'',batimentid1,libetage,etageid1);
	nbupdate := nbupdate + CAST( Split(etageid1,3,',') as int);
	nbinsert := nbinsert + CAST( Split(etageid1,2,',') as int);

	etageid1 := Split(etageid1,1,',');
	IF etageid1='VPARDEFAUT' THEN
		SELECT ETAGE INTO libetage FROM ETAGES WHERE ETAGEID='VPARDEFAUT';
	END IF;
	-- bureau
	PS_BUREAUX(0,'',etageid1,libbureau,bureauid1);
	nbupdate := nbupdate + CAST( Split(bureauid1,3,',') as int);
	nbinsert := nbinsert + CAST( Split(bureauid1,2,',') as int);

	bureauid1 := Split(bureauid1,1,',');

	IF bureauid1='VPARDEFAUT' THEN
		SELECT BUREAU INTO libbureau FROM BUREAUX WHERE BUREAUID='VPARDEFAUT';
	END IF;

    IF (libnom IS NOT NULL) AND LTRIM(libnom) IS NOT NULL THEN

		SELECT COUNT(*) INTO TMP FROM RESIDANTS R WHERE
			  CASE
			  	  	WHEN  E_champctrl is null AND UPPER(NOMPRENOM)=UPPER(libnomprenom) THEN 1
					WHEN  E_champctrl='NOMPRENOM' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) THEN 1
					WHEN  E_champctrl='MATRICULE' AND (MATRICULE=libmatricule or (UPPER(NOMPRENOM)=UPPER(libnomprenom) AND libmatricule is null )) THEN 1
					WHEN  E_champctrl='BADGE' AND (CODEACCES=libcodeacces  or (UPPER(NOMPRENOM)=UPPER(libnomprenom) AND libcodeacces is null)) THEN 1
					WHEN  E_champctrl='EMAIL' AND (UPPER(EMAIL)=UPPER(libemail) or (UPPER(NOMPRENOM)=UPPER(libnomprenom) AND libemail is null )) THEN 1
					ELSE 0
			  END=1 ;

		IF TMP>0 THEN
			 SELECT RESIDANTID INTO E_ID FROM  (SELECT RESIDANTID FROM RESIDANTS R WHERE
			  CASE
			  	  	WHEN  E_champctrl is null AND UPPER(NOMPRENOM)=UPPER(libnomprenom) THEN 1
					WHEN  E_champctrl='NOMPRENOM' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) THEN 1
					WHEN  E_champctrl='MATRICULE' AND (MATRICULE=libmatricule or (UPPER(NOMPRENOM)=UPPER(libnomprenom) AND libmatricule is null )) THEN 1
					WHEN  E_champctrl='BADGE' AND  (CODEACCES=libcodeacces  or (UPPER(NOMPRENOM)=UPPER(libnomprenom) AND libcodeacces is null))  THEN 1
					WHEN  E_champctrl='EMAIL' AND (UPPER(EMAIL)=UPPER(libemail) or (UPPER(NOMPRENOM)=UPPER(libnomprenom) AND libemail is null )) THEN 1
					ELSE 0
			  END=1) WHERE ROWNUM=1;

				IF E_matricule<>'##' OR E_matricule IS NULL    THEN
					UPDATE RESIDANTS SET MATRICULE=libmatricule,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_civilite<>'##' OR E_civilite IS NULL    THEN
					UPDATE RESIDANTS SET CIVILITE = libcivilite,CODECIVILITE=civiliteid,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_fonction<>'##' OR E_fonction IS NULL   THEN
					UPDATE RESIDANTS SET FONCTION = libfonction,CODEFONCTION=fonctionid,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_site<>'##' OR E_site IS NULL   THEN
					UPDATE RESIDANTS SET site = libsite,SITEID=siteid1,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_societe<>'##' OR E_societe IS NULL   THEN
					UPDATE RESIDANTS SET SOCIETE = libsociete,SOCIETEID=E_societeid,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_departement<>'##' OR E_departement IS NULL   THEN
					UPDATE RESIDANTS SET DEPARTEMENT = libdepartement,DEPTID=departementid,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;

				IF E_service<>'##'  OR E_service IS NULL THEN
					UPDATE RESIDANTS SET  SERVICE = libservice,SERVICEID=serviceid1,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_batiment<>'##' OR E_batiment IS NULL   THEN
					UPDATE RESIDANTS SET BATIMENT = libbatiment,BATIMENTID=batimentid1,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_etage<>'##' OR E_etage IS NULL THEN
					UPDATE RESIDANTS SET  ETAGE = libetage,ETAGEID=etageid1,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_bureau<>'##'  OR E_bureau IS NULL  THEN
					UPDATE RESIDANTS SET BUREAU= libbureau,BUREAUID=bureauid1,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_codeacces<>'##'  OR E_codeacces IS NULL THEN
    				UPDATE RESIDANTS SET   CODEACCES = libcodeacces,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_nomjeunefille<>'##' OR E_nomjeunefille IS NULL  THEN
				   UPDATE RESIDANTS SET NOMJEUNEFILLE = libnomjeunefille,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF ;
				IF E_nom<>'##'  OR E_nom IS NULL  THEN
				   UPDATE RESIDANTS SET NOM = libnom,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF ;
				IF E_prenom<>'##'  OR E_prenom IS NULL THEN
				   UPDATE RESIDANTS SET PRENOM = libprenom,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF ;
				IF E_nom<>'##' AND E_prenom<>'##' OR E_nom IS NULL OR E_prenom IS NULL THEN
				   UPDATE RESIDANTS SET NOMPRENOM = libnomprenom,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF ;
				IF E_telephone<>'##' OR E_telephone IS NULL THEN
				  UPDATE RESIDANTS SET TELEPHONE = libtelephone,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_email<>'##' OR E_email IS NULL THEN
				   UPDATE RESIDANTS SET EMAIL = libemail,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_gsm<>'##' OR E_gsm IS NULL THEN
				   UPDATE RESIDANTS SET GSM = libgsm,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_fax<>'##' OR E_fax IS NULL  THEN
				   UPDATE RESIDANTS SET FAX = libfax,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_persoadresse<>'##'  OR E_persoadresse IS NULL THEN
				   UPDATE RESIDANTS SET persoadresse = RAWTOHEX(libpersoadresse),DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;

				IF E_persocp<>'##'   OR E_persocp IS NULL THEN
				  UPDATE RESIDANTS SET persocp = libpersocp,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF  E_persoville<>'##' OR E_persoville IS NULL  THEN
				 UPDATE RESIDANTS SET persoville = libpersoville,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_persoprovince<>'##' OR E_persoprovince IS NULL THEN
				  UPDATE RESIDANTS SET persoprovince = libpersoprovince,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_persopays<>'##' OR E_persopays IS NULL  THEN
				  UPDATE RESIDANTS SET persopays = libpersopays,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;

				IF E_persotelephone<>'##' OR E_persotelephone IS NULL  THEN
				  UPDATE RESIDANTS SET persotelephone = libpersotelephone,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_boitepostale<>'##' OR E_boitepostale IS NULL  THEN
				 UPDATE RESIDANTS SET boitepostale = libboitepostale,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_candidatmailing<>'##' AND  E_candidatmailing IS NOT NULL AND (E_candidatmailing='0' OR E_candidatmailing='1')  THEN
				  UPDATE RESIDANTS SET candidatmailing= E_candidatmailing,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;
				IF E_usertype IS NOT NULL THEN
					UPDATE RESIDANTS SET USERTYPE=E_usertype, DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;
				END IF;


				UPDATE RESIDANTS SET isactif = '1',refimportation = E_refimportation,DATEMAJ=SYSDATE WHERE RESIDANTID=E_ID;


				nbupdate := nbupdate+1;
				COMMIT;
		ELSE
			SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
			SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
			E_ID := flag || myid;


				IF E_codeacces='##' THEN
    				libcodeacces:='';
				END IF;
				IF E_nomjeunefille='##' THEN
				   libnomjeunefille:='';
				END IF ;
				IF E_telephone='##' THEN
				  libtelephone:='';
				END IF;
				IF E_email='##' THEN
				   libemail:='';
				END IF;
				IF E_gsm='##' THEN
				   libgsm:='';
				END IF;
				IF E_fax='##' THEN
				   libfax:='';
				END IF;
				IF E_persoadresse='##' THEN
				   libpersoadresse:='';
				END IF;
				IF E_persocp='##'THEN
				  libpersocp:='';
				END IF;
				IF  E_persoville='##' THEN
				   libpersoville:='';
				END IF;
				IF E_persoprovince='##' THEN
				  libpersoprovince:='';
				END IF;
				IF E_persopays='##' THEN
				  libpersopays:='';
				END IF;
				IF E_persotelephone='##' THEN
				  libpersotelephone:='';
				END IF;
				IF E_boitepostale='##'  THEN
					libboitepostale:='';
				END IF;
				IF libusertype is null  THEN
				    libusertype:=0 ;
				END IF;

			INSERT INTO RESIDANTS (RESIDANTID,SOCIETE,CIVILITE,NOMJEUNEFILLE,NOM ,PRENOM ,NOMPRENOM,FONCTION,TELEPHONE,EMAIL,GSM ,FAX ,MATRICULE,PERSOADRESSE,PERSOCP,PERSOVILLE,PERSOPROVINCE,PERSOPAYS,PERSOTELEPHONE ,THEPASSWORD ,THELOGIN ,SITE,SERVICE,DEPARTEMENT,BATIMENTID,BATIMENT,ETAGEID,ETAGE,BUREAUID,BUREAU,CODEACCES,BOITEPOSTALE,DATECREATION,DATEMAJ,SOCIETEID,CODEFONCTION,CODECIVILITE,SITEID,INTERDIT,HABILITATIONVISITE,EXTERNALID,LISTEROUGE,ISEXTERN,PLANID,DEPTID,SERVICEID,DEBUTINTERDIT,FININTERDIT,ISACTIF,refimportation,USERTYPE,CANDIDATMAILING)
				VALUES(E_ID,libsociete,libcivilite,libnomjeunefille,libnom ,libprenom ,libnomprenom,libfonction,libtelephone,libemail,libgsm ,libfax ,libmatricule,	RAWTOHEX(libpersoadresse),libpersocp,libpersoville,libpersoprovince,libpersopays,libpersotelephone ,loc_thepassword ,loc_thelogin ,libsite,libservice,libdepartement,batimentid1,libbatiment,etageid1,libetage,bureauid1,libbureau,libcodeacces,libboitepostale,SYSDATE,SYSDATE,E_societeid,fonctionid,civiliteid,siteid1,interdit,habilitationvisite,externalid,listerouge,isextern,planid,departementid,serviceid1,SYSDATE,SYSDATE+36500,isactif,E_refimportation,libusertype,'1');

			IF (libcandidatmailing IS NOT NULL) AND (libcandidatmailing='0' OR libcandidatmailing='1') THEN
				UPDATE RESIDANTS SET CANDIDATMAILING=E_candidatmailing where RESIDANTID=E_ID;
			END IF;

			nbinsert := nbinsert + 1;
				COMMIT;
		END IF;

		if E_nomAJ is not null and E_nomAJ<>'##' and TRIM(E_nomAJ) is not null THEN
			SELECT COUNT(*) INTO TMP FROM RESIDANTS WHERE (nom= E_nomAJ AND prenom = E_prenomAJ AND matricule = E_matriculeAJ AND (telephone = E_telephoneAJ or gsm = E_telephoneAJ)) or (nom= E_nomAJ AND prenom = E_prenomAJ) or (matricule = E_matriculeAJ);
			IF TMP>0 THEN
				SELECT * INTO ResIdAj FROM (SELECT RESIDANTID FROM RESIDANTS WHERE (nom= E_nomAJ AND prenom = E_prenomAJ AND matricule = E_matriculeAJ AND (telephone = E_telephoneAJ or gsm = E_telephoneAJ)) or (nom= E_nomAJ AND prenom = E_prenomAJ) or (matricule = E_matriculeAJ)) WHERE ROWNUM=1;
				PS_SECRETARIAT (E_ID	,ResIdAj,nbinsert );
			ELSE
				update residants
				set cpnom = TRIM(REPLACE(E_matriculeAJ|| ' ' || E_nomAJ|| ' ' || E_prenomAJ|| ' ' || E_telephoneAJ,'#',''))
				where residantid = E_ID;
			END IF;

		END IF;
		E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
	ELSE
		E_ID := '-1' || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);

	END IF;

END;

/


COMMIT;

CREATE OR REPLACE PROCEDURE PS_IDENTITES(
	E_flagin INT,
	E_champctrl varchar2,

	E_typeidentite varchar2,
	E_delivrepar varchar2,
	E_finvalidite date,
	E_numero varchar2,
	E_interlocuteurid varchar2,

	E_ID out VARCHAR2
)
IS
	E_flag VARCHAR2(14);
	E_identity VARCHAR2(14);
	E_typeidentiteid int;
	E_nbupdate int;
	E_nbinsert int;
	E_tmp int;

BEGIN
	E_nbupdate := 0;
	E_nbinsert := 0;
  IF (E_interlocuteurid IS NOT NULL) AND LTRIM(E_interlocuteurid) IS NOT NULL AND LTRIM(E_interlocuteurid)<>''	 AND  LTRIM(E_numero) IS NOT NULL THEN
	if(E_typeidentite is not null) then
		select typeidentiteid into E_typeidentiteid from typeidentite where upper(libelle) = upper(E_typeidentite) and rownum=1;
	END IF;


	if(E_typeidentiteid is not null and LENGTH(TRIM(TRANSLATE(E_typeidentite, ' +-.0123456789', ' '))) is null)THEN
		select typeidentiteid into E_typeidentiteid from typeidentite where typeidentiteid = CAST(E_typeidentite as int) AND rownum=1;
	END IF;

	IF(E_typeidentiteid IS NULL)THEN
		select min(typeidentiteid) into E_typeidentiteid from typeidentite;
		E_typeidentiteid := E_typeidentiteid - 1;
		INSERT INTO typeidentite(typeidentiteid,libelle,datemaj,datecreation)
			VALUES(E_typeidentiteid,E_typeidentite,current_timestamp,current_timestamp);
		E_nbinsert := E_nbinsert + 1;
	END IF;



		select count(*) into E_tmp from identites where typeidentiteid = E_typeidentiteid and interlocuteurid=E_interlocuteurid;

		if(E_tmp>0)THEN

			select count(*) into E_tmp from identites where typeidentiteid = E_typeidentiteid and interlocuteurid=E_interlocuteurid and numero = E_numero;

			if(E_tmp>0)THEN

				select IDENTITEID into E_ID from identites where typeidentiteid = E_typeidentiteid and interlocuteurid=E_interlocuteurid and numero = E_numero and rownum=1;

				E_ID := E_ID || ',' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate);
			ELSE
				update identites
				set delivrepar = E_delivrepar,finvalidite = E_finvalidite,numero = E_numero
				where typeidentiteid = E_typeidentiteid
				and interlocuteurid=E_interlocuteurid;

				select IDENTITEID into E_ID from identites where typeidentiteid = E_typeidentiteid and interlocuteurid=E_interlocuteurid and rownum=1;

				E_nbupdate := E_nbupdate + 1;
				E_ID := E_ID || ',' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate);
			END IF;
		ELSE
			IF(E_flagin=1)THEN

				SELECT SEQ_IDENTITY.nextval INTO E_ID FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO E_flag FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := E_flag || E_ID;

				INSERT INTO IDENTITES(typeidentiteid,delivrepar,finvalidite,numero,interlocuteurid,identiteid,datecreation,datemaj)
					VALUES(E_typeidentiteid ,E_delivrepar,E_finvalidite,E_numero,E_interlocuteurid,E_ID,sysdate,sysdate);
				E_nbinsert := E_nbinsert + 1;
				E_ID := E_ID || ',' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate);
			ELSE
				E_ID := '0,' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate);
			END IF;
		END IF;
	ELSE
		E_ID := '0,' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate);
	END IF;
END;
/
commit;

create or replace Procedure PS_INTERLOCUTEUR(
	E_flagin IN INT,
	E_champctrl IN varchar2,
	E_civilite IN VARCHAR2,
	E_nom IN VARCHAR2,
	E_prenom IN VARCHAR2,
	E_nomjeunefille IN VARCHAR2,
	E_datenaissance IN DATE,
	E_lieunaissance IN VARCHAR2,
	E_pays IN VARCHAR2,
	E_societe IN VARCHAR2,
	E_fonction IN VARCHAR2,
	E_nature IN VARCHAR2,
	E_adresse IN VARCHAR2,
	E_codepostal IN VARCHAR2,
	E_ville IN VARCHAR2,
	E_refimportation IN VARCHAR2,

	E_immatriculation IN varchar2,
	E_telephone IN varchar2,
	E_email IN varchar2,
	E_gsm IN varchar2,
	E_fax IN varchar2,
	E_finvaliditeauto IN date,
	E_datedernvisite IN date,

	E_societe_adresse IN VARCHAR2,
	E_societe_siret IN VARCHAR2,
	E_societe_cp IN VARCHAR2,
	E_societe_ville IN VARCHAR2,
	E_societe_pays IN VARCHAR2,

	E_typeidentiteid IN varchar2,
	E_delivrepar IN varchar2,
	E_numero IN varchar2,
	E_finvalidite IN date,
	E_nationalite IN varchar2,

	E_interdit IN varchar2,
	E_debutinterdit IN date,
	E_fininterdit IN date,

	E_ID IN OUT VARCHAR2
)
IS
	flag VARCHAR2(14);
	myid VARCHAR2(14);
	--<champctrl>NOMPRENOM,EMAIL,IMMATRICULATION</champctrl>

	E_libnomprenom varchar2(70);
	nbupdate int;
	nbinsert int;
	E_libidentitieid varchar2(18);

	tmp int;

	E_libsocieteid varchar2(18);
	E_libfonctionid varchar2(18);
	E_libciviliteid varchar2(18);
	E_libnatureid varchar2(18);
	E_libnationaliteid varchar2(18);

	E_libcivilite VARCHAR2(30);
	E_libnom VARCHAR2(35);
	E_libprenom VARCHAR2(34);
	E_libnomjeunefille VARCHAR2(35);
	E_liblieunaissance VARCHAR2(70);
	E_libpays VARCHAR2(35);
	E_libsociete VARCHAR2(35);
	E_libfonction VARCHAR2(35);
	E_libnature VARCHAR2(35);
	E_libadresse VARCHAR2(150);
	E_libcodepostal VARCHAR2(10);
	E_libville VARCHAR2(35);
	E_librefimportation VARCHAR2(48);
	E_libimmatriculation varchar2(15);
	E_libtelephone varchar2(20);
	E_libemail varchar2(150);
	E_libgsm varchar2(20);
	E_libfax varchar2(20);
	E_libsociete_adresse VARCHAR2(150);
	E_libsociete_siret VARCHAR2(20);
	E_libsociete_cp VARCHAR2(10);
	E_libsociete_ville VARCHAR2(35);
	E_libsociete_pays VARCHAR2(35);
	E_libtypeidentiteid varchar2(35);
	E_libdelivrepar varchar2(80);
	E_libnumero varchar2(20);
	E_libnationalite varchar2(50);
	E_libinterdit varchar2(1);



BEGIN


	E_libcivilite := E_civilite;
	if(E_libcivilite ='##')then
		E_libcivilite:=null;
	end if;
	E_libnom := E_nom;
	if(E_libnom='##')then
		E_libnom:=null;
	end if;
	E_libprenom :=E_prenom;
	if(E_libprenom='##')then
		E_libprenom:=null;
	end if;
	E_libnomjeunefille :=E_nomjeunefille;
	if(E_libnomjeunefille='##')then
		E_libnomjeunefille:=null;
	end if;
	E_liblieunaissance :=E_lieunaissance;
	if(E_liblieunaissance='##')then
		E_liblieunaissance:=null;
	end if;
	E_libpays :=E_pays;
	if(E_libpays='##')then
		E_libpays:=null;
	end if;
	E_libsociete :=E_societe;
	if(E_libsociete='##')then
		E_libsociete:=null;
	end if;
	E_libfonction:=E_fonction;
	if(E_libfonction='##')then
		E_libfonction:=null;
	end if;
	E_libnature :=E_nature;
	if(E_libnature='##')then
		E_libnature:=null;
	end if;
	E_libadresse :=E_adresse;
	if(E_libadresse='##')then
		E_libadresse:='##';
	end if;
	E_libcodepostal :=E_codepostal;
	if(E_libcodepostal='##')then
		E_libcodepostal:=null;
	end if;
	E_libville :=E_ville;
	if(E_libville='##')then
		E_libville:=null;
	end if;
	E_librefimportation :=E_refimportation;
	if(E_librefimportation='##')then
		E_librefimportation:=null;
	end if;
	E_libimmatriculation :=E_immatriculation;
	if(E_libimmatriculation='##')then
		E_libimmatriculation:=null;
	end if;
	E_libtelephone :=E_telephone;
	if(E_libtelephone='##')then
		E_libtelephone:=null;
	end if;
	E_libemail :=E_email;
	if(E_libemail='##')then
		E_libemail:=null;
	end if;
	E_libgsm :=E_gsm;
	if(E_libgsm='##')then
		E_libgsm:=null;
	end if;
	E_libfax :=E_fax;
	if(E_libfax='##')then
		E_libfax:=null;
	end if;
	E_libsociete_adresse :=E_societe_adresse;
	if(E_libsociete_adresse='##')then
		E_libsociete_adresse:=null;
	end if;
	E_libsociete_siret :=E_societe_siret;
	if(E_libsociete_siret='##')then
		E_libsociete_siret:=null;
	end if;
	E_libsociete_cp :=E_societe_cp;
	if(E_libsociete_cp='##')then
		E_libsociete_cp:=null;
	end if;
	E_libsociete_ville :=E_societe_ville;
	if(E_libsociete_ville='##')then
		E_libsociete_ville:=null;
	end if;
	E_libsociete_pays :=E_societe_pays;
	if(E_libsociete_pays='##')then
		E_libsociete_pays:=null;
	end if;
	E_libtypeidentiteid :=E_typeidentiteid;
	if(E_libtypeidentiteid='##')then
		E_libtypeidentiteid:=null;
	end if;
	E_libdelivrepar :=E_delivrepar;
	if(E_libdelivrepar='##')then
		E_libdelivrepar:=null;
	end if;
	E_libnumero :=E_numero;
	if(E_libnumero='##')then
		E_libnumero:=null;
	end if;
	E_libnationalite :=E_nationalite;
	if(E_libnationalite='##')then
		E_libnationalite:=null;
	end if;
	E_libinterdit := E_interdit;
	if(E_libinterdit='##')then
		E_libinterdit:=null;
	end if;

	E_libnomprenom := LTRIM(E_libnom || ' ' || E_libprenom);

	nbupdate := 0;
	nbinsert := 0;

	PS_SOCIETE(1,'','',E_libsociete,E_libsociete_siret,'',E_libsociete_adresse,E_libsociete_cp,E_libsociete_ville,E_libsociete_pays,'','','','','','0', E_libsocieteid);
	SELECT nom into E_libsociete FROM societe where societeid = (Split(E_libsocieteid,1,','));

	nbinsert:=nbinsert+CAST(split(E_libsocieteid,2,',') AS int) ;
	nbupdate:=nbupdate+CAST(split(E_libsocieteid,3,',') AS int) ;
	E_libsocieteid := Split(E_libsocieteid,1,',') ;



	PS_FONCTION(0,'',E_libfonction, E_libfonctionid);
	SELECT libelle into E_libfonction FROM fonction where codefonction = (Split(E_libfonctionid,1,','));

	nbinsert:=nbinsert+CAST(split(E_libfonctionid,2,',') AS int) ;
	nbupdate:=nbupdate+CAST(split(E_libfonctionid,3,',') AS int) ;
	E_libfonctionid := Split(E_libfonctionid,1,',') ;



	PS_CIVILITE(0,'',E_libcivilite,E_libcivilite, E_libciviliteid);


	nbinsert:=nbinsert+CAST(split(E_libciviliteid,2,',') AS int) ;
	nbupdate:=nbupdate+CAST(split(E_libciviliteid,3,',') AS int) ;
	E_libciviliteid := Split(E_libciviliteid,1,',') ;

	if(E_libciviliteid>-1)then
		SELECT civilite into E_libcivilite FROM civilite where codecivilite = E_libciviliteid;
	END IF;



	PS_NATURE(0,'',E_libnature,'','',E_libinterdit, E_libnatureid);

	nbinsert:=nbinsert+CAST(split(E_libnatureid,2,',') AS int) ;
	nbupdate:=nbupdate+CAST(split(E_libnatureid,3,',') AS int) ;
	E_libnatureid := Split(E_libnatureid,1,',') ;



	PS_PAYS(0,'LIBELLE',E_libpays,E_libpays,'',E_libnationalite, '', '','','','','','',E_libinterdit,E_debutinterdit,E_fininterdit, '', '', '', '','','', E_libnationaliteid);
	SELECT libelle into E_libnationalite FROM pays where paysid = (Split(E_libnationaliteid,1,','));

	nbinsert:=nbinsert+CAST(split(E_libnationaliteid,2,',') AS int) ;
	nbupdate:=nbupdate+CAST(split(E_libnationaliteid,3,',') AS int) ;
	E_libnationaliteid := Split(E_libnationaliteid,1,',') ;

	IF (E_libnomprenom	IS NOT NULL) THEN



	   select count(*) into tmp FROM interlocuteur i WHERE
			  CASE
					WHEN  E_champctrl is null AND UPPER(LTRIM(NOMPRENOM))=UPPER(E_libnomprenom) THEN 1
					WHEN  E_champctrl='NOMPRENOM' AND UPPER(LTRIM(NOMPRENOM))=UPPER(E_libnomprenom) THEN 1
					WHEN  E_champctrl='IMMATRICULATION' AND IMMATRICULATION=E_libimmatriculation AND UPPER(LTRIM(NOMPRENOM))=UPPER(E_libnomprenom) THEN 1
					WHEN  E_champctrl='EMAIL' AND UPPER(EMAIL)=UPPER(E_libemail) AND UPPER(LTRIM(NOMPRENOM))=UPPER(E_libnomprenom) THEN 1
					ELSE 0
			  END=1;
		IF (tmp>0) THEN



				select interlocuteurid into E_ID FROM (select interlocuteurid from interlocuteur i WHERE UPPER(NOMPRENOM)=UPPER(E_libnomprenom)  AND
			  CASE
					WHEN  E_champctrl is null THEN 1
					WHEN  E_champctrl='NOMPRENOM' THEN 1
					WHEN  E_champctrl='IMMATRICULATION' AND IMMATRICULATION=E_libimmatriculation THEN 1
					WHEN  E_champctrl='EMAIL' AND UPPER(EMAIL)=UPPER(E_libemail) THEN 1
					ELSE 0
			  END = 1 AND ROWNUM=1);

				PS_IDENTITES( 1,'',E_libtypeidentiteid,E_libdelivrepar,E_finvalidite,E_libnumero,E_ID,E_libidentitieid);

				nbinsert:=nbinsert+CAST(split(E_libidentitieid,2,',') AS int) ;
				nbupdate:=nbupdate+CAST(split(E_libidentitieid,3,',') AS int) ;
				E_libidentitieid := Split(E_libidentitieid,1,',') ;



				update INTERLOCUTEUR
				SET civilite = E_libcivilite ,nom = E_libnom, prenom = E_libprenom ,nomjeunefille = E_libnomjeunefille,	datenaissance = E_datenaissance,lieunaissance = E_liblieunaissance,pays_naissance = E_libpays,societe = E_libsociete,fonction=E_libfonction,adresse = E_libadresse,codepostal = E_libcodepostal,ville = E_libville,refimportation = E_librefimportation,immatriculation = E_libimmatriculation,telephone = E_libtelephone,email=E_libemail,gsm = E_libgsm,fax = E_libfax,datedernvisite=E_datedernvisite,societeid=E_libsocieteid,codecivilite=E_libciviliteid,codefonction=E_libfonctionid,natureid=E_libnatureid,nationaliteid=E_libnationaliteid
				WHERE interlocuteurid = E_ID;
				IF (E_debutinterdit is not null) THEN
				update INTERLOCUTEUR SET debutinterdit = E_debutinterdit where interlocuteurid=E_ID;
				END IF;
				IF (E_fininterdit is not null) THEN
				update INTERLOCUTEUR SET fininterdit = E_fininterdit where interlocuteurid=E_ID ;
				END IF;
				IF (E_finvaliditeauto is not null) THEN
				update INTERLOCUTEUR SET finvaliditeauto = E_finvaliditeauto where interlocuteurid=E_ID;
				END IF;
				IF E_libinterdit is not null and E_libinterdit<>''  then
					update INTERLOCUTEUR SET interdit = E_libinterdit where interlocuteurid=E_ID;
				END IF;
				nbupdate := nbupdate+1;

				E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
		ELSE
			IF(E_flagin = 1)THEN



				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;

				PS_IDENTITES(1,'',E_libtypeidentiteid,E_libdelivrepar,E_finvalidite,E_libnumero,E_ID,E_libidentitieid);

				nbinsert:=nbinsert+CAST(split(E_libidentitieid,2,',') AS int) ;
				nbupdate:=nbupdate+CAST(split(E_libidentitieid,3,',') AS int) ;
				E_libidentitieid := Split(E_libidentitieid,1,',') ;



				INSERT INTO interlocuteur(interlocuteurid, societeid, societe, codecivilite, civilite, nom, prenom, nomprenom, nomjeunefille, datenaissance, lieunaissance, pays_naissance, codefonction, fonction, natureid, nationaliteid, pays, adresse, codepostal, ville, pays_adresse, interdit, debutinterdit, fininterdit, datecreation, datemaj,immatriculation,telephone,email,gsm,fax,DATEDERNVISITE,FINVALIDITEAUTO)
					VALUES(E_ID, E_libsocieteid, E_libsociete, E_libciviliteid, E_libcivilite, E_libnom, E_libprenom, LTRIM(E_libnomprenom), E_libnomjeunefille, E_datenaissance, E_liblieunaissance, E_libpays, E_libfonctionid, E_libfonction, E_libnatureid, E_libnationaliteid, E_libnationalite, E_libadresse,E_libcodepostal, E_libville, E_libpays, E_libinterdit, sysdate - 1, sysdate + 36525, sysdate, sysdate,E_libimmatriculation,E_libtelephone,E_libemail,E_libgsm,E_libfax,E_datedernvisite,E_finvaliditeauto);
				nbinsert := nbinsert+1;
				E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
			ELSE



				E_ID := '0,' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
			END IF;
		END IF;
	ELSE



		E_ID := '0,' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
	END IF;



	IF(E_ID='' or E_ID is null) THEN
		E_ID := 'sa marche pas';
	END IF;
END;
/
COMMIT;

CREATE OR REPLACE PROCEDURE PS_VEHICULE(

 E_flagin INT,
 E_champctrl VARCHAR2,
 E_residantid VARCHAR2,
 E_immatriculation VARCHAR2,
 E_marque VARCHAR2,
 E_modele VARCHAR2,
 E_datelimite DATE,
 E_numeropass VARCHAR2,
 E_ID OUT VARCHAR2
)

IS
 flag VARCHAR2(14);
 myid VARCHAR2(14);
 TMP INT;
BEGIN
	E_ID:=null;
	SELECT COUNT(*) INTO TMP FROM vehicule WHERE immatriculation = E_immatriculation;
	IF TMP>0 THEN
		SELECT vehiculeid INTO E_ID FROM vehicule WHERE immatriculation = E_immatriculation and rownum=1;
		E_ID := E_ID || ',0,0';
	ELSE
		  IF (E_immatriculation IS NOT NULL ) AND (LTRIM(E_immatriculation) IS NOT NULL) THEN
				SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
				SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
				E_ID := flag || myid;
				INSERT INTO vehicule(residantid,immatriculation,marque,modele,datelimite,numeropass,vehiculeid,datecreation,datemaj) values(E_residantid,E_immatriculation,E_marque,E_modele,E_datelimite,E_numeropass,E_ID,sysdate,sysdate);
				COMMIT;
				E_ID := E_ID || ',1,0';
		  ELSE
				E_ID := '-1,0,0';
		  END IF;
	END IF;
END;
/

COMMIT;



CREATE OR REPLACE PROCEDURE PS_TYPEVISITE(
 E_flagin IN INT,
 E_typevisiteid IN VARCHAR2,
 E_ID OUT VARCHAR2
)

IS
TMP INT;
BEGIN
	E_ID:=null;
	SELECT COUNT(*) INTO TMP FROM TYPEVISITE  WHERE TO_NUMBER(TYPEVISITEID)= E_typevisiteid;
	IF TMP>0 THEN
		SELECT TYPEVISITEID INTO E_ID FROM TYPEVISITE  WHERE TO_NUMBER(TYPEVISITEID) = E_typevisiteid;
	ELSE
		SELECT COUNT(*) INTO TMP FROM TYPEVISITE  WHERE UPPER(TYPEVISITE) = UPPER(E_typevisiteid);
		IF TMP>0 THEN
		 SELECT *  INTO E_ID  FROM( SELECT TYPEVISITEID FROM TYPEVISITE  WHERE UPPER(TYPEVISITE) = UPPER(E_typevisiteid)) WHERE ROWNUM=1;
		ELSE
			IF E_flagin=0 THEN
				E_ID := '0';
			ELSE
				E_ID := NULL;
			END IF;
		END IF;
	END IF;
END;
/
COMMIT;

CREATE OR REPLACE PROCEDURE PS_VISITES(
    E_flagin INT,
    E_champctrl VARCHAR2,

    E_nomint VARCHAR2,
    E_prenomint VARCHAR2,
    E_nomres VARCHAR2,
    E_prenomres VARCHAR2,

    E_societeresid IN VARCHAR2,
    E_societevisit VARCHAR2,
    E_ifonction VARCHAR2,
    E_idatenaissance date,
    E_ilieunaissance VARCHAR2,
    E_ipays VARCHAR2,
    E_inomjeunefille VARCHAR2,
    E_vip int,
    E_istatut VARCHAR2,

    E_debutprevu date,
    E_finprevu date,
    E_hdebutprevu date,
    E_hfinprevu date,

    E_numerobadge VARCHAR2,
    E_numerovisite IN int,
    E_debutvisite date,
    E_finvisite date,
    E_hdebut date,
    E_hfin date,
    E_statutvisite in VARCHAR2,
    E_boite VARCHAR2,
    E_casier VARCHAR2,
    E_objet VARCHAR2,
    E_piece VARCHAR2,
    E_numero VARCHAR2,
    E_validite date,
    E_parking VARCHAR2,
    E_immatriculation VARCHAR2,
    E_observation VARCHAR2,
    E_lieu VARCHAR2,
    E_originevisite in out int,
    E_marque VARCHAR2,
    E_modele VARCHAR2,
    E_preenreg int,
    E_cle VARCHAR2,

    --Salle : codesalle
    --E_SalleLibelle VARCHAR2(35),
    --E_nosalle VARCHAR2(15),
    --E_batiment VARCHAR2(35),
    E_site VARCHAR2,
    --E_teleSalle VARCHAR2(20),
    E_LAST_ACTION VARCHAR2,
    E_RES_FINAL varchar2,
    E_RES_MOTEUR1 varchar2,
    E_RES_MOTEUR2 varchar2,
    E_RES_OS varchar2,
    E_INFO VARCHAR2,
    E_ALERTE VARCHAR2,
    E_PROFIL_CTRL_ID VARCHAR2,
    E_PROFIL_CTRL2 VARCHAR2,
    E_SIGNATURE_ENTREE VARCHAR2,
    E_SIGNATURE_SORTIE VARCHAR2,
    E_TYPEVISITEID int,
    E_ID out VARCHAR2
)
IS

    flag VARCHAR2(14);
    myid VARCHAR2(14);
    E_IDRES VARCHAR2(18);
    E_idint VARCHAR2(18);
    E_codesalle VARCHAR2(18);
    E_siteid VARCHAR2(14);
    E_libstatutvisiteid int;
    E_nbupdate int;
    E_nbinsert int;
    E_nomprenomresid VARCHAR2(70);
    E_nomprenomvisit VARCHAR2(70);
    TMP int;

    E_libnomint VARCHAR2(35);
    E_libprenomint VARCHAR2(35);
    E_libnomres VARCHAR2(35);
    E_libprenomres VARCHAR2(35);
    E_libsocieteresid VARCHAR2(35);
    E_libsocietevisit VARCHAR2(35);
    E_libifonction VARCHAR2(35);
    E_libilieunaissance VARCHAR2(70);
    E_libipays VARCHAR2(35);
    E_libinomjeunefille VARCHAR2(35);
    E_libistatut VARCHAR2(35);
    E_libnumerobadge VARCHAR2(200);
    E_libstatutvisite VARCHAR2(50);
    E_libboite VARCHAR2(6);
    E_libcasier VARCHAR2(6);
    E_libobjet VARCHAR2(200);
    E_libpiece VARCHAR2(20);
    E_libnumero VARCHAR2(20);
    E_libparking VARCHAR2(35);
    E_libimmatriculation VARCHAR2(15);
    E_libobservation VARCHAR2(200);
    E_liblieu VARCHAR2(50);
    E_libmarque VARCHAR2(20);
    E_libmodele VARCHAR2(40);
    E_libcle VARCHAR2(500);
    E_libsite VARCHAR2(35);
    E_libtypevisiteid int;
    idtypevisite int;
    libnumerovisite int;
    E_libpreenreg int;

BEGIN

    E_nbupdate := 0;
    E_nbinsert := 0;

    libnumerovisite:=E_numerovisite;

    E_libnomint := E_nomint;
    if(E_libnomint='##')then
        E_libnomint := null;
    end if;
    E_libprenomint := E_prenomint;
    if(E_libprenomint='##')then
        E_libprenomint:=null;
    end if;
    E_libnomres :=E_nomres;
    if(E_libnomres='##')then
        E_libnomres:=null;
    end if;
    E_libprenomres :=E_prenomres;
    if(E_libprenomres='##')then
        E_libprenomres:=null;
    end if;
    E_libsocieteresid :=E_societeresid;
    if(E_libsocieteresid='##')then
        E_libsocieteresid:=null;
    end if;
    E_libsocietevisit :=E_societevisit;
    if(E_libsocietevisit='##')then
        E_libsocietevisit:=null;
    end if;
    E_libifonction :=E_ifonction;
    if(E_libifonction='##')then
        E_libifonction:=null;
    end if;
    E_libilieunaissance :=E_ilieunaissance;
    if(E_libilieunaissance='##')then
        E_libilieunaissance := null;
    end if;
    E_libipays :=E_ipays;
    if(E_libipays='##')then
        E_libipays:=null;
    end if;
    E_libinomjeunefille :=E_inomjeunefille;
    if(E_libinomjeunefille='##')then
        E_libinomjeunefille:=null;
    end if;
    E_libistatut :=E_istatut;
    if(E_libistatut='##')then
        E_libistatut:=null;
    end if;
    E_libnumerobadge :=E_numerobadge;
    if(E_libnumerobadge='##')then
        E_libnumerobadge:=null;
    end if;
    E_libstatutvisite :=E_statutvisite;
    if(E_libstatutvisite='##')then
        E_libstatutvisite:=null;
    end if;
    E_libboite :=E_boite;
    if(E_libboite='##')then
        E_libboite:=null;
    end if;
    E_libcasier :=E_casier;
    if(E_libcasier='##')then
        E_libcasier:=null;
    end if;
    E_libobjet :=E_objet;
    if(E_libobjet='##')then
        E_libobjet:=null;
    end if;
    E_libpiece :=E_piece;
    if(E_libpiece='##')then
        E_libpiece:=null;
    end if;
    E_libnumero :=E_numero;
    if(E_libnumero='##')then
        E_libnumero:=null;
    end if;
    E_libparking :=E_parking;
    if(E_libparking='##')then
        E_libparking:=null;
    end if;
    E_libimmatriculation :=E_immatriculation;
    if(E_libimmatriculation='##')then
        E_libimmatriculation:=null;
    end if;
    E_libobservation :=E_observation;
    if(E_libobservation='##')then
        E_libobservation:=null;
    end if;
    E_liblieu :=E_lieu;
    if(E_liblieu='##')then
        E_liblieu:=null;
    end if;
    E_libmarque :=E_marque;
    if(E_libmarque='##')then
        E_libmarque:=null;
    end if;
    E_libmodele :=E_modele;
    if(E_libmodele='##')then
        E_libmodele:=null;
    end if;
    E_libcle :=E_cle;
    if(E_libcle='##')then
        E_libcle:=null;
    end if;
    E_libsite := E_site;
    if(E_libsite='##')then
        E_libsite:=null;
    end if;
    E_libtypevisiteid:=E_typevisiteid;

	PS_TYPEVISITE(0,E_libtypevisiteid,idtypevisite);
    --set E_numerovisite = (select max(numerovisite) from visites)
    if(libnumerovisite is null or libnumerovisite=0 )then
        select NVL(max(dernvisite),1) into libnumerovisite from parametres;
        update parametres set dernvisite=NVL(dernvisite,1)+1 ;
    end IF;
	if(E_originevisite is null or E_originevisite=0 )then
		E_originevisite:=libnumerovisite ;
    end IF;
    E_nomprenomresid := upper(E_libnomres) || ' ' || upper(E_libprenomres);
    E_nomprenomvisit := upper(E_libnomint) || ' ' || upper(E_libprenomint);


    IF(E_nomprenomresid is not null and LTRIM(E_nomprenomresid) is not null) then

        PS_RESIDANTS (1,'NOMPRENOM',E_libsocieteresid,'','',E_libnomres,E_libprenomres,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','',E_IDRES);

        E_nbinsert:=E_nbinsert+CAST(split(E_IDRES,2,',') AS int) ;
        E_nbupdate:=E_nbupdate+CAST(split(E_IDRES,3,',') AS int) ;
        E_IDRES := Split(E_IDRES,1,',') ;

        IF(E_nomprenomvisit is not null and LTRIM(E_nomprenomvisit)is not null)then

            PS_INTERLOCUTEUR(1,'NOMPRENOM','',E_libnomint,E_libprenomint,E_libinomjeunefille,E_idatenaissance,E_libilieunaissance,E_libipays,E_libsocietevisit,E_libifonction,E_libistatut,'','','','','','','','','','','','','','','','','','','','','','0','','',E_idint);

            E_nbinsert:=E_nbinsert+CAST(split(E_idint,2,',') AS int) ;
            E_nbupdate:=E_nbupdate+CAST(split(E_idint,3,',') AS int) ;
            E_idint := Split(E_idint,1,',') ;

			select count(*) into TMP from RESIDANTS where NOMPRENOM=E_nomint+' '+E_prenomint;
			if idtypevisite=-1 AND TMP>0 THEN
				UPDATE INTERLOCUTEUR SET EXTERNALID=(SELECT RESIDANTID FROM RESIDANTS WHERE NOMPRENOM=E_nomint+' '+E_prenomint AND ROWNUM=1)  -- ATTENTION ISCATIF doit e^tre égal à 1
			WHERE INTERLOCUTEURID=E_idint;
			END IF;

            select count(*) into TMP from statutvisite where statutvisite = E_libstatutvisite;
            if(TMP>0)then
                E_libpreenreg:=1;
                select statutid into E_libstatutvisiteid from statutvisite where statutvisite = E_libstatutvisite and rownum=1;
                select statutvisite into E_libstatutvisite from statutvisite where statutvisite = E_libstatutvisite and rownum=1;
            else
                E_libpreenreg:=0;
                E_libstatutvisiteid:= 2;
                select statutvisite into E_libstatutvisite from statutvisite where statutid=E_libstatutvisiteid and rownum=1;
            end if;


            PS_SITE(0,E_libsite,E_siteid);

            select count(*) into TMP FROM visites WHERE UPPER(LTRIM(NOMPRENOMRESID))=UPPER(LTRIM(E_nomprenomresid)) AND LTRIM(upper(nomprenomvisit))=LTRIM(upper(E_nomprenomvisit)) AND (debutprevu = E_debutprevu or (debutprevu is null and E_debutprevu is null)) AND (finprevu = E_finprevu or (finprevu is null and E_finprevu is null)) AND (hdebutprevu = E_hdebutprevu or (hdebutprevu is null and E_hdebutprevu is null)) AND (hfinprevu=E_hfinprevu or (hfinprevu is null and E_hfinprevu is null)) AND
              CASE
                    WHEN  E_champctrl is null THEN 1
                    WHEN  E_champctrl='NOMPRENOM' THEN 1
                    WHEN  E_champctrl='SOCIETE' AND upper(SOCIETERESID)=upper(E_libsocieteresid) AND UPPER(LTRIM(societevisit))=UPPER(E_libsocietevisit) THEN 1
                    ELSE 0
              END=1;

            IF TMP>0    THEN --update
                select visiteid into E_ID FROM visites WHERE UPPER(LTRIM(NOMPRENOMRESID))=UPPER(LTRIM(E_nomprenomresid)) AND LTRIM(upper(nomprenomvisit))=LTRIM(upper(E_nomprenomvisit)) AND (debutprevu = E_debutprevu or (debutprevu is null and E_debutprevu is null)) AND (finprevu = E_finprevu or (finprevu is null and E_finprevu is null)) AND (hdebutprevu = E_hdebutprevu or (hdebutprevu is null and E_hdebutprevu is null)) AND (hfinprevu=E_hfinprevu or (hfinprevu is null and E_hfinprevu is null)) AND
              CASE
                    WHEN  E_champctrl is null THEN 1
                    WHEN  E_champctrl='NOMPRENOM' THEN 1
                    WHEN  E_champctrl='SOCIETE' AND upper(SOCIETERESID)=upper(E_libsocieteresid) AND UPPER(LTRIM(societevisit))=UPPER(LTRIM(E_libsocietevisit)) THEN 1
                    ELSE 0
              END=1 AND rownum=1;

                update visites
                set societeresid=upper(E_libsocieteresid),nomprenomresid=E_nomprenomresid,societevisit=upper(E_libsocietevisit),nomprenomvisit=E_nomprenomvisit,ifonction=E_libifonction,idatenaissance=E_idatenaissance,ilieunaissance=E_libilieunaissance,ipays=E_libipays,inomjeunefille=E_libinomjeunefille,istatut=E_libistatut,debutprevu=E_debutprevu,finprevu=E_finprevu,hdebutprevu=E_hdebutprevu,hfinprevu=E_hfinprevu,numerobadge=E_libnumerobadge,numerovisite=libnumerovisite,debutvisite=E_debutvisite,finvisite=E_finvisite,hdebut=E_hdebut,hfin=E_hfin,statutvisite=E_libstatutvisite,boite=E_libboite,casier=E_libcasier,objet=E_libobjet,piece=E_libpiece,numero=E_libnumero,validite=E_validite,parking=E_libparking,immatriculation=E_libimmatriculation,observation=E_libobservation,lieu=E_liblieu,originevisite=E_originevisite,marque=E_libmarque,modele=E_libmodele,preenreg=E_libpreenreg,cle=E_libcle,interlocuteurid = E_idint,residantid = E_IDRES,siteid=E_siteid,statutid=E_libstatutvisiteid,datemaj=sysdate
                where visiteid = E_ID;
                if (E_debutprevu is null) or (E_finprevu is null) THEN
                    update visites set DEBUTPREVU=TO_DATE(SYSDATE,'DD/MM/YYYY HH24:MI:SS'), FINPREVU=TO_DATE(SYSDATE,'DD/MM/YYYY HH24:MI:SS') WHERE VISITEID=E_ID ;
                END IF;
                if (E_hdebutprevu is null) THEN
                    update visites set HDEBUTPREVU=TO_DATE('08:00','HH24:MI') WHERE VISITEID=E_ID;
                END IF;
                if (E_hfinprevu is null) THEN
                    update visites set HFINPREVU=TO_DATE('23:00','HH24:MI') WHERE VISITEID=E_ID;
                END IF;
                if (E_libtypevisiteid is not null) THEN
                    update visites set typevisiteid=idtypevisite where visiteid=E_ID ;
                END IF;
                if(E_vip is null) THEN
                    update visites set vip='0' where visiteid=E_ID ;
                end    if;
                E_ID := E_ID || ',' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate+1);

            ELSE --insert
                IF(E_flagin = 1)then

                    SELECT SEQ_IDENTITY.nextval INTO myid FROM DUAL ;
                    SELECT SUBSTR(VERSION, 1, 3) INTO FLAG FROM VERSION_SFW WHERE ROWNUM = 1;
                    E_ID := flag || myid;

                    insert into visites(visiteid,societeresid ,nomprenomresid,societevisit,nomprenomvisit,ifonction,idatenaissance,ilieunaissance,ipays,inomjeunefille,istatut,debutprevu,finprevu,hdebutprevu,hfinprevu,numerobadge,numerovisite,debutvisite,finvisite,hdebut,hfin,statutvisite,boite,casier,objet,piece,numero,validite,parking,immatriculation,observation,lieu,originevisite,marque,modele,preenreg,cle,interlocuteurid,residantid,siteid,statutid,datecreation,datemaj,externalid,typevisiteid,nbbdgimprtotal,bureauid)
                    values(E_ID,upper(E_libsocieteresid),E_nomprenomresid,upper(E_libsocietevisit),E_nomprenomvisit,E_libifonction,E_idatenaissance,E_libilieunaissance,E_libipays,E_libinomjeunefille,E_libistatut,E_debutprevu,E_finprevu,E_hdebutprevu,E_hfinprevu,E_libnumerobadge,libnumerovisite,E_debutvisite,E_finvisite,E_hdebut,E_hfin,E_libstatutvisite,E_libboite,E_libcasier,E_libobjet,E_libpiece,E_libnumero,E_validite,E_libparking,E_libimmatriculation,E_libobservation,E_liblieu,libnumerovisite,E_libmarque,E_libmodele,E_libpreenreg,E_libcle,E_idint,E_idres,E_siteid,E_libstatutvisiteid,sysdate,sysdate,E_idres,idtypevisite,0,libnumerovisite);

                    if (E_vip is not null) THEN
                           update visites set vip=E_vip where visiteid=E_ID;
                    end if;
                     if (E_debutprevu is null) or (E_finprevu is null) THEN
                        update visites set DEBUTPREVU=TO_DATE(SYSDATE,'DD/MM/YYYY HH24:MI:SS'), FINPREVU=TO_DATE(SYSDATE,'DD/MM/YYYY HH24:MI:SS') WHERE VISITEID=E_ID ;
                    END IF;
                    if (E_hdebutprevu is null) THEN
                        update visites set HDEBUTPREVU=TO_DATE('08:00','HH24:MI') WHERE VISITEID=E_ID;
                    END IF;
                    if (E_hfinprevu is null) THEN
                        update visites set HFINPREVU=TO_DATE('23:00','HH24:MI') WHERE VISITEID=E_ID;
                    END IF;
					update visites set ifonction=(SELECT LIBELLE FROM FONCTION WHERE CODEFONCTION=(SELECT CODEFONCTION FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=E_idint)),istatut=(SELECT LIBELLE FROM NATURE WHERE NATUREID=(SELECT NATUREID FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=E_idint)), idatenaissance=(SELECT DATENAISSANCE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=E_idint),inomjeunefille=(SELECT NOMJEUNEFILLE FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=E_idint)  where visiteid=E_ID;
                    E_nbinsert := E_nbinsert+1;
                else
                    E_ID := '0';
                end IF;
                E_ID := E_ID || ',' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate);
            END IF;
        ELSE
            E_ID := '0,' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate);
        END IF;
    ELSE
        E_ID := '0,' || TO_CHAR(E_nbinsert) || ',' || TO_CHAR(E_nbupdate);
    END IF;
END;
/
COMMIT;

CREATE OR REPLACE PROCEDURE PS_CORRESPONDANCE(
	E_flagin INT,
	E_champctrl varchar2,

	E_libsSrc varchar2,--libsrc1,libsrc2,libsrc3...
	E_rangsSrc varchar2,--rang(libsrc1),rang(libsrc2),rang(libsrc3)...
	E_libDst varchar2,
	E_cfg_fichier varchar2,
	E_corres_rang int,

	E_ID out VARCHAR2
)
IS
	E_CORRESID INT;
	E_cfg_fichierid INT;

	E_tmp int;
BEGIN


	if(LENGTH(TRIM(TRANSLATE(E_cfg_fichier, ' +-.0123456789', ' '))) is null) THEN

		select count(*) into E_tmp from cfg_fichier where cfg_fichierid=CAST(E_cfg_fichier as int);

		if(E_tmp>0)then
			E_cfg_fichierid := cast(E_cfg_fichier as int);
		ELSE

			select count(*) into E_tmp from cfg_fichier where libelle=E_cfg_fichier;

			if(E_tmp>0)then
				select cfg_fichierid into E_cfg_fichierid from cfg_fichier where libelle=E_cfg_fichier and rownum=1;
			ELSE
				E_cfg_fichierid := -1;
			END IF;
		END IF;
	ELSE

		select count(*) into E_tmp from cfg_fichier where libelle=E_cfg_fichier;

		if(E_tmp>0)then
			 select cfg_fichierid into E_cfg_fichierid from cfg_fichier where libelle=E_cfg_fichier AND rownum=1;
		ELSE
			E_cfg_fichierid := -1;
		END IF;
	END IF;



	if(E_cfg_fichierid<>-1)then

		select count(*) into E_tmp from correspondance where corresid = CAST(E_ID as int);

		if(E_tmp>0)then

			update correspondance
			set libsSrc=E_libsSrc,rangsSrc=E_rangsSrc,libDst=E_libDst,cfg_fichierid=E_cfg_fichierid,corres_rang = E_corres_rang,datemaj=sysdate
			WHERE Corresid = CAST(E_ID as int);

			E_ID := E_ID || ',0,1';
		ELSE

			select count(*) into E_tmp from correspondance where cfg_fichierid=E_cfg_fichierid and libsSrc=E_libsSrc AND rangsSrc = E_rangsSrc AND libDst=E_libDst AND corres_rang=E_corres_rang;

			if(E_tmp>0)then

				select CAST(corresid as VARCHAR2(18)) into E_ID from correspondance where cfg_fichierid=E_cfg_fichierid and libsSrc=E_libsSrc AND rangsSrc = E_rangsSrc AND libDst=E_libDst AND corres_rang=E_corres_rang AND rownum=1;

				E_ID := E_ID || ',0,0';
			ELSE

				select max(corresid) into E_CORRESID from correspondance;
				if(E_CORRESID is null)then
					E_CORRESID := 0;
				END IF;
				E_CORRESID := E_CORRESID+1;
				insert into correspondance(Corresid,libsSrc,rangsSrc,libDst,cfg_fichierid,corres_rang,datemaj,datecreation)
				VALUES(E_CORRESID,E_libsSrc,E_rangsSrc,E_libDst,E_cfg_fichierid,E_corres_rang,sysdate,sysdate);

				E_ID := cast(E_corresid as varchar) || ',1,0';
			END IF;
		END IF;
	ELSE
		E_ID := '-1,0,0';
	END IF;

END;
/
commit;

CREATE OR REPLACE PROCEDURE PS_TACHE_ORDER
IS
	CURSOR EMP IS SELECT TACHEID FROM TACHE WHERE ACTIF<>-2 ORDER BY TACHE_RANG ASC;
	LC$ID TACHE.TACHEID%Type ;
	MYINDICE INT;
BEGIN
	MYINDICE:=0;
	Open EMP ; -- ouverture du curseur
	Loop -- boucle sur les lignes
	Fetch EMP Into LC$ID ; -- Lecture d'une ligne
	Exit When EMP%NOTFOUND ; -- sortie lorsque le curseur ne ramène plus de ligne
	UPDATE TACHE SET TACHE_RANG=MYINDICE WHERE TACHEID=LC$ID;
	MYINDICE:=MYINDICE+1;
	End loop ;
	Close  EMP ; -- fermeture du curseur
END;
/

COMMIT;

CREATE OR REPLACE PROCEDURE PS_TACHE_UPDOWN
 (UPDOWN_ID NUMBER,
 SENS VARCHAR2)
IS
 MYRG INT;
 MYRULECOUNT INT;
BEGIN

 SELECT COUNT(*) INTO MYRULECOUNT FROM TACHE WHERE ACTIF<>-2 ;

 SELECT TACHE_RANG INTO MYRG FROM TACHE WHERE TACHEID=UPDOWN_ID;

 IF (SENS='UP') AND (MYRG>0)  THEN
  UPDATE TACHE SET TACHE_RANG=MYRG WHERE TACHE_RANG=MYRG-1 ;
  UPDATE TACHE SET TACHE_RANG=MYRG-1 WHERE TACHEID=UPDOWN_ID  ;
 ELSE
  IF  (SENS='DOWN') AND (MYRG<MYRULECOUNT-1)  THEN
   UPDATE TACHE SET TACHE_RANG=MYRG WHERE TACHE_RANG=MYRG+1 ;
   UPDATE TACHE SET TACHE_RANG=MYRG+1 WHERE TACHEID=UPDOWN_ID  ;
  END IF;
 END IF;
COMMIT;
END;
/

COMMIT;
ALTER TABLE TACHE ADD OWNERID VARCHAR2(14) DEFAULT('VPARDEFAUT');
COMMIT;
ALTER TABLE TACHE ADD ROLEOWNER VARCHAR2(20) DEFAULT('USERS');
COMMIT;

UPDATE TACHE SET OWNERID='VPARDEFAUT', ROLEOWNER='USERS';
COMMIT;
ALTER TABLE TACHE_LOG ADD ROLEUSER VARCHAR2(20) DEFAULT ('USERS');
COMMIT;
UPDATE TACHE_LOG SET ROLEUSER='USERS', USERID='VPARDEFAUT' ;
