-- 1. 직급이 대리이면서 ASIA지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
SELECT
    A.EMP_ID
    , A.EMP_NAME
    , B.JOB_NAME
    , C.DEPT_TITLE
    , D.LOCAL_NAME
    , A.SALARY
FROM EMPLOYEE A
    , JOB B
    , DEPARTMENT C
    , LOCATION D
WHERE A.JOB_CODE = B.JOB_CODE
AND A.DEPT_CODE = C.DEPT_ID
AND C.LOCATION_ID = D.LOCAL_CODE
AND A.JOB_CODE = 'J6'
AND D.LOCAL_NAME LIKE 'ASIA%';

SELECT
    A.EMP_ID
    , A.EMP_NAME
    , B.JOB_NAME
    , C.DEPT_TITLE
    , D.LOCAL_NAME
    , A.SALARY
FROM EMPLOYEE A
JOIN JOB B ON A.JOB_CODE = B.JOB_CODE
JOIN DEPARTMENT C ON A.DEPT_CODE = C.DEPT_ID
JOIN LOCATION D ON C.LOCATION_ID = D.LOCAL_CODE
WHERE A.JOB_CODE = 'J6'
AND D.LOCAL_NAME LIKE 'ASIA%';

-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--    사원명, 주민번호, 부서명, 직급명을 조회하시오
SELECT
    A.EMP_NAME
    , A.EMP_NO
    , B.DEPT_TITLE
    , C.JOB_NAME
FROM EMPLOYEE A
    , DEPARTMENT B
    , JOB C
WHERE A.DEPT_CODE = B.DEPT_ID
AND A.JOB_CODE = C.JOB_CODE
AND SUBSTR(A.EMP_NO, 1, 2) BETWEEN '70' AND '79'
AND SUBSTR(A.EMP_NO, 8, 1) = '2'
AND A.EMP_NAME LIKE '전%';

SELECT
    A.EMP_NAME
    , A.EMP_NO
    , B.DEPT_TITLE
    , C.JOB_NAME
FROM EMPLOYEE A
JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
JOIN JOB C ON A.JOB_CODE = C.JOB_CODE
WHERE 1=1
AND SUBSTR(A.EMP_NO, 1, 2) BETWEEN '70' AND '79'
AND SUBSTR(A.EMP_NO, 8, 1) = '2'
AND A.EMP_NAME LIKE '전%';

-- 3. 이름에 '형'자가 들어있는 직원들의
--    사번, 사원명, 직급명을 조회하시오
SELECT 
    EMP_ID
    , EMP_NAME
    , JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';
--OR EMP_NAME LIKE '형%' -- 이렇게 안해도 %형%에 다 걸림
--OR EMP_NAME LIKE '%형';

SELECT 
    EMP_ID
    , EMP_NAME
    , JOB_NAME
FROM EMPLOYEE A
    , JOB B
WHERE 1=1
AND A.JOB_CODE = B.JOB_CODE
AND EMP_NAME LIKE '%형%';
    
-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오
SELECT
    A.EMP_NAME
    , B.JOB_NAME
    , A.DEPT_CODE
    , C.DEPT_TITLE
FROM EMPLOYEE A
    , JOB B
    , DEPARTMENT C
WHERE A.JOB_CODE = B.JOB_CODE
AND A.DEPT_CODE = C.DEPT_ID
AND DEPT_TITLE LIKE '%해외영업%';

SELECT
    A.EMP_NAME
    , B.JOB_NAME
    , A.DEPT_CODE
    , C.DEPT_TITLE
FROM EMPLOYEE A
JOIN JOB B ON A.JOB_CODE = B.JOB_CODE
JOIN DEPARTMENT C ON A.DEPT_CODE = C.DEPT_ID
WHERE 1=1
AND DEPT_TITLE LIKE '%해외영업%';

-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
SELECT
    A.EMP_NAME
    , A.BONUS
    , A.SALARY * 12 연봉
    , B.DEPT_TITLE
    , C.LOCAL_NAME
FROM EMPLOYEE A
    , DEPARTMENT B
    , LOCATION C
WHERE A.DEPT_CODE = B.DEPT_ID
AND B.LOCATION_ID = C.LOCAL_CODE
AND BONUS IS NOT NULL AND BONUS != 0;

SELECT
    A.EMP_NAME
    , A.BONUS
    , A.SALARY
    , B.DEPT_TITLE
    , C.LOCAL_NAME
FROM EMPLOYEE A
JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
JOIN LOCATION C ON B.LOCATION_ID = C.LOCAL_CODE
WHERE 1=1
AND BONUS IS NOT NULL AND BONUS != 0;

-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오
SELECT
    A.EMP_NAME
    , B.JOB_NAME
    , C.DEPT_TITLE
    , D.LOCAL_NAME
FROM EMPLOYEE A
    , JOB B
    , DEPARTMENT C
    , LOCATION D
WHERE A.JOB_CODE = B.JOB_CODE
AND A.DEPT_CODE = C.DEPT_ID
AND C.LOCATION_ID = D.LOCAL_CODE
AND C.DEPT_TITLE IS NOT NULL;

SELECT
    A.EMP_NAME
    , B.JOB_NAME
    , C.DEPT_TITLE
    , D.LOCAL_NAME
FROM EMPLOYEE A
JOIN JOB B ON A.JOB_CODE = B.JOB_CODE
JOIN DEPARTMENT C ON A.DEPT_CODE = C.DEPT_ID
JOIN LOCATION D ON C.LOCATION_ID = D.LOCAL_CODE
WHERE 1=1
AND C.DEPT_TITLE IS NOT NULL;

-- 7. '한국'과 '일본'에 근무하는 직원들의 
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오
SELECT
    A.EMP_NAME
    , B.DEPT_TITLE
    , C.LOCAL_NAME
    , D.NATIONAL_NAME
FROM EMPLOYEE A
    , DEPARTMENT B
    , LOCATION C
    , NATIONAL D
WHERE A.DEPT_CODE = B.DEPT_ID
AND B.LOCATION_ID = C.LOCAL_CODE
AND C.NATIONAL_CODE = D.NATIONAL_CODE
--AND D.NATIONAL_NAME IN('한국', '일본');
AND C.LOCAL_CODE IN('L1', 'L2'); -- D가 아니라 C에 있음 그래서 오류

SELECT
    A.EMP_NAME
    , B.DEPT_TITLE
    , C.LOCAL_NAME
    , D.NATIONAL_NAME
FROM EMPLOYEE A
JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
JOIN LOCATION C ON B.LOCATION_ID = C.LOCAL_CODE
JOIN NATIONAL D ON C.NATIONAL_CODE = D.NATIONAL_CODE
WHERE 1=1
--AND D.NATIONAL_NAME IN('한국', '일본');
AND C.LOCAL_CODE IN('L1', 'L2');

-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의
--    사원명, 직급명, 급여를 조회하시오
SELECT
    A.EMP_NAME
    , B.JOB_NAME
    , A.SALARY
    , A.JOB_CODE
    , A.BONUS
FROM EMPLOYEE A
    , JOB B
WHERE A.JOB_CODE = B.JOB_CODE
AND A.BONUS IS NULL
AND A.JOB_CODE IN('J4', 'J7');

SELECT
    A.EMP_NAME
    , B.JOB_NAME
    , A.SALARY
    , A.JOB_CODE
    , A.BONUS
FROM EMPLOYEE A
JOIN JOB B ON A.JOB_CODE = B.JOB_CODE
WHERE 1=1
AND A.BONUS IS NULL
AND A.JOB_CODE IN('J4', 'J7');
    
-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이때 구분에 해당하는 값은
--    급여등급이 S1, S2인 경우 '고급'
--    급여등급이 S3, S4인 경우 '중급'
--    급여등급이 S5, S6인 경우 '초급' 으로 조회되게 하시오.
SELECT
    A.EMP_ID
    , A.EMP_NAME
    , B.JOB_NAME
    , C.SAL_LEVEL
    , CASE
        WHEN C.SAL_LEVEL IN('S1','S2') THEN '고급'
        WHEN C.SAL_LEVEL IN('S3','S4') THEN '중급'
        WHEN C.SAL_LEVEL IN('S5','S6') THEN '초급'
    END 구분
FROM EMPLOYEE A
    , JOB B
    , SAL_GRADE C
WHERE A.JOB_CODE = B.JOB_CODE
AND A.SALARY BETWEEN C.MIN_SAL AND C.MAX_SAL;

SELECT
    A.EMP_ID
    , A.EMP_NAME
    , B.JOB_NAME
    , C.SAL_LEVEL
    , CASE
        WHEN C.SAL_LEVEL IN('S1','S2') THEN '고급'
        WHEN C.SAL_LEVEL IN('S3','S4') THEN '중급'
        WHEN C.SAL_LEVEL IN('S5','S6') THEN '초급'
    END 구분
FROM EMPLOYEE A
JOIN JOB B ON A.JOB_CODE = B.JOB_CODE
JOIN SAL_GRADE C ON A.SALARY BETWEEN C.MIN_SAL AND C.MAX_SAL;

-- 10. 각 부서별 총 급여합을 조회하되
--     이때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오
SELECT
    B.DEPT_TITLE
    , SUM(A.SALARY) 급여합
FROM EMPLOYEE A
    , DEPARTMENT B
WHERE A.DEPT_CODE = B.DEPT_ID
GROUP BY B.DEPT_TITLE
HAVING SUM(A.SALARY) >= 10000000;

SELECT
    B.DEPT_TITLE
    , SUM(A.SALARY) 급여합
FROM EMPLOYEE A
JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
WHERE 1=1
GROUP BY B.DEPT_TITLE
HAVING SUM(A.SALARY) >= 10000000;

-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리)로 조회하시오.
--      단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오.
SELECT
    B.DEPT_TITLE
    , FLOOR(AVG(A.SALARY)) 평균급여
FROM EMPLOYEE A
    , DEPARTMENT B
WHERE A.DEPT_CODE = B.DEPT_ID(+)
GROUP BY B.DEPT_TITLE;

SELECT
    B.DEPT_TITLE
    , FLOOR(AVG(A.SALARY)) 평균급여
FROM EMPLOYEE A
LEFT JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
GROUP BY B.DEPT_TITLE;