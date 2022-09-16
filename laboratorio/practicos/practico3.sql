-------------------------------------------------------------------
-------------------- QUERIES: JOINS Y CONJUNTOS -------------------
-------------------------------------------------------------------

--  Listar el nombre de la ciudad, nombre del país, región y forma
-- de gobierno de las 10 ciudades más pobladas del mundo. 
SELECT most_populated_city.Name AS 'City', country.Name AS 'Country',
       country.Region, country.GovernmentForm
FROM (SELECT *
      FROM city
      ORDER BY Population DESC
      LIMIT 10
     ) most_populated_city
INNER JOIN country
WHERE country.Code=most_populated_city.CountryCode;

-- Listar los 10 países con menor población del mundo, junto a sus
-- ciudades capitales (Hint: puede que uno de estos países no 
-- tenga ciudad capital asignada, en este caso deberá mostrar "NULL").
SELECT less_populated_country.Name AS 'Country',  city.Name AS 'City'
FROM ( SELECT *
       FROM country
       ORDER BY Population
       LIMIT 10
     ) less_populated_country
LEFT JOIN city
ON (city.ID = less_populated_country.Capital);

-- Listar el nombre, continente y todos los lenguajes oficiales de
-- cada país. (Hint: habrá más de una fila por país si tiene varios
-- idiomas oficiales).
SELECT country.Name AS 'Country', country.Continent, language.Language
FROM (SELECT Language, CountryCode FROM countrylanguage
      WHERE countrylanguage.IsOfficial = 'T'
     ) language
INNER JOIN country
ON (country.Code = language.CountryCode);


-- Listar el nombre del país y nombre de capital, de los 20 países 
-- con mayor superficie del mundo.
SELECT pupulated_country.Name AS 'Country', city.Name AS 'City'
FROM ( SELECT * FROM country
       ORDER BY SurfaceArea DESC
       LIMIT 20
     ) pupulated_country
INNER JOIN city
ON (pupulated_country.Capital = city.ID);

-- Listar las ciudades junto a sus idiomas oficiales (ordenado por
-- la población de la ciudad) y el porcentaje de hablantes del idioma.
SELECT city.Name, countrylanguageof.Language, countrylanguageof.Percentage
FROM city LEFT JOIN (
    SELECT * FROM countrylanguage
    WHERE IsOfficial = 'T'
) countrylanguageof
ON (countrylanguageof.CountryCode = city.CountryCode)
ORDER BY city.Population;

-- Listar los 10 países con mayor población y los 10 países con menor
-- población (que tengan al menos 100 habitantes) en la misma consulta.
SELECT Top AS 'Rank', Name AS 'Country'
FROM(
    (SELECT 'Top', Name, Population
     FROM city
     ORDER BY Population DESC
     LIMIT 10
    ) UNION (
     SELECT 'Bottom', Name, Population
     FROM city
     ORDER BY Population
     LIMIT 10
    )
) ranking
ORDER BY Population DESC;

-- Listar aquellos países cuyos lenguajes oficiales son el Inglés y el
-- Francés (hint: no debería haber filas duplicadas).
SELECT country.Name AS 'Country' FROM
(
    SELECT DISTINCT CountryCode FROM
    (
        SELECT CountryCode
        FROM countrylanguage
        WHERE (Language='English' AND IsOfficial = 'T')
    ) english_speakers
    INNER JOIN
    (
        SELECT CountryCode
        FROM countrylanguage
        WHERE (Language = 'French' AND IsOfficial = 'T')
    ) french_speakers
    USING(CountryCode)
) country_ef
INNER JOIN country
ON (country.Code = country_ef.CountryCode);



-- Listar aquellos países que tengan hablantes del Inglés pero no del
-- Español en su población.

(
    SELECT country.Name
    FROM country 
    INNER JOIN countrylanguage
    ON country.Code = countrylanguage.CountryCode
    WHERE countrylanguage.Language = "English"
)
EXCEPT 
(
    SELECT country.Name
    FROM country 
    INNER JOIN countrylanguage
    ON country.Code = countrylanguage.CountryCode
    WHERE countrylanguage.Language = "Spanish"
)



SELECT tmp.Name, tmp.language
FROM 
    (SELECT co.name as "Name", cl.language as "language"
    FROM country co INNER JOIN countrylanguage cl 
    ON co.code = cl.countrycode and cl.language = "English") as tmp
WHERE tmp.language != "French";