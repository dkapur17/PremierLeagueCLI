-- Queries to insert the first 15 Clubs into the table
-- The last 5 will be used for testing the CLI
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
-- Query to display the table as it is done in the Premier League
SELECT `Name`,
    `W` + `L` + `D` AS `MP`,
    `W`,
    `L`,
    `D`,
    `GF`,
    `GA`,
    `GF` - `GA` AS `GD`,
    3 * `W` + `D` AS `Points`
FROM CLUBS
ORDER BY `Points` DESC,
    `GD` DESC,
    `GF` DESC;