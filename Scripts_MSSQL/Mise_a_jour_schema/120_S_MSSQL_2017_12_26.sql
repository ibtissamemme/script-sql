ALTER TABLE COLISEMIS ADD EMETTEURTYPE VARCHAR(15)
GO
ALTER TABLE COLISEMIS ADD CORRESTYPE VARCHAR(15)
GO

ALTER TABLE COLISRECU ADD EMETTEURTYPE VARCHAR(15)
GO
ALTER TABLE COLISRECU ADD CORRESTYPE VARCHAR(15)
GO



ALTER TABLE COLISEMIS DROP CONSTRAINT fk_cole_resiid
GO

ALTER TABLE COLISRECU DROP CONSTRAINT fk_colr_resiid
GO
