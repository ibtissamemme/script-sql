EXEC sp_addlogin 'UNIS','Uni$2016','UNIS';
EXEC sp_grantdbaccess N'UNIS', N'UNIS';
EXEC sp_addrolemember N'db_owner', N'UNIS';
EXEC sp_defaultlanguage UNIS, 'French';
GO
