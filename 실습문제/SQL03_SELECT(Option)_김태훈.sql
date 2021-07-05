-- 1. 학생 이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
-- 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT
    STUDENT_NAME "학생 이름"
    , STUDENT_ADDRESS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME ASC;


-- 2. 휴학 중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT
    STUDENT_NAME
    , STUDENT_SSN
--    , ABSENCE_YN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;


-- 3. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를
-- 이름의 오름차순으로 화면에 출력하시오. 단, 출력 헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT
    STUDENT_NAME 학생이름
    , STUDENT_NO 학번
    , STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE 1=1
AND (STUDENT_ADDRESS LIKE '강원%' OR STUDENT_ADDRESS LIKE '경기%')
AND STUDENT_NO LIKE '9%'
ORDER BY 1;


-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아내도록 하자)
SELECT 
    DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '법학과'; -- 005

SELECT
    PROFESSOR_NAME
    , PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = 005
ORDER BY PROFESSOR_SSN ASC;


-- 5. 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
SELECT
    STUDENT_NO
    , TO_CHAR(POINT, '9.99') POINT
FROM TB_GRADE
WHERE 1=1
AND TERM_NO = 200402
AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO DESC;


-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL문을 작성하시오.
SELECT
    A.STUDENT_NO
    , A.STUDENT_NAME
    , B.DEPARTMENT_NAME
FROM TB_STUDENT A, TB_DEPARTMENT B
WHERE A.DEPARTMENT_NO = B.DEPARTMENT_NO; -- 정렬 안한게 결과 화면이라 일단 이렇게
--ORDER BY 2 ASC;


-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT
    A.CLASS_NAME
    , B.DEPARTMENT_NAME
FROM TB_CLASS A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO;


-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
SELECT
    B.CLASS_NAME
    , C.PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR A
JOIN TB_CLASS B ON A.CLASS_NO = B.CLASS_NO
JOIN TB_PROFESSOR C ON A.PROFESSOR_NO = C.PROFESSOR_NO
ORDER BY 2, 1;
-- 먼가 결과와 정렬이 안맞음 후에 방법 찾아보자 (조회 수는 맞음)
-- 틀린거 아님


-- 9. 8번의 결과 중 '인문사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
SELECT 
    CATEGORY
FROM TB_DEPARTMENT;

SELECT
    B.CLASS_NAME
    , C.PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR A
JOIN TB_CLASS B ON A.CLASS_NO = B.CLASS_NO
JOIN TB_PROFESSOR C ON A.PROFESSOR_NO = C.PROFESSOR_NO
JOIN TB_DEPARTMENT D ON B.DEPARTMENT_NO = D.DEPARTMENT_NO
WHERE D.CATEGORY = '인문사회'
ORDER BY 2, 1;
-- 이것도 정렬 상태가 이상함 조회 수는 맞게 나옴
-- 틀린거 아님


-- 10. '음악학과' 학생들의 평점을 구하려고 한다. 음악학과 학생들의 '학번', "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT 
    DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '음악학과'; -- 059

SELECT
    A.STUDENT_NO 학번
    , A.STUDENT_NAME "학생 이름"
    , ROUND(AVG(B.POINT), 1) "전체 평점"
FROM TB_STUDENT A
JOIN TB_GRADE B ON A.STUDENT_NO = B.STUDENT_NO
JOIN TB_DEPARTMENT C ON A.DEPARTMENT_NO = C.DEPARTMENT_NO
WHERE C.DEPARTMENT_NAME = '음악학과'
GROUP BY (A.STUDENT_NO, A.STUDENT_NAME)
ORDER BY 1;


-- 11. 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 
-- 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL 문을 작성하시오.
-- 단, 출력헤더는 "학과이름", "학생이름", "지도교수이름" 으로 출력되도록 한다.
SELECT
    A.DEPARTMENT_NAME 학과이름
    , B.STUDENT_NAME 학생이름
    , C.PROFESSOR_NAME 지도교수이름
FROM TB_DEPARTMENT A
JOIN TB_STUDENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
JOIN TB_PROFESSOR C ON B.COACH_PROFESSOR_NO = C.PROFESSOR_NO
WHERE B.STUDENT_NO = 'A313047';


-- 12. 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아
-- 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.
SELECT
    STUDENT_NAME
    , TERM_NO TERM_NMAE
FROM TB_STUDENT A
JOIN TB_GRADE B ON A.STUDENT_NO = B.STUDENT_NO
JOIN TB_CLASS C ON B.CLASS_NO = C.CLASS_NO
WHERE 1=1
AND TERM_NO LIKE '2007%'
AND C.CLASS_NAME = '인간관계론';


-- 13. 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아
-- 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT
    *
FROM TB_CLASS;

SELECT
    *
FROM TB_CLASS_PROFESSOR
RIGHT JOIN TB_CLASS USING(CLASS_NO)
WHERE PROFESSOR_NO IS NULL;

SELECT
    A.CLASS_NAME
    , C.DEPARTMENT_NAME
FROM TB_CLASS A
LEFT JOIN TB_CLASS_PROFESSOR B ON A.CLASS_NO = B.CLASS_NO
JOIN TB_DEPARTMENT C ON A.DEPARTMENT_NO = C.DEPARTMENT_NO
WHERE 1=1
AND C.CATEGORY = '예체능'
AND B.PROFESSOR_NO IS NULL
ORDER BY 2;
-- 이것도 조회수는 맞는데 정렬 결과가 다름 문제가 있는거 일 수 있음


-- 14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
-- 학생 이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우
-- "지도교수 미지정"으로 표시하도록 SQL문을 작성하시오.
-- 단, 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.
SELECT
    *
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '서반아어학과';

SELECT
    *
FROM TB_STUDENT;

SELECT
    A.STUDENT_NAME 학생이름
    , NVL(C.PROFESSOR_NAME, '지도교수 미지정') 지도교수
--    , B.DEPARTMENT_NAME
FROM TB_STUDENT A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
LEFT JOIN TB_PROFESSOR C ON A.COACH_PROFESSOR_NO = C.PROFESSOR_NO
WHERE B.DEPARTMENT_NAME = '서반아어학과' -- 이거 오타라 계속 안나왔던거
ORDER BY A.STUDENT_NO ASC;


-- 15. 휴학생이 아닌 학생 중 평점이 4.0이상인 학생을 찾아 그 학생의 학번, 이름, 학과이름, 평점을 출력하는 SQL문을 작성하시오.
SELECT
    A.STUDENT_NO 학번
    , A.STUDENT_NAME 이름
    , B.DEPARTMENT_NAME 학과이름
    , ROUND(AVG(C.POINT), 8) 평점
FROM TB_STUDENT A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
JOIN TB_GRADE C ON A.STUDENT_NO = C.STUDENT_NO
WHERE 1=1
AND A.ABSENCE_YN = 'N'
GROUP BY A.STUDENT_NO, A.STUDENT_NAME, B.DEPARTMENT_NAME
HAVING AVG(C.POINT) >= 4.0
ORDER BY 1;


-- 16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL문을 작성하시오.
SELECT
    *
FROM TB_CLASS; -- 전공선택, 전공필수

SELECT
    A.CLASS_NO
    , A.CLASS_NAME
    , ROUND(AVG(C.POINT), 8) "AVG(POINT)"
FROM TB_CLASS A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
JOIN TB_GRADE C ON A.CLASS_NO = C.CLASS_NO
WHERE 1=1 
AND B.DEPARTMENT_NAME = '환경조경학과'
AND A.CLASS_TYPE LIKE '전공%'
GROUP BY A.CLASS_NO, A.CLASS_NAME;


-- 17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL문을 작성하시오.
SELECT
    A.STUDENT_NAME
    , A.STUDENT_ADDRESS
FROM TB_STUDENT A, TB_STUDENT B
WHERE 1=1
AND A.DEPARTMENT_NO = B.DEPARTMENT_NO
AND B.STUDENT_NAME = '최경희';


-- 18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 작성하시오
SELECT
    A.STUDENT_NO
    , A.STUDENT_NAME
    , AVG(C.POINT) 총평점
FROM TB_STUDENT A
JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
JOIN TB_GRADE C ON A.STUDENT_NO = C.STUDENT_NO
WHERE 1=1
AND DEPARTMENT_NAME = '국어국문학과'
GROUP BY A.STUDENT_NO, A.STUDENT_NAME
ORDER BY AVG(C.POINT) DESC;

SELECT
    A.STUDENT_NO
    , A.STUDENT_NAME
FROM    (
            SELECT
                A.STUDENT_NO
                , A.STUDENT_NAME
                , AVG(C.POINT) 총평점
            FROM TB_STUDENT A
            JOIN TB_DEPARTMENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
            JOIN TB_GRADE C ON A.STUDENT_NO = C.STUDENT_NO
            WHERE 1=1
            AND DEPARTMENT_NAME = '국어국문학과'
            GROUP BY A.STUDENT_NO, A.STUDENT_NAME
            ORDER BY AVG(C.POINT) DESC
        ) A
WHERE ROWNUM = 1;
-- 다른 방법 있을거 같음 파트에 맞지 않는 해결 방법으로 보임


-- 19. 춘 기술대학교의 '환경조경학과'가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한
-- 적절한 SQL 문을 찾아내시오. 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시하도록 하고,
-- 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.

SELECT
    A.DEPARTMENT_NAME "계열 학과명"
    , ROUND(AVG(C.POINT), 1)"전공 평점"
--    , D.CLASS_TYPE
--    , C.POINT
FROM TB_DEPARTMENT A
JOIN TB_STUDENT B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
JOIN TB_GRADE C ON B.STUDENT_NO = C.STUDENT_NO
JOIN TB_CLASS D ON A.DEPARTMENT_NO = D.DEPARTMENT_NO
WHERE 1=1
AND A.CATEGORY =    (
                        SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '환경조경%'
                    )
AND D.CLASS_TYPE LIKE '전공%'
--AND D.CLASS_TYPE NOT LIKE '전공%'
GROUP BY A.DEPARTMENT_NAME
ORDER BY 1;
-- 답이 안맞음 반올림시 물리학과의 경우 3.3이어야되는데 3.4임 환경조경학과도 3.4이어야되는데 3.5
-- GRADE로 시작해야하는거 같음

SELECT
    C.DEPARTMENT_NAME "계열 학과명"
    , ROUND(AVG(A.POINT), 1) "전공 평점"
FROM TB_GRADE A
JOIN TB_CLASS B ON A.CLASS_NO = B.CLASS_NO
JOIN TB_DEPARTMENT C ON B.DEPARTMENT_NO = C.DEPARTMENT_NO
WHERE 1=1
AND C.CATEGORY =    (
                        SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '환경조경%'
                    )
AND B.CLASS_TYPE LIKE '전공%'
GROUP BY C.DEPARTMENT_NAME
ORDER BY 1;
