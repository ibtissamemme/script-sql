CREATE OR REPLACE PROCEDURE PS_PURGE_INIT(E_NB_JOUR VARCHAR2)
IS
 E_INTsansvisites VARCHAR2(10);
 E_INTsansvisitesnbjours VARCHAR2(10);
 E_INTsansvisitesdate VARCHAR2(20);
 E_INTsesvisites VARCHAR2(10);
 E_INTanonymevisites VARCHAR2(10);
 E_INTnoninterdit VARCHAR2(10);
 E_INTsescolis VARCHAR2(10);
 E_INTsesconsignesetmessages VARCHAR2(10);
 E_INTsescourstaxis VARCHAR2(10);
 E_INTconsigne VARCHAR2(10);
 E_VISdatantdeplusnbjour VARCHAR2(10);
 E_VISanterieurdate VARCHAR2(20);
 E_VISanonymevisites VARCHAR2(20);
 E_RESnonactif  VARCHAR2(20);
 E_RESnonmajdate VARCHAR2(20);
 E_RESsesvisites VARCHAR2(20);
 E_RESnonmajnbjours VARCHAR2(20);
 E_TACexecuteouinactive VARCHAR2(20);
 E_TACsesconfigs VARCHAR2(20);
 E_TALpurge VARCHAR2(20);
 E_MAIenvoye VARCHAR2(20);
 E_AJ2termine VARCHAR2(20);
 E_COLcolis VARCHAR2(20);
 E_CONsupmessageslus VARCHAR2(20);
 E_SOCnonutilise VARCHAR2(20);
 E_LGRtermineedepuisdate VARCHAR2(20);
 E_LGRtermineedepuisnbjours VARCHAR2(20);
BEGIN
 E_INTanonymevisites:='';
 E_INTsansvisites:='';
 E_INTsansvisitesnbjours:=E_NB_JOUR;
 E_INTsesvisites:='/';
 E_INTnoninterdit:='';
 E_INTconsigne:='';
 E_INTsescourstaxis:='';
 E_INTsesconsignesetmessages:='';
 E_VISdatantdeplusnbjour:=E_NB_JOUR;
 E_VISanterieurdate:='';
 E_VISanonymevisites:='';
 E_RESnonactif :='';
 E_RESnonmajdate:='';
 E_RESsesvisites:='';
 E_RESnonmajnbjours:='';
 E_TACexecuteouinactive:='';
 E_TACsesconfigs:='';
 E_TALpurge:='';
 E_MAIenvoye:='';
 E_AJ2termine:='';
 E_COLcolis:='';
 E_CONsupmessageslus:='';
 E_SOCnonutilise:='';
 E_LGRtermineedepuisdate:='';
 E_LGRtermineedepuisnbjours:='';
 DELETE FROM TEMP_MYPURGE ;
INSERT INTO TEMP_MYPURGE SELECT INTERLOCUTEURID FROM INTERLOCUTEUR I WHERE
      (
   I.INTERLOCUTEURID<>'VPARDEFAUT'
   )
   AND
   0=(SELECT COUNT(INTERLOCUTEURID) FROM VISITES WHERE INTERLOCUTEURID=I.INTERLOCUTEURID AND statutid in (8,1,33,34))
   AND
    (    ((
            (
             E_INTsansvisites is not null and (0=(SELECT COUNT(INTERLOCUTEURID) FROM VISITES WHERE INTERLOCUTEURID=I.INTERLOCUTEURID AND statutid in (2,16,32,35)))
            )
        )
        OR
        (
             E_INTsansvisitesnbjours is not null and 0=(select COUNT(interlocuteurid) from visites where
            (To_number(E_INTsansvisitesnbjours)+TO_DATE(finvisite,'DD/MM/YYYY HH24:MI:SS')>To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (16,35)
            OR
            (To_number(E_INTsansvisitesnbjours)+TO_DATE(finprevu,'DD/MM/YYYY HH24:MI:SS')>To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (2,32))
            )     AND (I.INTERLOCUTEURID=INTERLOCUTEURID)
            )
        )
        OR
        (
            E_INTsansvisitesdate is not null and 0=(select count(interlocuteurid) from visites where
            (TO_DATE(finvisite,'DD/MM/YYYY HH24:MI:SS')>TO_DATE(E_INTsansvisitesdate,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (16,35)
            OR
            TO_DATE(finprevu,'DD/MM/YYYY HH24:MI:SS')>TO_DATE(E_INTsansvisitesdate,'DD/MM/YYYY HH24:MI:SS')  AND STATUTID IN(2,32)
            )
            AND (I.INTERLOCUTEURID=INTERLOCUTEURID)
            )

        )
    )
    AND
        (
            (E_INTnoninterdit is not null)
            OR
            (
            E_INTnoninterdit is  null and (I.interdit='0' or I.interdit is null)
            )
        )
    AND
        (
            (E_INTconsigne is not null)
            OR
            (
            E_INTconsigne is  null and
            ( 0=(SELECT COUNT(CONSIGNEID) FROM CONSIGNE WHERE RESIDANTID='VISITEUR' AND INTERLOCUTEURID=I.INTERLOCUTEURID))

            )

        )
    )     ;
     
         

    If  E_VISanonymevisites is not null THEN


    UPDATE VISITES SET INTERLOCUTEURID='VPARDEFAUT',NOMPRENOMVISIT=(SELECT NOMPRENOM FROM INTERLOCUTEUR WHERE INTERLOCUTEURID='VPARDEFAUT') WHERE
        STATUTID NOT IN (1,8,33,34) AND
            (INTERLOCUTEURID<>'VPARDEFAUT')
            AND
            (
                ( E_VISdatantdeplusnbjour IS NOT NULL
                 AND
                    (
                        (To_number(E_VISdatantdeplusnbjour)+TO_DATE(finvisite,'DD/MM/YYYY HH24:MI:SS')<To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (16,35) )
                        OR
                        ( To_number(E_VISdatantdeplusnbjour)+TO_DATE(finprevu,'DD/MM/YYYY HH24:MI:SS')<To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS')    AND STATUTID IN (2,32))
                     )
                )
                OR
                ( E_VISanterieurdate IS NOT NULL
                AND
                    (
                        (TO_DATE(finvisite,'DD/MM/YYYY HH24:MI:SS')<To_date(E_VISanterieurdate,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (16,35) )
                        OR
                        (TO_DATE(finprevu,'DD/MM/YYYY HH24:MI:SS')<to_date(E_VISanterieurdate,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (2,32) )
                    )
                )
            );

        ELSE BEGIN
        DELETE FROM XANNEXE WHERE ORIGINE='VISITES' AND ORIGINEID IN (SELECT VISITEID FROM VISITES WHERE STATUTID=-1 OR
        (STATUTID NOT IN (1,8,33,34) AND
            (INTERLOCUTEURID<>'VPARDEFAUT')
            AND
            (
                ( E_VISdatantdeplusnbjour IS NOT NULL
                 AND
                    (
                        (To_number(E_VISdatantdeplusnbjour)+TO_DATE(finvisite,'DD/MM/YYYY HH24:MI:SS')<To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (16,35) )
                        OR
                        ( To_number(E_VISdatantdeplusnbjour)+TO_DATE(finprevu,'DD/MM/YYYY HH24:MI:SS')<To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS')    AND STATUTID IN (2,32))
                     )
                )
                OR
                ( E_VISanterieurdate IS NOT NULL
                AND
                    (
                        (TO_DATE(finvisite,'DD/MM/YYYY HH24:MI:SS')<To_date(E_VISanterieurdate,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (16,35) )
                        OR
                        (TO_DATE(finprevu,'DD/MM/YYYY HH24:MI:SS')<to_date(E_VISanterieurdate,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (2,32) )
                    )
                )
            ) ) )  ;
            
        DELETE FROM VISITES  WHERE STATUTID='-1' OR
        (STATUTID NOT IN (1,8,33,34) AND
            (INTERLOCUTEURID<>'VPARDEFAUT')
            AND
            (
                ( E_VISdatantdeplusnbjour IS NOT NULL
                 AND
                    (
                        (To_number(E_VISdatantdeplusnbjour)+TO_DATE(finvisite,'DD/MM/YYYY HH24:MI:SS')<To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (16,35) )
                        OR
                        ( To_number(E_VISdatantdeplusnbjour)+TO_DATE(finprevu,'DD/MM/YYYY HH24:MI:SS')<To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS')    AND STATUTID IN (2,32))
                     )
                )
                OR
                ( E_VISanterieurdate IS NOT NULL
                AND
                    (
                        (TO_DATE(finvisite,'DD/MM/YYYY HH24:MI:SS')<To_date(E_VISanterieurdate,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (16,35) )
                        OR
                        (TO_DATE(finprevu,'DD/MM/YYYY HH24:MI:SS')<to_date(E_VISanterieurdate,'DD/MM/YYYY HH24:MI:SS') AND STATUTID IN (2,32) )
                    )
                )
            ) )   ;
            END;
END IF;

If E_INTanonymevisites is not null and E_INTsesvisites is not null THEN
    UPDATE VISITES SET INTERLOCUTEURID='VPARDEFAUT',NOMPRENOMVISIT=(SELECT NOMPRENOM FROM INTERLOCUTEUR WHERE INTERLOCUTEURID='VPARDEFAUT') WHERE STATUTID='-1' OR ( STATUTID NOT IN (1,8,33,34) AND interlocuteurid IN (  SELECT INTERLOCUTEURID FROM  TEMP_MYPURGE));
END    IF    ;
IF E_INTsesvisites is not null AND (E_INTanonymevisites is null)   THEN
    DELETE FROM VISITES WHERE  STATUTID NOT IN (1,8,33,34) AND interlocuteurid IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE );
END IF;

DELETE FROM VISITE_ACTION WHERE (SELECT COUNT(VISITEID) FROM VISITES WHERE VISITEID=VISITE_ACTION.VISITEID)=0;
DELETE FROM VISITE_REGLE WHERE (SELECT COUNT(VISITEID) FROM VISITES WHERE VISITEID=VISITE_REGLE.VISITEID)=0;

DELETE FROM IDENTITES WHERE INTERLOCUTEURID IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE );
DELETE FROM XANNEXE WHERE ORIGINE='INTERLOCUTEUR' AND ORIGINEID IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE );
DELETE FROM INTER_ACTION WHERE (SELECT COUNT(INTERLOCUTEURID) FROM INTERLOCUTEUR WHERE INTERLOCUTEURID=INTER_ACTION.INTERLOCUTEURID)=0;
DELETE FROM INTERLOCUTEUR  WHERE INTERLOCUTEURID IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE );


IF  E_INTsescolis is not null THEN
    DELETE FROM COLISEMIS WHERE INTERLOCUTEURID IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE );
    DELETE FROM COLISRECU WHERE INTERLOCUTEURID IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE )    ;
END IF;
if(E_INTsesconsignesetmessages is not null)THEN
    DELETE FROM CONSIGNE WHERE INTERLOCUTEURID IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE );
    END IF;
IF E_INTsescourstaxis IS NOT NULL THEN
    delete from course where ID_COURSE in (select ID_course from PASSAGERTAXI where interlocuteurid IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE ));
    delete from PASSAGERTAXI where interlocuteurid IN ( SELECT MYENTITEID FROM  TEMP_MYPURGE );
END IF;

DELETE FROM TEMP_MYPURGE ;

INSERT INTO TEMP_MYPURGE SELECT residantid   from residants
    where
    (residantid<>'VPARDEFAUT') AND
    (( E_RESnonmajnbjours is not null and datemaj+to_number(E_RESnonmajnbjours)<SYSDATE) OR
    ( E_RESnonmajdate is not null and datemaj<cast(E_RESnonmajdate as date)) OR
    ( E_RESnonactif is not null and isactif='0')
    AND (
    ( E_INTnoninterdit is not null)
        OR
        (
         E_INTnoninterdit is  null and (interdit='0' or interdit is null)
        )
    ));
        DELETE FROM HVISITES WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM PASSAGER WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM PASSAGERTAXI WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM LGPARTICIPANT WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM HLGPARTICIPANT WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM SECRETARIAT where RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) OR RESIDANTID2 IN (SELECT MYENTITEID FROM  TEMP_MYPURGE);            
        DELETE FROM LIEUPERMIS WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM USERS WHERE EXTERNALID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM VEHICULE WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM COLISEMIS WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM COLISRECU WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM CONSIGNE WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM EVENEMENTCOLIS WHERE RESIDANTID  IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM FACTURE WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM DROITS WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        DELETE FROM VEHICULE_DEMANDE WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;            
        DELETE FROM INTER_RSERVICE WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        
        IF   (E_RESsesvisites is not null)  THEN
                DELETE FROM VISITE_CONTROLE WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;            
                DELETE FROM VISITES_RESIDANTS WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
                DELETE FROM VISITES_TEMP WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
                DELETE FROM ZCL01_VISITERE WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE);
                DELETE FROM VISITES WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
                
        ELSE
                UPDATE VISITE_CONTROLE  SET RESIDANTID='VPARDEFAUT'  WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;            
                UPDATE VISITES_RESIDANTS  SET RESIDANTID='VPARDEFAUT'  WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
                UPDATE VISITES_TEMP  SET RESIDANTID='VPARDEFAUT'  WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
                UPDATE ZCL01_VISITERE  SET RESIDANTID='VPARDEFAUT'  WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE);
                UPDATE VISITES SET RESIDANTID='VPARDEFAUT', NOMPRENOMRESID=(SELECT NOM||' '||PRENOM FROM RESIDANTS WHERE RESIDANTID='VPARDEFAUT') WHERE RESIDANTID IN (SELECT MYENTITEID FROM  TEMP_MYPURGE) ;
        END IF;
        
DELETE from residants where residantid IN (SELECT MYENTITEID FROM  TEMP_MYPURGE);
DELETE FROM TACHE WHERE E_TACexecuteouinactive is not null and actif<0;
DELETE FROM CFG_FICHIER WHERE  E_TACsesconfigs is not null AND CFG_FICHIERID IN (SELECT ACT_PARAM FROM TACHE WHERE  E_TACexecuteouinactive is not null and actif<0);
DELETE FROM TACHE_LOG WHERE E_TALpurge is not null;
DELETE FROM MAIL WHERE STATUT<>-1 AND E_MAIenvoye is not null;
DELETE FROM agenda_jour2 where STATUT=5 AND (E_AJ2termine is not null);
DELETE FROM COLISEMIS WHERE  (E_COLcolis is not null);
DELETE FROM COLISRECU WHERE  (E_COLcolis is not null);
DELETE FROM CONSIGNE where TYPECONSIGNE='MESSAGES' AND DATELU is not null AND (E_CONsupmessageslus is not null);
DELETE FROM SOCIETE WHERE (E_SOCnonutilise is not null) AND societeid in ( SELECT SOCIETEID FROM SOCIETE I WHERE
 0=(Select COUNT(societeid) from interlocuteur WHERE SOCIETEID=I.SOCIETEID) AND 0=(select COUNT(societeid) from residants WHERE SOCIETEID=I.SOCIETEID)) AND SOCIETEID<>'VPARDEFAUT'    ;
DELETE FROM reservation where codereservation in (SELECT CODERESERVATION FROM LGRESERVATION WHERE CODERESERVATION IN (SELECT codelgreservation
   from lgreservation
   where
    (
    E_LGRtermineedepuisnbjours is not null and to_number(E_LGRtermineedepuisnbjours)+ To_date(datefin,'DD/MM/YYYY HH24:MI:SS')<To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS')
    OR
    E_LGRtermineedepuisdate is not null and To_date(datefin,'DD/MM/YYYY HH24:MI:SS')<To_date(E_LGRtermineedepuisdate,'DD/MM/YYYY HH24:MI:SS')

    )));

DELETE FROM LGRESERVATION WHERE  codelgreservation IN (SELECT codelgreservation
   from lgreservation
   where
    E_LGRtermineedepuisnbjours<>'' and E_LGRtermineedepuisnbjours is not null and  to_number(E_LGRtermineedepuisnbjours)+ To_date(datefin,'DD/MM/YYYY HH24:MI:SS')<To_date(SYSDATE,'DD/MM/YYYY HH24:MI:SS')
    OR
    E_LGRtermineedepuisdate is not null and To_date(datefin,'DD/MM/YYYY HH24:MI:SS')<To_date(E_LGRtermineedepuisdate,'DD/MM/YYYY HH24:MI:SS')
    );
 
DELETE FROM TEMP_MYPURGE;
END;
/
