ALTER TABLE BADGES_ELEMENTS ADD CLRACCUEIL INTEGER DEFAULT(0)
GO
ALTER TABLE BADGES_ELEMENTS_tmp ADD CLRACCUEIL INT DEFAULT(0)
GO
UPDATE BADGES_ELEMENTS_tmp set CLRACCUEIL=0
UPDATE BADGES_ELEMENTS set CLRACCUEIL=0
GO
ALTER TABLE SITE ADD  SITE_OUVERT INT DEFAULT(1)
GO
UPDATE SITE SET SITE_OUVERT='1'
GO