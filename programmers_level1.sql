-- 모든 레코드 조회하기
-- 동물 보호소에 들어온 모든 동물의 정보를 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요.
SELECT * FROM ANIMAL_INS ORDER BY ANIMAL_ID ASC;

-- 이름이 없는 동물의 아이디
-- 동물 보호소에 들어온 동물 중, 이름이 없는 채로 들어온 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT ANIMAL_ID FROM ANIMAL_INS WHERE NAME IS NULL ORDER BY ANIMAL_ID ASC;

-- 최대값 구하기
-- 가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
/*
오라클에서 LIMIT와 동일한 결과를 얻기 위해서는 SELECT절로 한번 감싼 후에 ROWNUM으로 조건을 주면 LIMIT와 동일한 결과가 출력
LIMIT는 쿼리가 ORDER BY 절까지 모두 실행 후 해당 결과에서 원하는 행의 데이터를 가져옴
ROWNUM은 쿼리가 완전히 수행되지 않은 원 데이터의 정렬순서대로 번호를 매기기 때문에 전혀 다른 결과가 출력됨
*/
SELECT * FROM (SELECT DATETIME 시간 FROM ANIMAL_INS ORDER BY DATETIME DESC) WHERE ROWNUM <= 1;

-- 역순 정렬하기
-- 동물 보호소에 들어온 모든 동물의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 ANIMAL_ID 역순으로 보여주세요. 
SELECT NAME, DATETIME FROM ANIMAL_INS ORDER BY ANIMAL_ID DESC;

-- 이름이 있는 동물의 아이디
-- 동물 보호소에 들어온 동물 중, 이름이 있는 동물의 ID를 조회하는 SQL 문을 작성해주세요. 단, ID는 오름차순 정렬되어야 합니다.
SELECT ANIMAL_ID FROM ANIMAL_INS WHERE NAME IS NOT NULL ORDER BY ANIMAL_ID;

-- 아픈 동물 찾기
-- 동물 보호소에 들어온 동물 중 아픈 동물의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
-- 아픈 동물 : INTAKE_CONDITION이 Sick인 경우
SELECT ANIMAL_ID, NAME FROM ANIMAL_INS WHERE INTAKE_CONDITION = 'Sick' ORDER BY ANIMAL_ID ASC;

-- 어린 동물 찾기
-- 동물 보호소에 들어온 동물 중 젊은 동물의 아이디와 이름을 조회하는 SQL 문을 작성해주세요. 이때 결과는 아이디 순으로 조회해주세요.
-- 젊은 동물 : INTAKE_CONDITION이 Aged가 아닌 경우
SELECT ANIMAL_ID, NAME FROM ANIMAL_INS WHERE INTAKE_CONDITION != 'Aged' ORDER BY ANIMAL_ID ASC;

-- 동물의 아이디와 이름
-- 동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID순으로 조회하는 SQL문을 작성해주세요.
SELECT ANIMAL_ID, NAME FROM ANIMAL_INS ORDER BY ANIMAL_ID ASC;

-- 여러 기준으로 정렬하기
-- 동물 보호소에 들어온 모든 동물의 아이디와 이름, 보호 시작일을 이름 순으로 조회하는 SQL문을 작성해주세요. 단, 이름이 같은 동물 중에서는 보호를 나중에 시작한 동물을 먼저 보여줘야 합니다.
SELECT ANIMAL_ID, NAME, DATETIME FROM ANIMAL_INS ORDER BY NAME ASC, DATETIME DESC;

-- 상위 n개 레코드
-- 동물 보호소에 가장 먼저 들어온 동물의 이름을 조회하는 SQL 문을 작성해주세요.
SELECT * FROM (SELECT NAME FROM ANIMAL_INS ORDER BY DATETIME ASC) WHERE ROWNUM = 1;
