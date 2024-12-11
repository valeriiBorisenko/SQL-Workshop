/* 
SQL Join query exercise

World database layout:
To use this database from a default MySQL install, type: use world;

Table: City
Columns: Id, Name, CountryCode, District, Population

Table: Country
Columns: Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, Capital

Table: CountryLanguage
Columns: CountryCode, Language, IsOfficial, Percentage
*/

USE world;
-- 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT name FROM city WHERE name LIKE 'ping%' ORDER BY population ASC;

-- 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT name FROM city WHERE name LIKE 'ping%' ORDER BY population DESC;

-- 3: Count all cities
SELECT COUNT(*) FROM city;

-- 4: Get the average population of all cities
SELECT AVG(population) FROM city;

-- 5: Get the biggest population found in any of the cities
SELECT MAX(population) FROM city;

-- 6: Get the smallest population found in any of the cities
SELECT MIN(population) FROM city;

-- 7: Sum the population of all cities with a population below 10000
SELECT SUM(population) FROM city WHERE population < 10000;

-- 8: Count the cities with the country codes MOZ and VNM
SELECT COUNT(*) FROM city WHERE countrycode IN("MOZ","VNM");

-- 9: Get individual count of cities for the country codes MOZ and VNM
SELECT COUNT(*) FROM city GROUP BY countrycode HAVING countrycode IN("MOZ","VNM");

-- 10: Get average population of cities in MOZ and VNM
SELECT AVG(population) FROM city WHERE countrycode IN("MOZ","VNM");

-- 11: Get the country codes with more than 200 cities
SELECT countrycode FROM city GROUP BY countrycode having count(*) > 200;

-- 12: Get the country codes with more than 200 cities ordered by city count
SELECT countrycode, count(*) as cnt FROM city GROUP BY countrycode having cnt > 200 ORDER BY cnt;

-- 13: What language(s) is spoken in the city with a population between 400 and 500?
SELECT language FROM countrylanguage INNER JOIN city ON countrylanguage.CountryCode = city.CountryCode WHERE city.Population BETWEEN 400 and 500; 

-- 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT name, language FROM countrylanguage INNER JOIN city ON countrylanguage.CountryCode = city.CountryCode WHERE city.Population BETWEEN 500 and 600;

-- 15: What names of the cities are in the same country as the city with a population of 122199 (including that city itself)
SELECT c1.name FROM city c1 INNER JOIN city c2 ON c1.CountryCode = c2.CountryCode WHERE c2.population = 122199;

-- 16: What names of the cities are in the same country as the city with a population of 122199 (excluding that city itself)
SELECT c1.name FROM city c1 INNER JOIN city c2 ON c1.CountryCode = c2.CountryCode WHERE c2.population = 122199 AND c1.name != c2.name;

-- 17: What are the city names in the country where Luanda is the capital?
SELECT city.name FROM city INNER JOIN country ON city.CountryCode = country.Code WHERE country.Capital = (SELECT id FROM city WHERE name = "Luanda");
SELECT name FROM city WHERE CountryCode = (SELECT code FROM country WHERE capital = (SELECT id FROM city WHERE name = "Luanda"));

-- 18: What are the names of the capital cities in countries in the same region as the city named Yaren
SELECT city.name FROM city INNER JOIN country ON city.id = country.capital WHERE country.region = (SELECT region FROM country WHERE capital = (SELECT id FROM city WHERE name = "Yaren"));

-- 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT language FROM countrylanguage INNER JOIN country 
ON countrylanguage.CountryCode = country.Code 
WHERE country.region = (SELECT region FROM country INNER JOIN city ON city.id = country.capital WHERE city.name = "Riga");

-- 20: Get the name of the most populous city
SELECT name FROM city ORDER BY population DESC LIMIT 1;

