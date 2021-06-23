-- Revising the Select Query 1
-- Revising 수정
-- Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
SELECT * FROM CITY WHERE CountryCode = 'USA' AND POPULATION > 100000;

-- Revising the Select Query 2
-- Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
SELECT NAME FROM CITY WHERE POPULATION > 120000 AND CountryCode = 'USA';

-- Select All
-- Query all columns (attributes) for every row in the CITY table.
SELECT * FROM CITY;

-- Select By ID
-- Query all columns for a city in CITY with the ID 1661.
Select * FROM CITY WHERE ID = 1661;

-- Japanese Cities' Names
-- Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Weather Observation Station 1
-- Query a list of CITY and STATE from the STATION table.
SELECT CITY, STATE FROM STATION;

-- Weather Observation Station 3
-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT CITY FROM STATION WHERE MOD(ID, 2) = 0;

-- Weather Observation Station 4
-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;

-- Weather Observation Station 5
-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). 
-- If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
SELECT * FROM (SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) ASC, CITY ASC) WHERE ROWNUM = 1;
SELECT * FROM (SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY ASC) WHERE ROWNUM = 1;

-- Weather Observation Station 6
-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION 
WHERE 1=1
AND LOWER(CITY) LIKE 'a%'
OR LOWER(CITY) LIKE 'e%'
OR LOWER(CITY) LIKE 'i%'
OR LOWER(CITY) LIKE 'o%'
OR LOWER(CITY) LIKE 'u%';

-- Weather Observation Station 7
-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION 
WHERE 1=1
AND LOWER(CITY) LIKE '%a'
OR LOWER(CITY) LIKE '%e'
OR LOWER(CITY) LIKE '%i'
OR LOWER(CITY) LIKE '%o'
OR LOWER(CITY) LIKE '%u';

-- Weather Observation Station 8
-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) 
-- as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION 
WHERE 1=1
AND (LOWER(CITY) LIKE 'a%'
OR LOWER(CITY) LIKE 'e%'
OR LOWER(CITY) LIKE 'i%'
OR LOWER(CITY) LIKE 'o%'
OR LOWER(CITY) LIKE 'u%') 
AND (LOWER(CITY) LIKE '%a'
OR LOWER(CITY) LIKE '%e'
OR LOWER(CITY) LIKE '%i'
OR LOWER(CITY) LIKE '%o'
OR LOWER(CITY) LIKE '%u');

SELECT DISTINCT CITY FROM STATION
WHERE SUBSTR(LOWER(CITY), 1, 1) IN ('a','e','i','o','u')
AND SUBSTR(LOWER(CITY), -1, 1) IN ('a','e','i','o','u');

-- Weather Observation Station 9
-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION
WHERE SUBSTR(LOWER(CITY), 1, 1) NOT IN ('a','e','i','o','u');

-- Weather Observation Station 10
-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION
WHERE SUBSTR(LOWER(CITY), -1, 1) NOT IN ('a','e','i','o','u');

-- Weather Observation Station 11
-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION
WHERE SUBSTR(LOWER(CITY), 1, 1) NOT IN ('a','e','i','o','u')
OR SUBSTR(LOWER(CITY), -1, 1) NOT IN ('a','e','i','o','u');

-- Weather Observation Station 12
-- Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY FROM STATION
WHERE SUBSTR(LOWER(CITY), 1, 1) NOT IN ('a','e','i','o','u')
AND SUBSTR(LOWER(CITY), -1, 1) NOT IN ('a','e','i','o','u');

-- Higher Than 75 Marks
-- Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. 
-- If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT NAME FROM STUDENTS 
WHERE MARKS > 75
ORDER BY SUBSTR(NAME, -3, 3) ASC, ID ASC;

-- Employee Names
-- Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
SELECT name FROM Employee ORDER BY name asc;

-- Employee Salaries
-- Write a query that prints a list of employee names (i.e.: the name attribute) 
-- for employees in Employee having a salary greater than 2000 per month who have been employees for less than 10 months. 
-- Sort your result by ascending employee_id.
SELECT name FROM Employee WHERE salary > 2000 and months < 10 ORDER BY employee_id;