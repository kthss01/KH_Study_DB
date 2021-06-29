-- 우유와 요거트가 담긴 장바구니
-- 우유와 요거트를 동시에 구입한 장바구니가 있는지 알아보려고 함
-- 우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회하는 SQL문 작성
-- 이때 결과는 장바구니의 아이디 순으로 나와야 함
SELECT
    CART_ID
FROM CART_PRODUCTS
WHERE NAME = 'Yogurt'
GROUP BY CART_ID
INTERSECT
SELECT
    CART_ID
FROM CART_PRODUCTS
WHERE NAME = 'Milk'
GROUP BY CART_ID
ORDER BY CART_ID;

-- SELF JOIN 이용
SELECT CART1.CART_ID
FROM CART_PRODUCTS CART1, CART_PRODUCTS CART2
WHERE CART1.CART_ID = CART2.CART_ID AND CART1.NAME = 'Milk' AND CART2.NAME = 'Yogurt';


-- 입양 시각 구하기(2)
-- 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려고 함
-- 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요.
-- 이 때 결과는 시간대 순으로 정렬해야 합니다.

SELECT
    A.HOUR
    , NVL(B.COUNT, 0) COUNT
FROM    (
            SELECT 
                LEVEL - 1 AS HOUR
            FROM DUAL
            CONNECT BY LEVEL <= 24
        ) A
LEFT JOIN (
                SELECT
                    TO_NUMBER(TO_CHAR(DATETIME, 'fmHH24')) HOUR
                    , COUNT(*) COUNT
                FROM ANIMAL_OUTS
                GROUP BY TO_CHAR(DATETIME, 'fmHH24')
            ) B 
ON A.HOUR = B.HOUR
ORDER BY A.HOUR;

-- FROM에 2 테이블 쓰고 LEFT JOIN 하는게 보기 좋은거 같음
SELECT
    A.HOUR
    , NVL(B.COUNT, '0') COUNT
FROM
    (
        SELECT LEVEL-1 AS HOUR
        FROM DUAL
        CONNECT BY LEVEL <= 24
    ) A
    , (
        SELECT 
            TO_CHAR(DATETIME, 'HH24') AS HOUR
            , COUNT(*) COUNT
        FROM ANIMAL_OUTS
        GROUP BY TO_CHAR(DATETIME, 'HH24')
    ) B
WHERE A.HOUR = B.HOUR(+)
ORDER BY A.HOUR;

-- 보호소에서 중성화한 동물
-- 보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에 중성화 되지 않았지만
-- 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하고 아이디 순으로 정렬하는 SQL문을 작성하시오.
-- 중성화를 거치지 않은 동물은 Intact -> 거치면 Spayed or Neutered로 표시

SELECT 
    ANIMAL_ID
    , ANIMAL_TYPE
    , NAME
FROM ANIMAL_INS
WHERE SEX_UPON_INTAKE LIKE 'Intact%'
INTERSECT
SELECT 
    ANIMAL_ID
    , ANIMAL_TYPE
    , NAME
FROM ANIMAL_OUTS
WHERE SEX_UPON_OUTCOME LIKE 'Spayed%' OR SEX_UPON_OUTCOME LIKE 'Neutered%'
ORDER BY ANIMAL_ID ASC;