-- 없어진 기록 찾기
-- 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID순으로 조회하는 SQL문 작성
SELECT
    ANIMAL_ID
    , NAME
FROM ANIMAL_OUTS
WHERE ANIMAL_ID NOT IN (SELECT 
                         ANIMAL_ID
                     FROM ANIMAL_INS)
ORDER BY ANIMAL_ID ASC;

SELECT
    A.ANIMAL_ID
    , A.NAME
FROM ANIMAL_OUTS A
LEFT JOIN ANIMAL_INS B ON A.ANIMAL_ID = B.ANIMAL_ID
WHERE B.ANIMAL_ID IS NULL
ORDER BY A.ANIMAL_ID ASC;

-- 있었는데요 없었습니다
-- 관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 보호 시작일보다 입양일이 더 빠른 동물의 아이ㅣ도아 이름을 조회하는 SQL문을 작성해주세요.
-- 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
SELECT 
    A.ANIMAL_ID
    , A.NAME
--  , A.DATETIME A_DATE
--  , B.DATETIME B_DATE
FROM ANIMAL_OUTS A
JOIN ANIMAL_INS B ON A.ANIMAL_ID = B.ANIMAL_ID
WHERE A.DATETIME < B.DATETIME
ORDER BY B.DATETIME ASC;

-- 오랜 기간 보호한 동물(1)
-- 아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문 작성
-- 이때 결과는 보호 시작일 순으로 조회
SELECT
    *
FROM (
        SELECT
            A.NAME
            , A.DATETIME
        FROM ANIMAL_INS A
        LEFT JOIN ANIMAL_OUTS B ON A.ANIMAL_ID = B.ANIMAL_ID
        WHERE B.ANIMAL_ID IS NULL
        ORDER BY A.DATETIME ASC
    )
WHERE ROWNUM <= 3;

-- 헤비 유저가 소유한 장소
-- 이 서비스에서 공간을 둘 이상 등록한 사람을 "헤비 유저"라고 부름
-- 헤비 유저가 등록한 공간의 정보를 아이디 순으로 조회하는 SQL문을 작성
SELECT 
    *
FROM PLACES
WHERE HOST_ID IN (
                SELECT
                    HOST_ID
                    -- , COUNT(*)
                FROM PLACES
                GROUP BY HOST_ID
                HAVING COUNT(*) >= 2
            )
ORDER BY ID;

-- 오랜 기간 보호한 동물(2)
-- 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요
-- 이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.

SELECT 
    *
FROM (
        SELECT
            A.ANIMAL_ID
            , A.NAME
        FROM ANIMAL_OUTS A
        JOIN ANIMAL_INS B ON A.ANIMAL_ID = B.ANIMAL_ID
        ORDER BY (A.DATETIME - B.DATETIME) DESC
    )
WHERE ROWNUM <= 2;
