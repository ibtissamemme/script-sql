DELETE FROM TYPEVISITE WHERE TYPEVISITEID NOT IN ('0')
GO
DELETE FROM TYPEVISITE WHERE TYPEVISITEID>=0
GO
DELETE FROM TYPEVISITE WHERE TYPEVISITEID<0 AND TYPEVISITEID<>-2
GO
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('0','01- Mathematiques','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('1','02- Traitement du signal','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('2','03- Physique de base','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('3','04- Physique nucleaire et corpusculaire','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('4','05- Chimie et physico-chimie','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('5','06- Science de l''ingenieur','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('6','07- Informatique et automatisme','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('7','08- Oceanologie','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('8','09- Sciences de la terre','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('9','10- Sciences de la vie','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('10','11- Sciences de l''homme et de la societe','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('11','12- Materiaux- metallurgie','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('12','13- Electricite - electromagnetisme','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('13','14- Electronique - optoelectronique','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('14','15- Optique - lasers','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('15','16- Acoustique','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('16','17- Detection (sauf acoustique)','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('17','18- Navigation, guidage','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('18','19- Propulsion - conversion d''energie','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('19','20- Detonique','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('20','21- Robotique','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('21','22- BIOTECHNOLOGIES - PHARMACO.','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('22','23- Productique','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('23','24- Instrumentalisation','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('24','25- Simulation','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('25','26- Ordinateurs, calcul automatique','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('26','27- Transports terrestres','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('27','28- Transports maritimes','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('28','29- Aeronautique','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('29','30- Spatial et aerospatial','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('30','31- Telecommunications, transmissions','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('31','32- Traitement de l''information','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('32','33- Energie nucleaire','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('33','34- Energie non nucleaire','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('34','35- protection de l''environnement','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('35','36- Autres','0',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('36','01- Mathematiques','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('37','02- Traitement du signal','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('38','03- Physique de base','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('39','04- Physique nucleaire et corpusculaire','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('40','05- Chimie et physico-chimie','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('41','06- Science de l''ingenieur','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('42','07- Informatique et automatisme','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('43','08- Oceanologie','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('44','09- Sciences de la terre','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('45','10- Sciences de la vie','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('46','11- Sciences de l''homme et de la societe','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('47','12- Materiaux- metallurgie','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('48','13- Electricite - electromagnetisme','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('49','14- Electronique - optoelectronique','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('50','15- Optique - lasers','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('51','16- Acoustique','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('52','17- Detection (sauf acoustique)','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('53','18- Navigation, guidage','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('54','19- Propulsion - conversion d''energie','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('55','20- Detonique','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('56','21- Robotique','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('57','22- BIOTECHNOLOGIES - PHARMACO.','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('58','23- Productique','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('59','24- Instrumentalisation','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('60','25- Simulation','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('61','26- Ordinateurs, calcul automatique','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('62','27- Transports terrestres','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('63','28- Transports maritimes','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('64','29- Aeronautique','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('65','30- Spatial et aerospatial','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('66','31- Telecommunications, transmissions','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('67','32- Traitement de l''information','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('68','33- Energie nucleaire','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('69','34- Energie non nucleaire','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('70','35- protection de l''environnement','1',getdate(),getdate())
INSERT INTO TYPEVISITE (TYPEVISITEID,TYPEVISITE,TRAVAIL,DATECREATION,DATEMAJ) VALUES('71','36- Autres','1',getdate(),getdate())
GO