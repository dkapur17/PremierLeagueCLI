--  Creating the Required Tables
CREATE TABLE `CLUBS` (
    `Name` VARCHAR(255) PRIMARY KEY,
    `W` INT DEFAULT 0,
    `D` INT DEFAULT 0,
    `L` INT DEFAULT 0,
    `GF` INT DEFAULT 0,
    `GA` INT DEFAULT 0
);
CREATE TABLE `PLAYERS` (
    `First Name` VARCHAR(255),
    `Middle Name` VARCHAR(255),
    `Last Name` VARCHAR(255),
    `Club Name` VARCHAR(255),
    `Jersey Number` INT,
    `DOB` DATE,
    `Market Value` INT,
    `Contract Duration` INT,
    PRIMARY KEY (`Club Name`, `Jersey Number`),
    FOREIGN KEY (`Club Name`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `PLAYERS_OUTFIELD` (
    `Club Name` VARCHAR(255),
    `Jersey Number` INT,
    `Goals Scored` INT DEFAULT 0,
    `Tackles Won` INT DEFAULT 0,
    `Assists Provided` INT DEFAULT 0,
    PRIMARY KEY (`Club Name`, `Jersey Number`),
    FOREIGN KEY (`Club Name`, `Jersey Number`) REFERENCES `PLAYERS` (`Club Name`, `Jersey Number`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `PLAYERS_GOALKEEPER` (
    `Club Name` VARCHAR(255),
    `Jersey Number` INT,
    `Saves` INT DEFAULT 0,
    `Clean Sheets` INT DEFAULT 0,
    PRIMARY KEY (`Club Name`, `Jersey Number`),
    FOREIGN KEY (`Club Name`, `Jersey Number`) REFERENCES `PLAYERS` (`Club Name`, `Jersey Number`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `MANAGERS` (
    `First Name` VARCHAR(255),
    `Middle Name` VARCHAR(255),
    `Last Name` VARCHAR(255),
    `Club Name` VARCHAR(255) PRIMARY KEY,
    `DOB` DATE,
    FOREIGN KEY (`Club Name`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `STADIUMS` (
    `Name` VARCHAR(255) PRIMARY KEY,
    `Address` VARCHAR(255),
    `Longitude` DECIMAL(10, 3),
    `Latitude` DECIMAL(10, 3),
    `Capacity` INT DEFAULT 100000,
    `Broke Ground` INT
);
CREATE TABLE `KITS` (
    `Club Name` VARCHAR(255) NOT NULL,
    `Type` ENUM ('Home', 'Away', 'Alternate'),
    `Jersey` VARCHAR(255),
    `Shorts` VARCHAR(255),
    `Stockings` VARCHAR(255),
    PRIMARY KEY (`Club Name`, `Type`),
    FOREIGN KEY (`Club Name`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `ALTERNATE NAMES` (
    `Alternate Name` VARCHAR(255) PRIMARY KEY,
    `Club` VARCHAR(255),
    FOREIGN KEY (`Club`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `CLUB-STADIUM` (
    `Club Name` VARCHAR(255) PRIMARY KEY,
    `Stadium Name` VARCHAR(255),
    FOREIGN KEY (`Stadium Name`) REFERENCES `STADIUMS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Club Name`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `FIXTURES` (
    `Match ID` INT AUTO_INCREMENT PRIMARY KEY,
    `Home Club` VARCHAR(255),
    `Away Club` VARCHAR(255),
    `Home Club Kit` ENUM ('Home', 'Away', 'Alternate') DEFAULT 'Home',
    `Away Club Kit` ENUM ('Home', 'Away', 'Alternate') DEFAULT 'Away',
    FOREIGN KEY (`Home Club`) REFERENCES `CLUB-STADIUM` (`Club Name`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Home Club`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Away Club`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Home Club`, `Home Club Kit`) REFERENCES `KITS` (`Club Name`, `Type`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Away Club`, `Away Club Kit`) REFERENCES `KITS` (`Club Name`, `Type`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `MATCHES` (
    `Match ID` INT PRIMARY KEY,
    `Start Time` DATETIME,
    `Home Team Score` INT,
    `Away Team Score` INT,
    FOREIGN KEY (`Match ID`) REFERENCES `FIXTURES` (`Match ID`) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE FIXTURES AUTO_INCREMENT = 1;

-- Inserting 15/20 Clubs:
INSERT INTO CLUBS(`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Leicester City", 3, 0, 0, 12, 4);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Liverpool", 3, 0, 0, 9, 4);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Everton", 3, 0, 0, 8, 3);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Aston Villa", 2, 0, 0, 4, 0);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Arsenal", 2, 1, 0, 6, 4);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Crystal Palace", 2, 0, 1, 5, 3);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Leeds United", 2, 0, 1, 8, 7);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Tottenham", 1, 1, 1, 6, 4);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Chelsea", 1, 1, 1, 6, 6);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Newcastle", 1, 1, 1, 3, 4);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("West Ham", 1, 0, 2, 5, 4);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Brighton", 1, 0, 2, 6, 6);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Manchester City", 1, 0, 1, 5, 6);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Manchester United", 1, 0, 1, 4, 5);
INSERT INTO CLUBS (`Name`, `W`, `D`, `L`, `GF`, `GA`)
VALUES("Southampton", 1, 0, 2, 3, 6);

-- Inserting Players

INSERT INTO PLAYERS VALUES ("Harry", NULL, "Lewis", "Southampton", 41, "1997-12-20", 2000000, 4);
INSERT INTO PLAYERS VALUES ("Yan", NULL, "Valery", "Southampton", 23, "1999-02-22", 4000000, 1);
INSERT INTO PLAYERS VALUES ("Danny", NULL, "Ings", "Southampton", 9, "1992-07-23", 3000000, 3);
INSERT INTO PLAYERS VALUES ("Joe", NULL, "Hart", "Tottenham", 12, "1987-04-19", 2000000, 1);
INSERT INTO PLAYERS VALUES ("Harry", NULL, "Kane", "Tottenham", 10, "1993-07-28", 8000000, 2);
INSERT INTO PLAYERS VALUES ("Dele", NULL, "Ali", "Tottenham", 20, "1996-04-11", 7000000, 2);
INSERT INTO PLAYERS VALUES ("Lukasz", NULL, "Fabianski", "West Ham", 1, "1985-04-18", 3000000, 3);
INSERT INTO PLAYERS VALUES ("Aaron", NULL, "Cresswell", "West Ham", 3, "1989-12-15", 4000000, 2);
INSERT INTO PLAYERS VALUES ("Michail", NULL, "Antonio", "West Ham", 30, "1990-03-28", 2000000, 4);
INSERT INTO PLAYERS VALUES ("Mark", NULL, "Gillespie", "Newcastle", 29, "1992-03-27", 3000000, 1);
INSERT INTO PLAYERS VALUES ("Jacob", NULL, "Murphy", "Newcastle", 23, "1995-02-24", 4000000, 3);
INSERT INTO PLAYERS VALUES ("Andy", NULL, "Carroll", "Newcastle", 7, "1989-01-06", 6000000, 2);
INSERT INTO PLAYERS VALUES ("David", NULL, "de Gea", "Manchester United", 1, "1990-11-07", 5000000, 3);
INSERT INTO PLAYERS VALUES ("Phil", NULL, "Jones", "Manchester United", 4, "1992-02-21", 1000000, 2);
INSERT INTO PLAYERS VALUES ("Juan", NULL, "Mata", "Manchester United", 8, "1988-04-28", 4000000, 2);
INSERT INTO PLAYERS VALUES ("Ederson", NULL, NULL, "Manchester City", 31, "1993-08-17", 5000000, 3);
INSERT INTO PLAYERS VALUES ("Kevin", NULL, "De Bruyne", "Manchester City", 17, "1991-06-28", 8000000, 2);
INSERT INTO PLAYERS VALUES ("Sergio", NULL, "Aguero", "Manchester City", 10, "1988-06-02", 5000000, 2);
INSERT INTO PLAYERS VALUES ("Allison", NULL, NULL, "Liverpool", 1, "1992-10-02", 5000000, 3);
INSERT INTO PLAYERS VALUES ("Virgil", "Van", "Dijk", "Liverpool", 4, "1991-07-08", 9000000, 4);
INSERT INTO PLAYERS VALUES ("Mohamed", NULL, "Salah", "Liverpool", 11, "1992-06-15", 8000000, 3);
INSERT INTO PLAYERS VALUES ('Bernd',NULL,'Leno','Arsenal',1,'1992-03-04',10000000,3);
INSERT INTO PLAYERS VALUES ('Alexandre',NULL,'Lacazette','Arsenal',9,'1991-05-28',24000000,2);
INSERT INTO PLAYERS VALUES ('Pierre','Emerick','Aubameyang','Arsenal',14,'1989-06-18',50000000,4);
INSERT INTO PLAYERS VALUES ('Tom',NULL,'Heaton','Aston Villa',1,'1986-04-15',5000000,2);
INSERT INTO PLAYERS VALUES ('Marvelous',NULL,'Nakamba','Aston Villa',19,'1994-01-14',3000000,2);
INSERT INTO PLAYERS VALUES ('Wesley',NULL,NULL,'Aston Villa',9,'1996-11-26',5000000,3);
INSERT INTO PLAYERS VALUES ('Mat',NULL,'Ryan','Brighton',1,'1992-04-08',7000000,3);
INSERT INTO PLAYERS VALUES ('Adam',NULL,'Lallana','Brighton',14,'1988-05-10',10000000,2);
INSERT INTO PLAYERS VALUES ('Neal',NULL,'Maupay','Brighton',9,'1996-08-14',10000000,3);
INSERT INTO PLAYERS VALUES ('Kepa',NULL,'Arrizabalaga','Chelsea',1,'1994-10-03',1000000,1);
INSERT INTO PLAYERS VALUES ('Chrisitian',NULL,'Pulisic','Chelsea',10,'1998-09-18',50000000,5);
INSERT INTO PLAYERS VALUES ('Timo',NULL,'Werner','Chelsea',11,'1996-03-06',50000000,4);
INSERT INTO PLAYERS VALUES ('Vincente',NULL,'Guaita','Crystal Palace',31,'1987-01-10',10000000,2);
INSERT INTO PLAYERS VALUES ('Andros',NULL,'Townsend','Crystal Palace',10,'1991-07-16',20000000,3);
INSERT INTO PLAYERS VALUES ('Wilfried',NULL,'Zaha','Crystal Palace',11,'1992-11-10',25000000,3);
INSERT INTO PLAYERS VALUES ('Jordan',NULL,'Pickford','Everton',1,'1994-03-07',20000000,4);
INSERT INTO PLAYERS VALUES ('James',NULL,'Rodriguez','Everton',19,'1991-07-12',30000000,1);
INSERT INTO PLAYERS VALUES ('Richarlison',NULL,NULL,'Everton',7,'1997-05-10',30000000,3);
INSERT INTO PLAYERS VALUES ('Kiko',NULL,'Casilla','Leeds United',13,'1986-10-02',5000000,2);
INSERT INTO PLAYERS VALUES ('Rodrigo',NULL,'Moreno','Leeds United',20,'1991-03-06',10000000,3);
INSERT INTO PLAYERS VALUES ('Patrick',NULL,'Bamford','Leeds United',9,'1993-09-05',15000000,3);
INSERT INTO PLAYERS VALUES ('Kasper',NULL,'Schemeichel','Leicester City',1,'1986-11-05',15000000,2);
INSERT INTO PLAYERS VALUES ('James',NULL,'Maddison','Leicester City',10,'1996-11-23',25000000,3);
INSERT INTO PLAYERS VALUES ('Jamie',NULL,'Vardy','Leicester City',9,'1987-01-11',20000000,2);

-- Inserting Outfield Player Stats

INSERT INTO PLAYERS_OUTFIELD VALUES ("Southampton", 9, 0, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Southampton", 23, 3, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Tottenham", 10, 1, 1, 5);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Tottenham", 20, 0, 1, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("West Ham", 3, 0, 4, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("West Ham", 30, 1, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Newcastle", 29, 0, 2, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Newcastle", 7, 0, 1, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Manchester United", 4, 0, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Manchester United", 8, 0, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Manchester City", 17, 1, 6, 1);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Manchester City", 10, 0, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Liverpool", 4, 1, 6, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ("Liverpool", 11, 3, 3, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Leicester City', 9, 5, 2, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Leicester City', 10, 1, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Leeds United', 9, 3, 0, 1);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Leeds United', 20, 1, 15, 1);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Everton',7,1,11,2);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Everton',19,1,3,1);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Crystal Palace',11,3,1,0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Crystal Palace', 10, 1, 9, 2);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Chelsea',11,0,2,0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Chelsea',10,0,0,0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Brighton',9,3,1,1);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Brighton', 14, 0, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Aston Villa', 9, 0, 0, 0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Aston Villa',19,0,1,0);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Arsenal',14,1,2,1);
INSERT INTO PLAYERS_OUTFIELD VALUES ('Arsenal', 9, 3, 2, 0);

-- Inserting Goalkeeper Stats

INSERT INTO PLAYERS_GOALKEEPER VALUES ("Southampton", 41, 0, 0);
INSERT INTO PLAYERS_GOALKEEPER VALUES ("Tottenham", 12, 0, 0);
INSERT INTO PLAYERS_GOALKEEPER VALUES ("West Ham", 1, 4, 1);
INSERT INTO PLAYERS_GOALKEEPER VALUES ("Newcastle", 29, 0, 0);
INSERT INTO PLAYERS_GOALKEEPER VALUES ("Manchester United", 1, 5, 0);
INSERT INTO PLAYERS_GOALKEEPER VALUES ("Manchester City", 31, 2, 0);
INSERT INTO PLAYERS_GOALKEEPER VALUES ("Liverpool", 1, 5, 1);
INSERT INTO PLAYERS_GOALKEEPER VALUES ('Arsenal', 1, 9, 1);
INSERT INTO PLAYERS_GOALKEEPER VALUES ('Aston Villa',1,0,0);
INSERT INTO PLAYERS_GOALKEEPER VALUES ('Brighton',1,3,1);
INSERT INTO PLAYERS_GOALKEEPER VALUES ('Chelsea',1,5,0);
INSERT INTO PLAYERS_GOALKEEPER VALUES ('Crystal Palace', 31, 11, 1);
INSERT INTO PLAYERS_GOALKEEPER VALUES ('Everton', 1, 7, 1);
INSERT INTO PLAYERS_GOALKEEPER VALUES ('Leeds United', 13, 0, 0);
INSERT INTO PLAYERS_GOALKEEPER VALUES ('Leicester City', 1, 7, 1);

-- Inserting Managers

INSERT INTO MANAGERS VALUES('Mikel', NULL, 'Arteta','Arsenal', '1982-03-26');
INSERT INTO MANAGERS VALUES('Dean', NULL, 'Smith', 'Aston Villa', '1971-03-19');
INSERT INTO MANAGERS VALUES('Graham', NULL, 'Potter', 'Brighton', '1975-05-20');
INSERT INTO MANAGERS VALUES('Frank', NULL, 'Lampard', 'Chelsea', '1978-06-20');
INSERT INTO MANAGERS VALUES('Roy', NULL, 'Hodgson', 'Crystal Palace', '1947-08-09');
INSERT INTO MANAGERS VALUES('Carlo', NULL, 'Anceloti', 'Everton', '1959-06-10');
INSERT INTO MANAGERS VALUES('Marcelo', NULL, 'Bielsa', 'Leeds United', '1955-07-21');
INSERT INTO MANAGERS VALUES('Brendan', NULL, 'Rodgers', 'Leicester City', '1973-01-26');
INSERT INTO MANAGERS VALUES('Jurgen', NULL, 'Klopp', 'Liverpool', '1967-06-16');
INSERT INTO MANAGERS VALUES('Josep', NULL, 'Guardiola', 'Manchester City', '1971-01-18');
INSERT INTO MANAGERS VALUES('Ole', 'Gunnar', 'Solskjaer', 'Manchester United', '1973-02-26');
INSERT INTO MANAGERS VALUES('Steve', NULL, 'Bruce', 'Newcastle', '1960-12-31');
INSERT INTO MANAGERS VALUES('Ralph', NULL, 'Hasenhuttl', 'Southampton', '1967-08-09');
INSERT INTO MANAGERS VALUES('Jose', NULL,'Mourinho', 'Tottenham', '1963-01-26');
INSERT INTO MANAGERS VALUES('David', NULL, 'Moyes', 'West Ham', '1963-04-25');

-- Inserting Kits

INSERT INTO KITS VALUES("Arsenal", "Home", "Red", "White", "Red");
INSERT INTO KITS VALUES("Arsenal", "Away", "White", "Red", "White");
INSERT INTO KITS VALUES("Arsenal", "Alternate", "Blue", "Blue", "Blue");
INSERT INTO KITS VALUES("Aston Villa", "Home", "Red", "White", "Blue");
INSERT INTO KITS VALUES("Aston Villa", "Away", "Black", "Black", "Black");
INSERT INTO KITS VALUES("Aston Villa", "Alternate", "Grey", "Dark Blue", "White");
INSERT INTO KITS VALUES("Brighton", "Home", "Purple", "White", "Purple");
INSERT INTO KITS VALUES("Brighton", "Away", "Yellow", "Purple", "Yellow");
INSERT INTO KITS VALUES("Brighton", "Alternate", "Black", "Black", "Black");
INSERT INTO KITS VALUES("Chelsea", "Home", "Blue", "Blue", "White");
INSERT INTO KITS VALUES("Chelsea", "Away", "Grey", "Grey", "Black");
INSERT INTO KITS VALUES("Chelsea", "Alternate", "Orange", "Orange", "Blue");
INSERT INTO KITS VALUES("Crystal Palace", "Home", "Blue", "Blue", "Blue");
INSERT INTO KITS VALUES("Crystal Palace", "Away", "White", "White", "White");
INSERT INTO KITS VALUES("Crystal Palace", "Alternate", "Black", "Black", "Black");
INSERT INTO KITS VALUES("Everton", "Home", "Blue", "White", "White");
INSERT INTO KITS VALUES("Everton", "Away", "Yellow", "Blue", "Yellow");
INSERT INTO KITS VALUES("Everton", "Alternate", "Green", "Black", "Green");
INSERT INTO KITS VALUES("Leeds United", "Home", "White", "White", "White");
INSERT INTO KITS VALUES("Leeds United", "Away", "Blue-Black", "Black", "Black");
INSERT INTO KITS VALUES("Leeds United", "Alternate", "red", "Red", "Red");
INSERT INTO KITS VALUES("Leicester City", "Home", "Blue", "Blue", "Blue");
INSERT INTO KITS VALUES("Leicester City", "Away", "White", "White", "White");
INSERT INTO KITS VALUES("Leicester City", "Alternate", "Maroon", "Maroon", "Maroon");
INSERT INTO KITS VALUES("Liverpool", "Home", "Red", "Red", "Red");
INSERT INTO KITS VALUES("Liverpool", "Away", "Cyan", "Cyan", "Cyan");
INSERT INTO KITS VALUES("Liverpool", "Alternate", "Black", "Black", "Black");
INSERT INTO KITS VALUES('Manchester City','Home','Light Blue','White','Light Blue');
INSERT INTO KITS VALUES('Manchester City','Away','Black','Black','Black');
INSERT INTO KITS VALUES('Manchester City','Alternate','White','Dark Blue','White');
INSERT INTO KITS VALUES('Manchester United','Home','Red','White','Black');
INSERT INTO KITS VALUES('Manchester United','Away','Black','Black','Black');
INSERT INTO KITS VALUES('Manchester United','Alternate','White-Black','Black','White');
INSERT INTO KITS VALUES('Newcastle','Home','White-Black','Black','Black');
INSERT INTO KITS VALUES('Newcastle','Away','Yellow','Yellow','Yellow');
INSERT INTO KITS VALUES('Newcastle','Alternate','Purple','Black','Black');
INSERT INTO KITS VALUES('Southampton','Home','Red-White','Black','Red-White');
INSERT INTO KITS VALUES('Southampton','Away','Dark Blue','Blue','Blue');
INSERT INTO KITS VALUES('Southampton','Alternate','White-Red','White','White-Red');
INSERT INTO KITS VALUES('Tottenham','Home','White-Dark Blue','Dark-Blue','White');
INSERT INTO KITS VALUES('Tottenham','Away','Green','Black','Black');
INSERT INTO KITS VALUES('Tottenham','Alternate','Yellow-Orange','Orange','Orange');
INSERT INTO KITS VALUES('West Ham','Home','Red-Light Blue','White','White');
INSERT INTO KITS VALUES('West Ham','Away','Light Blue-Red','Light Blue','Light Blue-Red');
INSERT INTO KITS VALUES('West Ham','Alternate','Black','Black','Black');

-- Inserting Stadiums

INSERT INTO STADIUMS VALUES('Anfield','Anfiled,Liverpool,Merseyside,England',-2.57,53.25,53394,1884);
INSERT INTO STADIUMS VALUES('Etihad Stadium','Etihad Campus, Manchester,England',-2.12,53.28,55017,1999);
INSERT INTO STADIUMS VALUES('Old Trafford','Sir Matt Busby Wat,Old Trafford,Greater Manchester,England',-2.17,53.27,74140,1909);
INSERT INTO STADIUMS VALUES("St. James' Park",'Newcastle upon Tyne',-1.37,54.58,52305,1892);
INSERT INTO STADIUMS VALUES("St. Mary's Stadium",'Britannia Rd. Southampton,England',-1.23,50.54,32384,2000);
INSERT INTO STADIUMS VALUES('Tottenham Hotspur Stadium','Tottenham, London',-0.03,51.36,62303,2019);
INSERT INTO STADIUMS VALUES('London Stadium','Queen Elizabeth Olympic Park, Stratford, London',-0.01,51.32,60000,2008);
INSERT INTO STADIUMS VALUES('Emirates Stadium','Highbury House, 75 Drayton Park,Highbury, London',-6.22,51.33,60704,2004);
INSERT INTO STADIUMS VALUES('Villa Park','Trinity Road, Birmingham',-1.53,52.30,42749,1897);
INSERT INTO STADIUMS VALUES('Amex Stadium','Falmer, Brighton, East Sussex',-0.4,42.56,30750,2008);
INSERT INTO STADIUMS VALUES('Stamford Bridge','Fulham, London',-0.11,51.28,40834,1876);
INSERT INTO STADIUMS VALUES('Selhurst Park','Selhurst, London',-0.58,51.23,25496,1922);
INSERT INTO STADIUMS VALUES('Goodison Park','Goodison Road Walton, Liverpool',-2.57,53.26,39414,1892);
INSERT INTO STADIUMS VALUES('Elland Road','Elland Road, Beeston, Leeds',-1.34,53.46,37792,1897);
INSERT INTO STADIUMS VALUES('King Power Stadium','Filbert Way, Leicester',-1.8,52.37,32261,2002);


-- Linking Stadiums to Clubs

INSERT INTO `CLUB-STADIUM` VALUES('Liverpool','Anfield');
INSERT INTO `CLUB-STADIUM` VALUES('Manchester City','Etihad Stadium');
INSERT INTO `CLUB-STADIUM` VALUES('Manchester United','Old Trafford');
INSERT INTO `CLUB-STADIUM` VALUES('Newcastle',"St. James' Park");
INSERT INTO `CLUB-STADIUM` VALUES('Southampton',"St. Mary's Stadium");
INSERT INTO `CLUB-STADIUM` VALUES('Tottenham','Tottenham Hotspur Stadium');
INSERT INTO `CLUB-STADIUM` VALUES('West Ham','London Stadium');
INSERT INTO `CLUB-STADIUM` VALUES ('Arsenal', 'Emirates Stadium');
INSERT INTO `CLUB-STADIUM` VALUES ('Aston Villa', 'Villa Park');
INSERT INTO `CLUB-STADIUM` VALUES ('Brighton', 'Amex Stadium');
INSERT INTO `CLUB-STADIUM` VALUES ('Chelsea', 'Stamford Bridge');
INSERT INTO `CLUB-STADIUM` VALUES ('Crystal Palace', 'Selhurst Park');
INSERT INTO `CLUB-STADIUM` VALUES ('Everton', 'Goodison Park');
INSERT INTO `CLUB-STADIUM` VALUES ('Leeds United', 'Elland Road');
INSERT INTO `CLUB-STADIUM` VALUES ('Leicester City', 'King Power Stadium');

-- Inserting Fixture

INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Aston Villa","Arsenal");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Brighton","Aston Villa");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Chelsea","Brighton");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Crystal Palace","Chelsea");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Everton","Crystal Palace");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Leeds United","Everton");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Leicester City","Leeds United");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Liverpool","Leicester City");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Manchester City","Liverpool");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Manchester United","Manchester City");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Newcastle","Manchester United");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Southampton","Newcastle");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Tottenham","Southampton");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("West Ham","Tottenham");
INSERT INTO FIXTURES (`Home Club`,`Away Club`) VALUES("Arsenal","West Ham");
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Arsenal', 'Aston Villa');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Aston Villa', 'Brighton');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Brighton', 'Chelsea');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Chelsea', 'Crystal Palace');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Crystal Palace', 'Everton');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Everton', 'Leeds United');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Leeds United', 'Leicester City');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Leicester City', "Liverpool");
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES("Liverpool", 'Manchester City');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Manchester City', 'Manchester United');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Manchester United', 'Newcastle');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Newcastle', 'Southampton');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Southampton', 'Tottenham');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('Tottenham', 'West Ham');
INSERT INTO FIXTURES (`Home Club`, `Away Club`) VALUES('West Ham', 'Arsenal');

-- Inserting Matches

INSERT INTO MATCHES VALUES(18,'2020-09-15 00:45:00',1,3);
INSERT INTO MATCHES VALUES(19,'2020-10-03 17:00:00',4,0);
INSERT INTO MATCHES VALUES(20,'2020-09-26 19:30:00',1,2);
INSERT INTO MATCHES VALUES(28,'2020-09-20 16:30:00',2,5);
INSERT INTO MATCHES VALUES(15,'2020-09-20 00:30:00',2,1);

-- Inserting Alternate Names

INSERT INTO `ALTERNATE NAMES` VALUES("The Foxes", "Leicester City");
INSERT INTO `ALTERNATE NAMES` VALUES("The Reds", "Liverpool");
INSERT INTO `ALTERNATE NAMES` VALUES("The Toffees", "Everton");
INSERT INTO `ALTERNATE NAMES` VALUES("The Villa", "Aston Villa");
INSERT INTO `ALTERNATE NAMES` VALUES("The Gunners", "Arsenal");
INSERT INTO `ALTERNATE NAMES` VALUES("The Eagles", "Crystal Palace");
INSERT INTO `ALTERNATE NAMES` VALUES("The Peacocks", "Leeds United");
INSERT INTO `ALTERNATE NAMES` VALUES("Spurs", "Tottenham");
INSERT INTO `ALTERNATE NAMES` VALUES("The Blues", "Chelsea");
INSERT INTO `ALTERNATE NAMES` VALUES("The Magpies", "Newcastle");
INSERT INTO `ALTERNATE NAMES` VALUES("The Hammers", "West Ham");
INSERT INTO `ALTERNATE NAMES` VALUES("The Seagulls", "Brighton");
INSERT INTO `ALTERNATE NAMES` VALUES("The Citizens", "Manchester City");
INSERT INTO `ALTERNATE NAMES` VALUES("The Red Devils", "Manchester United");
INSERT INTO `ALTERNATE NAMES` VALUES("The Comeback Kings", "Manchester United");
INSERT INTO `ALTERNATE NAMES` VALUES("The Saints", "Southampton");