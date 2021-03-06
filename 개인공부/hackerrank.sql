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

-- Japanese Cities' Attributes
-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Type of Triangle
-- Write a query identifying the type of each record in the TRIANGLES table using its three side lengths.
-- 삼각형 성립 조건 두 길이의 합이 가장 큰 길이보다 커야함 (같아도 안됨)
SELECT 
    CASE
        WHEN A + B <= C THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR C = A THEN 'Isosceles'
        ELSE 'Scalene'
    END RESULT
FROM TRIANGLES;

-- Revising Aggregations - The Count Function
-- Query a count of the number of cities in CITY having a Population larger than 100,000.
SELECT COUNT(*) FROM CITY WHERE POPULATION > 100000;

-- Revising Aggregations - The Sum Function
-- Query the total population of all cities in CITY where District is California.
SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT = 'California';

-- Revising Aggregations - Averages
-- Query the average population of all cities in CITY where District is California.
SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT = 'California';

-- Average Population
-- Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT ROUND(AVG(POPULATION)) FROM CITY;

-- Japan Population
-- Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
SELECT SUM(POPULATION) FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Population Density Difference
-- Query the difference between the maximum and minimum populations in CITY.
SELECT 
    A.POPULATION - B.POPULATION
FROM 
    (SELECT * FROM CITY ORDER BY POPULATION DESC) A
    , (SELECT * FROM CITY ORDER BY POPULATION ASC) B
WHERE ROWNUM = 1;

SELECT MAX(Population) - MIN(Population) AS Joke FROM City; -- MIN MAX 함수도 있음 잘 써먹자

-- The Blunder
-- finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
-- Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), and round it up to the next integer.
-- round up 무조건 올림 (ceil), round가 반올림, round down이 내림 (floor)
SELECT CEIL(AVG(Salary)-AVG(REPLACE(Salary,'0',''))) FROM EMPLOYEES;

-- Top Earners
-- total earnings = salary x months
-- Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
-- Then print these values as 2 space-separated integers.
SELECT
    *
FROM 
    (
        SELECT 
            salary * months, COUNT(*) 
        FROM Employee 
        GROUP BY salary * months 
        ORDER BY salary * months DESC
    )
WHERE ROWNUM = 1;

-- Weather Observation Station 2
-- Query the following two values from the STATION table:
-- The sum of all values in LAT_N rounded to a scale of 2 decimal places.
-- The sum of all values in LONG_W rounded to a scale of 2 decimal places.
-- 2 decimal places 소수점 자리 2째 자리
-- decimal places 소수점
SELECT ROUND(SUM(LAT_N), 2), ROUND(SUM(LONG_W), 2) FROM STATION;

-- Weather Observation Station 13
-- Query the sum of Northern Latitudes (LAT_N) from STATION 
-- having values greater than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places.
SELECT 
    TRUNC(SUM(LAT_N), 4) 
FROM STATION 
WHERE 1=1
AND LAT_N > 38.7880
AND LAT_N < 137.2345;

-- Weather Observation Station 14
-- Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.
SELECT TRUNC(MAX(LAT_N), 4) FROM STATION WHERE LAT_N < 137.2345;

-- Weather Observation Station 15
-- Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places.
SELECT 
    ROUND(LONG_W, 4) 
FROM 
    (  
        SELECT * FROM STATION WHERE LAT_N < 137.2345 ORDER BY LAT_N DESC
    )
WHERE ROWNUM = 1;

SELECT 
    ROUND(LONG_W, 4)
FROM STATION
WHERE 1=1
AND LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N < 137.2345);

-- Weather Observation Station 16
-- Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places.
SELECT ROUND(MIN(LAT_N), 4) FROM STATION WHERE LAT_N > 38.7780;

-- Weather Observation Station 17
-- Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places.
SELECT 
    ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION WHERE LAT_N > 38.7780);

-- Population Census
-- query the sum of the populations of all cities where the CONTINENT is 'Asia'
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
SELECT 
    SUM(CITY.POPULATION)
FROM CITY, COUNTRY
WHERE CITY.COUNTRYCODE = COUNTRY.CODE
AND COUNTRY.CONTINENT = 'Asia';

-- African Cities
-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
SELECT 
    CITY.NAME
FROM CITY, COUNTRY
WHERE CITY.COUNTRYCODE = COUNTRY.CODE
AND COUNTRY.CONTINENT = 'Africa';

-- Average Population of Each Continent
-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) 
-- and their respective average city populations (CITY.Population) rounded down to the nearest integer.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
SELECT
    B.CONTINENT
    , FLOOR(AVG(A.POPULATION)) AVG
FROM CITY A, COUNTRY B
WHERE A.COUNTRYCODE = B.CODE
GROUP BY B.CONTINENT;

-- Draw The Triangle1
-- 별찍기 5 4 3 2 1 순으로 P(5)면 5개 P(20) 찍기
set serveroutput on
declare
a number := 20;
begin
for i in reverse 1..a
loop
dbms_output.put_line(RPAD('* ', (i*2), '* '));
end loop;
end;
/
-- 참고 ORACLE DB 에는 PL/SQL이라고 해서 프로그래밍언어 역할을 하는게 있음 변수를 만들고 반복문 등을 수행할 수 있음

-- Draw The Triangle 2
-- 별찍기 1 2 3 4 5 순으로 P(5)면 5개 P(20) 찍기
SET serveroutput ON
DECLARE
    a number := 20;
BEGIN
    FOR i IN 1..a
    LOOP
        dbms_output.put_line(RPAD('* ', (i*2), '* '));
    END LOOP;
END;
/

-- The PADS
-- OCCUPATIONS 알파벳 첫단어 순으로 정렬되어 있음 그렇게 AnActorName(A) 이런 형식으로 출력하기
-- There are a total of [occupation_count] [occupation]s. 오름차순으로
SELECT
    Name || '(' || SUBSTR(Occupation, 1, 1) || ')'
FROM OCCUPATIONS
ORDER BY NAME ASC;

--SELECT 'There are a total of ' || COUNT(*) || ' doctors.' TOTAL
--FROM OCCUPATIONS
--WHERE Occupation = 'Doctor';
--SELECT 'There are a total of ' || COUNT(*) || ' actors.' TOTAL
--FROM OCCUPATIONS
--WHERE Occupation = 'Actor';
--SELECT 'There are a total of ' || COUNT(*) || ' singers.' TOTAL
--FROM OCCUPATIONS
--WHERE Occupation = 'Singer';
--SELECT 'There are a total of ' || COUNT(*) || ' professors.' TOTAL
--FROM OCCUPATIONS
--WHERE Occupation = 'Professor';
SELECT 'There are a total of ' || COUNT(Occupation) || ' ' || LOWER(Occupation) || 's.' as total
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY total;

-- Occupations
-- 직업별로 열로 나올 수 잇게 출력 (이름순)
-- SELECT Occupation, COUNT(*) FROM OCCUPATIONS GROUP BY Occupation;

--SELECT
--    D.Name
--    , P.Name
--    , S.Name
--    , A.Name
--FROM 
--    (
--        SELECT ROW_NUMBER() OVER (ORDER BY Name) NUM, Name FROM OCCUPATIONS WHERE Occupation = 'Doctor'
--    ) D,
--    (
--        SELECT ROW_NUMBER() OVER (ORDER BY Name) NUM, Name FROM OCCUPATIONS WHERE Occupation = 'Professor'
--    ) P,
--    (
--        SELECT ROW_NUMBER() OVER (ORDER BY Name) NUM, Name FROM OCCUPATIONS WHERE Occupation = 'Singer'
--    ) S,
--    (
--        SELECT ROW_NUMBER() OVER (ORDER BY Name) NUM, Name FROM OCCUPATIONS WHERE Occupation = 'Actor' ORDER BY 2
--    ) A
--WHERE 1=1
--AND P.NUM = D.NUM(+)
--AND P.NUM = S.NUM(+)
--AND P.NUM = A.NUM(+);

-- 분석함수 이용
select min(Doctor), min(Professor), min(Singer), min(Actor)
from
(Select  RANK() OVER(PARTITION BY occupation ORDER BY name) rank,
    case OCCUPATION when 'Doctor' then NAME end AS Doctor,
    case OCCUPATION when 'Professor' then NAME end AS Professor,
    case OCCUPATION when 'Singer' then NAME end AS Singer,
    case OCCUPATION when 'Actor' then NAME end AS Actor
from occupations)
group by rank
order by rank;

-- pivot 이용
select doctor,professor,singer,actor 
from (
        select * 
        from 
        (
            select 
            Name, 
            occupation, 
            (ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name)) as row_num 
            from occupations order by name asc
        ) 
        pivot 
        ( 
            min(name) for occupation in 
            ('Doctor' as doctor,'Professor' as professor,'Singer' as singer,'Actor' as actor)
        ) 
        order by row_num
    );
    

-- New Companies
-- conglomerate corporation - 대기업
-- Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, 
-- total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

SELECT
    C.company_code
    , C.founder
    , COUNT(*)
    , L.NUM
    , S.NUM
    , M.NUM
FROM Company C
JOIN (
        SELECT
            company_code
            , COUNT(*) NUM
        FROM Lead_Manager
        GROUP BY company_code
    ) L ON C.company_code = L.company_code
JOIN (
        SELECT
            company_code
            , COUNT(*) NUM
        FROM Senior_Manager
        GROUP BY company_code
    ) S ON C.company_code = S.company_code
JOIN (
        SELECT
            company_code
            , COUNT(*) NUM
        FROM Manager
        GROUP BY company_code
    ) M ON C.company_code = M.company_code
GROUP BY C.company_code, C.founder, L.NUM, S.NUM, M.NUM
ORDER BY C.company_code;

-- 이게 맞는거 같음
SELECT
    C.company_code
    , C.founder
    , COUNT(DISTINCT L.lead_manager_code)
    , COUNT(DISTINCT S.senior_manager_code)
    , COUNT(DISTINCT M.manager_code)
    , COUNT(DISTINCT E.employee_code)
FROM Company C
JOIN Lead_Manager L ON C.company_code = L.company_code
JOIN Senior_Manager S ON L.lead_manager_code = S.lead_manager_code
JOIN Manager M ON S.senior_manager_code= M.senior_manager_code
JOIN Employee E ON M.manager_code = E.manager_code
GROUP  BY C.company_code, C.founder
ORDER BY 1;