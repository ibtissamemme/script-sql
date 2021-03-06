create or replace function F(B BLOB)
return clob is
  c clob;
  n number;
  T number;
begin

  T := dbms_lob.GETLENGTH(B);

  if (b is null) then
    return null;
  end if;
  if (T = 0 ) then
    return empty_clob();
  end if;
  dbms_lob.createtemporary(c,true);
  n:=1;
  while (n+32767<=T) loop
    dbms_lob.writeappend(c,32767,utl_raw.cast_to_varchar2(dbms_lob.substr(b,32767,n)));
    n:=n+32767;
  end loop;
  dbms_lob.writeappend(c,T-n+1,utl_raw.cast_to_varchar2(dbms_lob.substr(b,T-n+1,n)));
  return c;
end;
/

COMMIT;

ALTER TABLE RESERVATION ADD TEMPO VARCHAR2(3000);
UPDATE RESERVATION SET TEMPO=f(COMMENTAIRE),COMMENTAIRE=null;
ALTER TABLE RESERVATION DROP COLUMN COMMENTAIRE;
ALTER TABLE RESERVATION ADD COMMENTAIRE VARCHAR2(3000);
UPDATE RESERVATION SET COMMENTAIRE=TEMPO;
ALTER TABLE RESERVATION DROP COLUMN TEMPO;

COMMIT;

ALTER TABLE SALLE ADD TEMPO VARCHAR2(3000);
UPDATE SALLE SET TEMPO=f(OBSERVATIONS),OBSERVATIONS=null;
ALTER TABLE SALLE DROP COLUMN OBSERVATIONS;
ALTER TABLE SALLE ADD OBSERVATIONS VARCHAR2(3000);
UPDATE SALLE SET OBSERVATIONS=TEMPO;
ALTER TABLE SALLE DROP COLUMN TEMPO;

COMMIT;

ALTER TABLE LGPA ADD TEMPO VARCHAR2(3000);
UPDATE LGPA SET TEMPO=f(COMMENTAIRE),COMMENTAIRE=null;
ALTER TABLE LGPA DROP COLUMN COMMENTAIRE;
ALTER TABLE LGPA ADD COMMENTAIRE VARCHAR2(3000);
UPDATE LGPA SET COMMENTAIRE=TEMPO;
ALTER TABLE LGPA DROP COLUMN TEMPO;
COMMIT;

EXIT;