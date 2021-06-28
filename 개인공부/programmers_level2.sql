-- 고양이와 개는 몇 마리 있을까
-- 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 이때 고양이를 개보다 먼저 조회해주세요.
SELECT ANIMAL_TYPE, COUNT(ANIMAL_TYPE) COUNT FROM ANIMAL_INS WHERE ANIMAL_TYPE IN('Cat', 'Dog') GROUP BY ANIMAL_TYPE ORDER BY ANIMAL_TYPE ASC;

-- 루시와 엘라 찾기
-- 동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요.
-- 이때 결과는 아이디 순으로 조회
SELECT 
    ANIMAL_ID
    , NAME
    , SEX_UPON_INTAKE 
FROM ANIMAL_INS 
WHERE NAME IN('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty') 
ORDER BY ANIMAL_ID ASC;

-- 동명 동물 수 찾기
-- 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
-- WHERE 절에는 COUNT() 함수를 사용할 수 없지만, HAVING 절에는 조건으로 사용 가능하다.
-- COUNT() 함수 내부에 DECODE 함수나 CASE문 등을 사용하여 건수를 집계 할 수 있다.
SELECT 
    NAME
    , COUNT(NAME) COUNT
FROM ANIMAL_INS
GROUP BY NAME
HAVING COUNT(NAME) >= 2
ORDER BY NAME ASC;

-- 최소값 구하기
-- 동물 보호소에 가장 먼저 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT * FROM (SELECT DATETIME 시간 FROM ANIMAL_INS ORDER BY DATETIME ASC) WHERE ROWNUM = 1;

-- 이름에 el이 들어가는 동물 찾기
-- 동물 보호소에 들어온 동물 이름 중, 이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.
-- 대소문자 구분 없이 조회하려면 LOWER나 UPPER로 다 소문자나 대문자로 만든 후 LIKE로 찾으면 됨
SELECT
    ANIMAL_ID
    , NAME
FROM ANIMAL_INS
WHERE 1=1
AND LOWER(NAME) LIKE '%el%'
AND ANIMAL_TYPE = 'Dog'
ORDER BY NAME ASC;

-- 동물 수 구하기
-- 동물 보호소에 동물이 몇 마리 들어왔는지 조회하는 SQL 문을 작성해주세요.
SELECT COUNT(*) FROM ANIMAL_INS;

-- 입양 시각 구하기(1)
-- 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.
/*
    HH24 24시간으로 표기
    fm 0빼기
*/
SELECT
    TO_CHAR(DATETIME, 'fmHH24') HOUR
    , COUNT(TO_CHAR(DATETIME, 'fmHH24')) COUNT
FROM ANIMAL_OUTS
GROUP BY TO_CHAR(DATETIME, 'fmHH24')
HAVING TO_NUMBER(TO_CHAR(DATETIME, 'fmHH24')) BETWEEN 9 AND 19
ORDER BY TO_NUMBER(TO_CHAR(DATETIME, 'fmHH24'));

-- NULL 처리하기
-- 동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 프로그래밍을 모르는 사람들은 NULL이라는 기호를 모르기 때문에, 이름이 없는 동물의 이름은 "No name"으로 표시해 주세요.
SELECT
    ANIMAL_TYPE
    , NVL(NAME, 'No name')
    , SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

-- 중성화 여부 파악하기
-- 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다. 동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요.
SELECT
    ANIMAL_ID
    , NAME
    , CASE 
        WHEN SEX_UPON_INTAKE LIKE 'Neutered%' THEN 'O'
        WHEN SEX_UPON_INTAKE LIKE 'Spayed%' THEN 'O'
        ELSE 'X'
      END 중성화
FROM ANIMAL_INS
ORDER BY ANIMAL_ID ASC;

-- 중복 제거하기
-- 동물 보호소에 들어온 동물의 이름은 몇 개인지 조회하는 SQL 문을 작성해주세요. 이때 이름이 NULL인 경우는 집계하지 않으며 중복되는 이름은 하나로 칩니다.
SELECT COUNT(DISTINCT NAME) COUNT FROM ANIMAL_INS;

-- DATETIME에서 DATE로 형 변환
-- ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 각 동물의 아이디와 이름, 들어온 날짜를 조회하는 SQL문을 작성해주세요. 이때 결과는 아이디 순으로 조회해야 합니다.
-- 들어온 날짜 : 시각(시-분-초)을 제외한 날짜(년-월-일)만 보여주세요
SELECT
    ANIMAL_ID
    , NAME
    , TO_CHAR(DATETIME, 'YYYY-MM-DD')
FROM ANIMAL_INS
ORDER BY ANIMAL_ID ASC;