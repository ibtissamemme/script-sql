CREATE TABLE GRPEVENEMENT_POSTE (
	GRPEVENEMENTID INT NOT NULL,
	POSTEID INT NOT NULL
);
COMMIT

create or replace function BLOBTOVARCHAR(B BLOB)
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
EXIT;