ALTER TABLE RESERVATION ADD EMETTEUR VARCHAR(200)
GO

UPDATE RESERVATION SET EMETTEUR=(SELECT FULLNAME FROM USERS WHERE USERID=RESERVATION.USERID)
GO

UPDATE GRPUSER SET RESA=RESA+'011'
GO