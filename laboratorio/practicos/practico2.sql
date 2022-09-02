-----------------------------------------------------------
------------- Data Definition Language (DDL) --------------
-----------------------------------------------------------

-- Tables creation

CREATE TABLE country (
    Code char(3) NOT NULL,
    Name varchar(255) NOT NULL,
    Continent varchar(255),
    Region varchar(255),
    SurfaceArea float(2),
    IndepYear int,
    Population int,
    LifeExpectancy float(1),
    GNP float(2),
    GNPOld float(2),
    LocalName varchar(255),
    GovernmentForm varchar(255),
    HeadOfState varchar(255),
    Capital int,
    Code2 varchar(2),

    PRIMARY KEY (Code)
);


CREATE TABLE city (
    ID int NOT NULL,

    Name varchar(255),
    CountryCode varchar(3),
    District varchar(255),
    Population int,
    
    PRIMARY KEY (ID),
    FOREIGN KEY (CountryCode) REFERENCES country(Code)
);

CREATE TABLE countrylanguage (
    CountryCode char(3) NOT NULL,
    Language varchar(255) NOT NULL,
    IsOfficial char(1),
    Percentage float(1),

    PRIMARY KEY (CountryCode, Language),
    FOREIGN KEY (CountryCode) REFERENCES country(Code)
);


CREATE TABLE Continent (
    Name varchar(255) NOT NULL,
    Area int,
    PercentTotalMass real,
    MostPopulousCity varchar(255),

    PRIMARY KEY (Name)
);

-- Insert data into table Contintent and add city McMurdo Station
INSERT INTO city VALUES (4080, 'McMurdo Station', 'USA', 'Ross Island', 1258);
INSERT INTO Continent VALUES ('Africa', 30370000, 20.4, 'Cairo, Egypt');
INSERT INTO Continent VALUES ('Antarctica', 14000000, 9.2, 'McMurdo Station');
INSERT INTO Continent VALUES ('Asia', 44579000, 29.5, 'Mumbai, India');
INSERT INTO Continent VALUES ('Europe', 10180000, 6.8, 'Instanbul, Turquia');
INSERT INTO Continent VALUES ('North America', 24709000, 16.5, 'Ciudad de México, Mexico');
INSERT INTO Continent VALUES ('Oceania', 8600000, 5.9, 'Sydney, Australia');
INSERT INTO Continent VALUES ('South America', 17840000, 12.0, 'São Paulo, Brazil');

-- Set Foreign key Continent in table country
ALTER TABLE country
ADD FOREIGN KEY (Continent) REFERENCES Continent(Name);

--------------------------------------------------------
----------- Data Manipulation Language (DML) -----------
--------------------------------------------------------

-- Devolver una lista de los nombres y las regiones a
-- las que pertenece cada país ordenada alfabéticamente.
SELECT Name, Region
FROM country
ORDER BY Name;

-- Listar el nombre y la población de las 10 ciudades más
-- pobladas del mundo.

SELECT Name, Population
FROM city
ORDER BY Population DESC
LIMIT 10;

-- Listar el nombre, región, superficie y forma de gobierno de
-- los 10 países con menor superficie.

SELECT Name, Region, SurfaceArea, GovernmentForm
FROM country
ORDER BY SurfaceArea
LIMIT 10;

-- Listar todos los países que no tienen independencia (hint: ver
-- que define la independencia de un país en la BD).

SELECT Name
FROM country
WHERE IndepYear IS NULL;

-- Liste el nombre y el porcentaje de hablantes que tienen
-- todos los idiomas declarados oficiales.

SELECT Name, Percentage, Language, IsOfficial
FROM country, countrylanguage
WHERE (country.Code=countrylanguage.CountryCode AND
      countrylanguage.IsOfficial='T')
--????