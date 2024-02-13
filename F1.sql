------------------------------------------------------------
-- Script F1 
------------------------------------------------------------
 
Drop SCHEMA IF EXISTS f1 cascade;
set search_path to f1;
CREATE SCHEMA f1
 
------------------------------------------------------------
-- Table: circuit
------------------------------------------------------------
CREATE TABLE f1.circuit(
nom VARCHAR (50) NOT NULL ,
pays VARCHAR (50) NOT NULL ,
nbrVirage INT NOT NULL ,
nbrKm FLOAT NOT NULL ,
capacite INT NOT NULL ,
recordCircuit VARCHAR (50) NOT NULL ,
CONSTRAINT circuit_PK PRIMARY KEY (nom)
);
 
------------------------------------------------------------
-- Table: grandPrix
------------------------------------------------------------
CREATE TABLE f1.grandPrix(
nomGP VARCHAR (150) NOT NULL ,
dateCourse DATE NOT NULL ,
edition INT NOT NULL ,
recordTour VARCHAR (50) NOT NULL ,
piloteDuJour VARCHAR (50) NOT NULL ,
circuit VARCHAR (50) NOT NULL ,
CONSTRAINT grandPrix_PK PRIMARY KEY (nomGP),
CONSTRAINT grandPrix_FK FOREIGN KEY (circuit) references f1.circuit(nom)
);
 
------------------------------------------------------------
-- Table: écurie
------------------------------------------------------------
CREATE TABLE f1.ecurie(
idEcurie SERIAL NOT NULL ,
nom VARCHAR (50) NOT NULL ,
dateCreation INT NOT NULL ,
motoriste VARCHAR (50) NOT NULL ,
pays VARCHAR (50) NOT NULL ,
usine VARCHAR (50) NOT NULL ,
nbrTitre INT NOT NULL ,
idDirecteur INT NOT NULL ,
CONSTRAINT ecurie_PK PRIMARY KEY (idEcurie)
);
 
------------------------------------------------------------
-- Table: personne
------------------------------------------------------------
CREATE TABLE f1.personne(
nom VARCHAR (50) NOT NULL ,
prenom VARCHAR (50) NOT NULL ,
dateNaissance DATE NOT NULL ,
nationalite VARCHAR (50) NOT NULL ,
idEcurie INT NOT NULL,
CONSTRAINT personne_FK FOREIGN KEY (idEcurie) references f1.ecurie(idEcurie)
);
 
------------------------------------------------------------
-- Table: pilote
------------------------------------------------------------
CREATE TABLE f1.pilote(
numeroLicence INT NOT NULL ,
numeroVoiture INT NOT NULL ,
CONSTRAINT pilote_PK PRIMARY KEY (numeroLicence),
CONSTRAINT pilote_FK FOREIGN KEY (idEcurie) references f1.ecurie(idEcurie)
)INHERITS (f1.personne);
 
------------------------------------------------------------
-- Table: directeurEcurie
------------------------------------------------------------
CREATE TABLE f1.directeurEcurie(
idDirecteur SERIAL NOT NULL ,
CONSTRAINT directeurEcurie_PK PRIMARY KEY (idDirecteur),
CONSTRAINT directeurEcurie_FK FOREIGN KEY (idEcurie) references f1.ecurie(idEcurie)
)INHERITS (f1.personne);
 
------------------------------------------------------------
-- Table: performancePilote
------------------------------------------------------------
CREATE TABLE f1.performancePilote(
grandPrix VARCHAR (150) NOT NULL ,
pilote INT NOT NULL ,
classement INT NOT NULL ,
nbrPoint INT NOT NULL ,
CONSTRAINT performancePilote_PK PRIMARY KEY (grandPrix, pilote),
CONSTRAINT performancePilote_FK FOREIGN KEY (grandPrix) references f1.grandPrix(nomGP),
CONSTRAINT performancePilote0_FK FOREIGN KEY (pilote) references f1.pilote(numeroLicence)
);
 
------------------------------------------------------------
-- Insertion
------------------------------------------------------------
 
INSERT INTO f1.circuit(nom, pays, nbrVirage, nbrKm, capacite, recordCircuit) VALUES
('Monza', 'Italie', 11, 5.793, 113860, '1:21.046'),
('Silverstone Circuit', 'Royaume-Uni', 18, 5.891, 150000, '1:27.097'),
('Spa-Francorchamps', 'Belgique', 19, 7.004, 90000, '1:46.286'),
('Monaco', 'Monaco', 19, 3.337, 20000, '1:14.260'),
('Baku City Circuit', 'Azerbaijan', 20, 6.003, 18500, '1:43.009'),
('Suzuka', 'Japon', 18, 5.807, 15500, '1:30.983'),
('Barcelona-Catalunya', 'Espagne', 16, 4.675, 140700, '1:18.149'),
('Gilles-Villeneuve', 'Canada', 14, 4.361, 65000, '1:20.521'),
('Red Bull Ring', 'Autriche', 10, 4.318, 67000, '1:03.897'),
('Zandvoort', 'Pays-Bas', 14, 4.259, 70000, '1:11.097'),
('Cota', 'Etats-Unis', 20, 5.513, 120000, '1:32.029'),
('Imola', 'Italie', 19, 4.909, 78000, '1:15.484'),
('Portimao', 'Portugal', 15, 4.653, 65000, '1:18.750'),
('Melbourne', 'Australie', 16, 5.303, 80000, '1:24.125'),
('Bahrain International Circuit', 'Bahrein', 15, 5.412, 45000, '1:31.447'),
('Paul Ricard', 'France', 15, 5.842, 90000, '1:32.740'),
('Jeddah Corniche', 'Arabie Saoudite', 27, 6.174, 80000, '1:28.139'),
('Yas Marina Circuit', 'Emirats Arabes Unis', 16, 5.281, 60000, '1:38.251')
;
 
INSERT INTO f1.grandPrix (nomGP, dateCourse, edition, recordTour, piloteDuJour, circuit) VALUES
('FORMULA 1 GRAND PRIX DE MONACO 2023', '28-05-2023', 2023, '1:15.650', 'Ocon', 'Monaco'),
('FORMULA 1 GULF AIR BAHRAIN GRAND PRIX 2023', '05-03-2023', 2023, '1:33.996', 'Alonso', 'Bahrain International Circuit'),
('FORMULA 1 STC SAUDI ARABIAN GRAND PRIX 2023', '19-03-2023', 2023, '1:31.906', 'Verstappen', 'Jeddah Corniche'),
('FORMULA 1 ROLEX AUSTRALIAN GRAND PRIX 2023', '02-04-2023', 2023, '1:20.235', 'Perez', 'Melbourne'),
('FORMULA 1 AZERBAIJAN GRAND PRIX 2023', '30-04-2023', 2023, '1:43.370', 'Perez', 'Baku City Circuit'),
('FORMULA 1 HEINEKEN DUTCH GRAND PRIX 2023', '27-08-2023', 2023, '1:10.567', 'Alonso', 'Zandvoort'),
 
('FORMULA 1 ROLEX BELGIAN GRAND PRIX 2022', '28-08-2022', 2022, '1:49.354', 'Verstappen', 'Spa-Francorchamps'),
('FORMULA 1 PIRELLI GRAN PREMIO DE ESPAÑA 2022', '22-05-2022', 2022, '1:24.108', 'Hamilton','Barcelona-Catalunya'),
('FORMULA 1 AWS GRAND PRIX DU CANADA 2022', '19-06-2022', 2022, '1:15.749', 'Leclerc', 'Gilles-Villeneuve'),
('FORMULA 1 LENOVO BRITISH GRAND PRIX 2022', '03-07-2022', 2022, '17:21:12', 'Perez', 'Silverstone Circuit'),
('FORMULA 1 ROLEX GROSSER PREIS VON ÖSTERREICH 2022', '10-07-2022', 2022, '1:07.275', 'Schumacher', 'Red Bull Ring'),
 
('FORMULA 1 PIRELLI GRAN PREMIO DEL MADE IN ITALY E DELL EMILIA ROMAGNA 2021', '18-04-2021', 2021, '1:16.702', 'Norris', 'Imola'),
('FORMULA 1 HEINEKEN GRANDE PRÉMIO DE PORTUGAL 2021', '02-05-2021', 2021, '1:19.865', 'Perez', 'Portimao'),
('FORMULA 1 ARAMCO UNITED STATES GRAND PRIX 2021', '24-10-2021', 2021, '1:38.485', 'Verstappen', 'Cota'),
('FORMULA 1 HEINEKEN GRAN PREMIO D’ITALIA 2021', '12-09-2021', 2021, '1:24.812', 'Ricciardo', 'Monza'),
('FORMULA 1 EMIRATES GRAND PRIX DE FRANCE 2021', '20-06-2021', 2021, '1:36.404', 'Verstappen', 'Paul Ricard'),
('FORMULA 1 BWT GROSSER PREIS DER STEIERMARK 2021', '27-06-2021', 2021, '1:07.058', 'Leclerc', 'Red Bull Ring'),
('FORMULA 1 ETIHAD AIRWAYS ABU DHABI GRAND PRIX 2021', '12-12-2021', 2021, '1:26.103', 'Raikkonen', 'Yas Marina Circuit')
;
 
INSERT INTO f1.ecurie(nom, dateCreation, motoriste, pays, usine, nbrTitre, idDirecteur) VALUES
('Red Bull Racing', 2004, 'Red Bull Powertrains', 'Autriche', 'Milton Keynes', 6, 1),
('Scuderia Ferrari', 1929, 'Ferrari', 'Italie', 'Maranello', 16, 2),
('Mercedes AMG F1 Team', 2010, 'Mercedes', 'Allemagne', 'Brackley', 7, 3),
('McLaren Racing', 1963, 'Mercedes', 'Royaume-Uni', 'Woking', 8, 4),
('Alpine F1 Team', 1977, 'Renault', 'France', 'Enstone', 2, 5),
('Aston Martin F1 Team', 2021, 'Mercedes', 'Royaume-Uni', 'Silverstone', 0, 6),
('Scuderia AlphaTauri', 2006, 'Honda', 'Italie', 'Faenza', 0, 7),
('Alpha Romeo Racing', 1993, 'Ferrari', 'Suisse', 'Hinwill', 0, 8),
('Williams Racing', 1977, 'Mercedes', 'Royaume-Uni', 'Grove', 9, 9),
('Haas F1 Team', 2016, 'Ferrari', 'Etat-Unis', 'Banbury', 0, 10)
;
 
INSERT INTO f1.directeurEcurie(nom, prenom, dateNaissance, nationalite, idEcurie) VALUES
('Horner', 'Christian', '1973-11-16', 'Royaume-Uni', 1),
('Vasseur', 'Frédéric', '1968-02-19', 'France', 2),
('Wolff', 'Toto', '1972-01-12', 'Autriche', 3),
('Brown', 'Zak', '1972-11-07', 'Etat-Unis', 4),
('Szafnauer', 'Otmar', '19-08-1964', 'Roumanie', 5),
('Krack', 'Mike', '18-03-1972', 'Luxembourg', 6),
('Tost', 'Franz', '20-10-1956', 'Autriche', 7),
('Seidl', 'Andreas', '06-01-1976', 'Allemagne', 8),
('Vowles', 'James', '20-06-1979', 'Royaume-Uni', 9),
('Steiner', 'Günther', '07-04-1965', 'Américain', 10)
;
 
INSERT INTO f1.pilote(numeroLicence, nom, prenom, dateNaissance, nationalite, numeroVoiture, idEcurie) VALUES
(0133,'Verstappen', 'Max', '30-09-1997', 'Pays-Bas', 1, 1),
(0211,'Perez', 'Sergio', '26-01-1990', 'Mexique', 11, 1),
(0316,'Leclerc', 'Charles', '16-10-1997', 'Monaco', 16, 2),
(0455,'Sainz', 'Carlos', '01-09-1994', 'Espagne', 55, 2),
(0544,'Hamilton', 'Lewis', '07-01-1985', 'Royaume-Uni', 44, 3),
(0663,'Russell', 'George', '15-02-1998', 'Royaume-Uni', 63, 3),
(0704,'Norris', 'Lando', '13-11-1999', 'Royaume-Uni', 4, 4),
(0881,'Piastri', 'Oscar', '06-04-2001', 'Australie', 81, 4),
(0910,'Gasly', 'Pierre', '07-02-1996', 'France', 10, 5),
(1031,'Ocon', 'Esteban', '17-09-1996', 'France', 31, 5),
(1114,'Alonso', 'Fernando', '29-07-1981', 'Espagne', 14, 6),
(1218,'Lance', 'Stroll', '29-10-1998', 'Canada', 18, 6),
(1303,'Ricciardo', 'Daniel', '01-07-1989', 'Australie', 3, 7),
(1477,'Valtteri', 'Bottas', '28-09-1989', 'Finlande', 77, 8),
(1523,'Alexander', 'Albon', '23-03-1996', 'Thailand', 23, 9)
;
 
-- FORMULA 1 GRAND PRIX DE MONACO 2023
INSERT INTO f1.performancePilote (grandPrix, pilote, classement, nbrPoint)VALUES
('FORMULA 1 GRAND PRIX DE MONACO 2023', 1031, 3, 15),
('FORMULA 1 GRAND PRIX DE MONACO 2023', 1114, 2, 18),
('FORMULA 1 GRAND PRIX DE MONACO 2023', 0910, 7, 6),
 
-- FORMULA 1 GULF AIR BAHRAIN GRAND PRIX 2023
('FORMULA 1 GULF AIR BAHRAIN GRAND PRIX 2023', 0133, 1, 25),
('FORMULA 1 GULF AIR BAHRAIN GRAND PRIX 2023', 1114, 3, 15),
('FORMULA 1 GULF AIR BAHRAIN GRAND PRIX 2023', 1523, 10, 1),
 
-- FORMULA 1 STC SAUDI ARABIAN GRAND PRIX 2023
('FORMULA 1 STC SAUDI ARABIAN GRAND PRIX 2023', 0211, 1, 25),
('FORMULA 1 STC SAUDI ARABIAN GRAND PRIX 2023', 0704, 17, 0),
('FORMULA 1 STC SAUDI ARABIAN GRAND PRIX 2023', 0663,4,12),
 
-- FORMULA 1 ROLEX AUSTRALIAN GRAND PRIX 2023
('FORMULA 1 ROLEX AUSTRALIAN GRAND PRIX 2023', 1218, 4, 12),
('FORMULA 1 ROLEX AUSTRALIAN GRAND PRIX 2023', 0881, 8, 4),
('FORMULA 1 ROLEX AUSTRALIAN GRAND PRIX 2023', 0910, 13, 0),
 
-- FORMULA 1 AZERBAIJAN GRAND PRIX 2023
('FORMULA 1 AZERBAIJAN GRAND PRIX 2023', 0316, 3, 15),
('FORMULA 1 AZERBAIJAN GRAND PRIX 2023', 0133, 2, 18),
('FORMULA 1 AZERBAIJAN GRAND PRIX 2023', 0544, 6, 8),
 
--FORMULA 1 HEINEKEN DUTCH GRAND PRIX 2023
('FORMULA 1 HEINEKEN DUTCH GRAND PRIX 2023', 0910, 3, 15),
('FORMULA 1 HEINEKEN DUTCH GRAND PRIX 2023', 0133, 1, 25),
('FORMULA 1 HEINEKEN DUTCH GRAND PRIX 2023', 1523, 8, 4),
 
-- FORMULA 1 ROLEX BELGIAN GRAND PRIX 2022
('FORMULA 1 ROLEX BELGIAN GRAND PRIX 2022', 0133, 1, 25),
('FORMULA 1 ROLEX BELGIAN GRAND PRIX 2022', 0663, 4, 12),
('FORMULA 1 ROLEX BELGIAN GRAND PRIX 2022', 1523, 10, 1),
 
-- FORMULA 1 PIRELLI GRAN PREMIO DE ESPAÑA 2022
('FORMULA 1 PIRELLI GRAN PREMIO DE ESPAÑA 2022', 0133, 1, 25),
('FORMULA 1 PIRELLI GRAN PREMIO DE ESPAÑA 2022', 1477, 6, 8),
('FORMULA 1 PIRELLI GRAN PREMIO DE ESPAÑA 2022', 0663, 3, 15),
('FORMULA 1 PIRELLI GRAN PREMIO DE ESPAÑA 2022', 1303, 12, 0),
 
-- FORMULA 1 AWS GRAND PRIX DU CANADA 2022
('FORMULA 1 AWS GRAND PRIX DU CANADA 2022', 1218, 10, 1),
('FORMULA 1 AWS GRAND PRIX DU CANADA 2022', 1031, 6, 8),
('FORMULA 1 AWS GRAND PRIX DU CANADA 2022', 0544, 3, 15),
 
--FORMULA 1 LENOVO BRITISH GRAND PRIX 2022
('FORMULA 1 LENOVO BRITISH GRAND PRIX 2022', 0211, 2, 18),
('FORMULA 1 LENOVO BRITISH GRAND PRIX 2022', 1114, 5, 10),
('FORMULA 1 LENOVO BRITISH GRAND PRIX 2022', 1303, 13, 0),
('FORMULA 1 LENOVO BRITISH GRAND PRIX 2022', 0455, 1, 25),
 
--FORMULA 1 ROLEX GROSSER PREIS VON ÖSTERREICH 2022
('FORMULA 1 ROLEX GROSSER PREIS VON ÖSTERREICH 2022',0316 , 1, 25),
('FORMULA 1 ROLEX GROSSER PREIS VON ÖSTERREICH 2022',0544 , 3, 15),
('FORMULA 1 ROLEX GROSSER PREIS VON ÖSTERREICH 2022',0704 , 7, 6),
 
-- FORMULA 1 PIRELLI GRAN PREMIO DEL MADE IN ITALY E DELL EMILIA ROMAGNA 2021
('FORMULA 1 PIRELLI GRAN PREMIO DEL MADE IN ITALY E DELL EMILIA ROMAGNA 2021',0133, 1, 25),
('FORMULA 1 PIRELLI GRAN PREMIO DEL MADE IN ITALY E DELL EMILIA ROMAGNA 2021',0544, 2, 19),
('FORMULA 1 PIRELLI GRAN PREMIO DEL MADE IN ITALY E DELL EMILIA ROMAGNA 2021',0455, 5, 10),
 
-- FORMULA 1 ARAMCO UNITED STATES GRAND PRIX 2021
('FORMULA 1 ARAMCO UNITED STATES GRAND PRIX 2021',1477, 6, 8),
('FORMULA 1 ARAMCO UNITED STATES GRAND PRIX 2021',0211, 3, 15),
('FORMULA 1 ARAMCO UNITED STATES GRAND PRIX 2021',0316, 4, 12),
 
-- FORMULA 1 EMIRATES GRAND PRIX DE FRANCE 2021
('FORMULA 1 EMIRATES GRAND PRIX DE FRANCE 2021',0133, 1, 26),
('FORMULA 1 EMIRATES GRAND PRIX DE FRANCE 2021',1218, 10, 1),
('FORMULA 1 EMIRATES GRAND PRIX DE FRANCE 2021',1031, 14, 0),
 
-- FORMULA 1 BWT GROSSER PREIS DER STEIERMARK 2021
('FORMULA 1 BWT GROSSER PREIS DER STEIERMARK 2021',1477, 3, 15),
('FORMULA 1 BWT GROSSER PREIS DER STEIERMARK 2021',0211, 4, 12),
('FORMULA 1 BWT GROSSER PREIS DER STEIERMARK 2021',0704, 5, 10),
 
-- FORMULA 1 HEINEKEN GRANDE PRÉMIO DE PORTUGAL 2021
('FORMULA 1 HEINEKEN GRANDE PRÉMIO DE PORTUGAL 2021', 0544, 1, 25),
('FORMULA 1 HEINEKEN GRANDE PRÉMIO DE PORTUGAL 2021', 1114, 8, 4),
('FORMULA 1 HEINEKEN GRANDE PRÉMIO DE PORTUGAL 2021', 0133, 2, 18),
('FORMULA 1 HEINEKEN GRANDE PRÉMIO DE PORTUGAL 2021', 0910, 10, 1),
 
-- FORMULA 1 ETIHAD AIRWAYS ABU DHABI GRAND PRIX 2021
('FORMULA 1 ETIHAD AIRWAYS ABU DHABI GRAND PRIX 2021',0133, 1, 26),
('FORMULA 1 ETIHAD AIRWAYS ABU DHABI GRAND PRIX 2021',0544, 2, 18),
('FORMULA 1 ETIHAD AIRWAYS ABU DHABI GRAND PRIX 2021',0910, 5, 10),
('FORMULA 1 ETIHAD AIRWAYS ABU DHABI GRAND PRIX 2021',0455, 3, 15),
 
-- FORMULA 1 HEINEKEN GRAN PREMIO D’ITALIA 2021
('FORMULA 1 HEINEKEN GRAN PREMIO D’ITALIA 2021', 1303, 1, 26),
('FORMULA 1 HEINEKEN GRAN PREMIO D’ITALIA 2021', 0704, 2, 18),
('FORMULA 1 HEINEKEN GRAN PREMIO D’ITALIA 2021', 1218, 7, 6)
;

