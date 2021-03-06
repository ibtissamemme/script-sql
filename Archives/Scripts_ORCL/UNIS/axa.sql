create or replace
PROCEDURE PS_RESIDANTS
( E_flagin IN INT,
 E_champctrl IN VARCHAR2,
 E_societe IN OUT VARCHAR2,
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

 --Secrétariat
 E_matriculeAJ IN VARCHAR2,
 E_prenomAJ IN VARCHAR2,
 E_nomAJ IN VARCHAR2,
 E_telephoneAJ IN VARCHAR2,

 --Flag
 --E_flagsuppression VARCHAR2(1),
 E_refimportation in varchar2,
 
 E_ID OUT VARCHAR2
)
IS

 flag VARCHAR2(14);
 myid VARCHAR2(14);
 E_societeid VARCHAR2(40);
 fonctionid VARCHAR2(48);
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
 batimentid1 VARCHAR2(14);
 etageid1 VARCHAR2(14);
 bureauid1 VARCHAR2(14);
 libnom VARCHAR2(35);
 libprenom VARCHAR2(35);
 libnomprenom VARCHAR2(70);
 libetage VARCHAR2(7);
 libbatiment VARCHAR2(35);
 libservice varchar(40);
 libsite varchar(35);
 libdepartement varchar2(40);
 libsociete varchar2(35);
 libfonction varchar2(35);
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

 -- Civilite
 PS_CIVILITE (0,'',libcivilite,'', civiliteid);
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
 IF fonctionid=0 THEN
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
 batimentid1 := Split(batimentid1,1,',');
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
     WHEN  E_champctrl='MATRICULE' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) AND (libmatricule is null or MATRICULE=libmatricule) THEN 1
     WHEN  E_champctrl='BADGE' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) AND (libcodeacces is null or CODEACCES=libcodeacces) THEN 1
     WHEN  E_champctrl='EMAIL' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) AND (libemail is null or UPPER(EMAIL)=UPPER(libemail)) THEN 1
     ELSE 0
     END=1 ;
      
  IF TMP>0 THEN
    SELECT RESIDANTID INTO E_ID FROM  (SELECT RESIDANTID FROM RESIDANTS R WHERE UPPER(NOMPRENOM)=UPPER(libnomprenom)  AND
     CASE
         WHEN  E_champctrl is null AND UPPER(NOMPRENOM)=UPPER(libnomprenom) THEN 1
     WHEN  E_champctrl='NOMPRENOM' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) THEN 1
     WHEN  E_champctrl='MATRICULE' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) AND (libmatricule is null or MATRICULE=libmatricule) THEN 1
     WHEN  E_champctrl='BADGE' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) AND (libcodeacces is null or CODEACCES=libcodeacces) THEN 1
     WHEN  E_champctrl='EMAIL' AND UPPER(NOMPRENOM)=UPPER(libnomprenom) AND (libemail is null or UPPER(EMAIL)=UPPER(libemail)) THEN 1
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

   INSERT INTO RESIDANTS (RESIDANTID,SOCIETE,CIVILITE,NOMJEUNEFILLE,NOM ,PRENOM ,NOMPRENOM,FONCTION,TELEPHONE,EMAIL,GSM ,FAX ,MATRICULE,PERSOADRESSE,PERSOCP,PERSOVILLE,PERSOPROVINCE,PERSOPAYS,PERSOTELEPHONE ,THEPASSWORD ,THELOGIN ,SITE,SERVICE,DEPARTEMENT,BATIMENTID,BATIMENT,ETAGEID,ETAGE,BUREAUID,BUREAU,CODEACCES,BOITEPOSTALE,DATECREATION,DATEMAJ,SOCIETEID,CODEFONCTION,CODECIVILITE,SITEID,INTERDIT,HABILITATIONVISITE,EXTERNALID,LISTEROUGE,ISEXTERN,PLANID,DEPTID,SERVICEID,DEBUTINTERDIT,FININTERDIT,ISACTIF,refimportation)
    VALUES(E_ID,libsociete,libcivilite,libnomjeunefille,libnom ,libprenom ,libnomprenom,libfonction,libtelephone,libemail,libgsm ,libfax ,libmatricule, RAWTOHEX(libpersoadresse),libpersocp,libpersoville,libpersoprovince,libpersopays,libpersotelephone ,loc_thepassword ,loc_thelogin ,libsite,libservice,libdepartement,batimentid1,libbatiment,etageid1,libetage,bureauid1,libbureau,libcodeacces,libboitepostale,SYSDATE,SYSDATE,E_societeid,fonctionid,civiliteid,siteid1,interdit,habilitationvisite,externalid,listerouge,isextern,planid,departementid,serviceid1,SYSDATE,SYSDATE+36500,isactif,E_refimportation);

   nbinsert := nbinsert + 1;
    COMMIT;
  END IF;

  SELECT COUNT(*) INTO TMP FROM RESIDANTS WHERE (nom= E_nomAJ AND prenom = E_prenomAJ AND matricule = E_matriculeAJ AND (telephone = E_telephoneAJ or gsm = E_telephoneAJ)) or (nom= E_nomAJ AND prenom = E_prenomAJ) or (matricule = E_matriculeAJ);
  IF TMP>0 THEN
     SELECT * INTO ResIdAj FROM (SELECT RESIDANTID FROM RESIDANTS WHERE (nom= E_nomAJ AND prenom = E_prenomAJ AND matricule = E_matriculeAJ AND (telephone = E_telephoneAJ or gsm = E_telephoneAJ)) or (nom= E_nomAJ AND prenom = E_prenomAJ) or (matricule = E_matriculeAJ)) WHERE ROWNUM=1;
   PS_SECRETARIAT (E_ID ,ResIdAj,nbinsert );
  ELSE
   update residants
   set cpnom = TRIM(REPLACE(E_matriculeAJ|| ' ' || E_nomAJ|| ' ' || E_prenomAJ|| ' ' || E_telephoneAJ,'#',''))
   where residantid = E_ID;
  END IF;
  
  E_ID := E_ID || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
 ELSE
  E_ID := '-1' || ',' || TO_CHAR(nbinsert) || ',' || TO_CHAR(nbupdate);
 END IF;
END;