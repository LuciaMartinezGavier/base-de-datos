-------------------------------------------------------------------------
-------------------- QUERIES ANIDADAS Y AGREGACIONES --------------------
-------------------------------------------------------------------------
-- Listar el nombre de la ciudad y el nombre del país de todas las
-- ciudades que pertenezcan a países con una población menor a 10000 habitantes.
SELECT unpopulated_countries.Name, city.Name, unpopulated_countries.Population
FROM (SELECT *
      FROM country
      WHERE Population < 10000
     ) unpopulated_countries
INNER JOIN city
WHERE city.CountryCode=unpopulated_countries.Code
ORDER BY Population;

-- Listar todas aquellas ciudades cuya población sea mayor que la
-- población promedio entre todas las ciudades.
WITH 
    avg_population (value) AS (
        SELECT avg(Population)
        FROM city
    )
SELECT city.Name, city.Population
FROM city, avg_population
WHERE Population > avg_population.value
ORDER BY Population;

-- Listar todas aquellas ciudades no asiáticas cuya población sea igual o mayor
-- a la población total de algún país de Asia. (286000)
SELECT city.Name, city.Population, country.Name
FROM city INNER JOIN country ON city.CountryCode = country.Code
WHERE city.Population >= SOME (
    SELECT Population 
    FROM country
    WHERE Continent = 'Asia'
) AND country.Continent != 'Asia'
ORDER BY Population;

-- Listar aquellos países junto a sus idiomas no oficiales, que superen en
-- porcentaje de hablantes a cada uno de los idiomas oficiales del país.
SELECT country.Name, c1.Language, c1.Percentage
FROM country
INNER JOIN countrylanguage c1 ON country.Code = c1.CountryCode 
WHERE c1.IsOfficial = 'F'
AND c1.Percentage > ALL (
    SELECT c2.Percentage
    FROM countrylanguage c2
    WHERE c2.IsOfficial='T' AND c1.CountryCode = c2.CountryCode
)
ORDER BY c1.Percentage;


-- Listar (sin duplicados) aquellas regiones que tengan países con una
-- superficie menor a 1000 km2 y exista (en el país) al menos una ciudad con
-- más de 100000 habitantes. (Hint: Esto puede resolverse con o sin una
-- subquery, intenten encontrar ambas respuestas).
SELECT DISTINCT country.Region, country.Name
FROM country INNER JOIN city ON country.Code = city.CountryCode
WHERE SurfaceArea < 1000 AND city.Population > 100000

-- Listar el nombre de cada país con la cantidad de habitantes de su ciudad
-- más poblada. (Hint: Hay dos maneras de llegar al mismo resultado. Usando
-- consultas escalares o usando agrupaciones, encontrar ambas).
SELECT country.Name, max(city.Population) as Population
FROM country INNER JOIN city ON country.Code = city.CountryCode
GROUP BY country.Code;
-- TODO: falta usando consultas escalares.

-- Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje de
-- hablantes sea mayor al promedio de hablantes de los lenguajes oficiales.
WITH 
    avg_percentage (value) AS (
        SELECT avg(countrylanguage.Percentage)
        FROM countrylanguage INNER JOIN country
        ON country.code = countrylanguage.CountryCode
        WHERE countrylanguage.IsOfficial = 'T'
    )
SELECT country.Name, countrylanguage.Language, countrylanguage.CountryCode
FROM avg_percentage, country INNER JOIN countrylanguage
ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Percentage > avg_percentage.value
      AND countrylanguage.IsOfficial = 'F';


-- Listar la cantidad de habitantes por continente ordenado en forma
-- descendiente.
SELECT sum(Population)
FROM country
GROUP BY country.Continent
ORDER BY Population DESC

-- Listar el promedio de esperanza de vida (LifeExpectancy) por continente
-- con una esperanza de vida entre 40 y 70 años. (es ambiguo el enunciado,
-- planteo las dos opciones)

SELECT country.continent, avg(country.LifeExpectancy)
FROM country
GROUP BY country.Continent
HAVING LifeExpectancy > 40 AND LifeExpectancy < 70

SELECT country.continent, avg(country.LifeExpectancy)
FROM country
WHERE country.LifeExpectancy > 40
AND country.LifeExpectancy < 70
GROUP BY country.Continent;


-- Listar la cantidad máxima, mínima, promedio y suma de habitantes por
-- continente
SELECT max(cont_tmp.population),
       min(cont_tmp.population),
       avg(cont_tmp.population),
       sum(cont_tmp.population)
FROM (
    SELECT sum(country.Population) AS 'Population', coutry.Continent
    FROM country
    GROUP BY Continent
) continent_population
