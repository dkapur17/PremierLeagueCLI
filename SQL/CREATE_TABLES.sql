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
  `Longitude` decimal,
  `Latitude` decimal,
  `Capacity` INT DEFAULT 100000,
  `Broke Ground` DATE
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
CREATE TABLE `MATCHES` (
  `Match ID` INT AUTO_INCREMENT PRIMARY KEY,
  `Match Date` DATE,
  `Start Time` INT,
  `Home Team Score` INT,
  `Away Team Score` INT
);
CREATE TABLE `CLUB-STADIUM` (
  `Club Name` VARCHAR(255) PRIMARY KEY,
  `Stadium Name` VARCHAR(255),
  FOREIGN KEY (`Stadium Name`) REFERENCES `STADIUMS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Club Name`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE `FIXTURE` (
  `Match ID` INT PRIMARY KEY,
  `Home Club` VARCHAR(255),
  `Away Club` VARCHAR(255),
  `Home Club Kit` ENUM ('Home', 'Away', 'Alternate'),
  `Away Club Kit` ENUM ('Home', 'Away', 'Alternate'),
  FOREIGN KEY (`Home Club`) REFERENCES `CLUB-STADIUM` (`Club Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Match ID`) REFERENCES `MATCHES` (`Match ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Home Club`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Away Club`) REFERENCES `CLUBS` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Home Club`, `Home Club Kit`) REFERENCES `KITS` (`Club Name`, `Type`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`Away Club`, `Away Club Kit`) REFERENCES `KITS` (`Club Name`, `Type`) ON DELETE CASCADE ON UPDATE CASCADE
);