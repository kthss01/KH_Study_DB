-- 그룹함수와 단일행함수
--함수(FUNCTION) : 컬럼값을 읽어서 계산한 결과를 리턴함 
--단일행함수 : 컬럼에 기록된 N 개의 값을 읽어서 N 개의 결과를 리턴 
--그룹함수 : 컬럼에 기록된 N 개의 값을 읽어서 한개의 결과를 리턴 

--SELECT 절에 단일행 함수와 그룹함수를 함께 사용하지 못한다.  
--: 결과 행의 갯수가 다르기 때문

-- 함수를 사용할수 있는 위치 : SELECT 절, WHERE 절, GROUP BY 절, HAVING절, ORDER BY 절

-- 단일행 함수
-- 문자관련함수 
-- LENGTH, LENGTHB , SUBSTR,UPPER, LOWER, INSTR....


SELECT
    LENGTH('오라클')
    , LENGTHB('오라클')
FROM DUAL;

SELECT
    LENGTH(EMAIL)
    , LENGTHB(EMAIL)
FROM EMPLOYEE;


--DUAL 테이블
--한 행으로 결과를 출력하기 위한 테이블
--산술 연산이나 가상 컬럼 등의 값을 한번만 출력하고 싶을 때 많이 사용
--DUMMY : 단 하나의 컬럼에 X(아무 의미 없는 값)라는 하나의 로우를 저장하고 있음
--DB2: SYSIBM.SYSDUMMY1

SELECT * FROM DUAL;
SELECT SYSDATE FROM DUAL;
SELECT 1+3 VAL FROM DUAL;

DESC DUAL;


--INSTR('문자열' | 컬럼명,'문자', 찾을 위치의 시작값 ,[빈도])
/*파라미터			설명
STRING			문자 타입 컬럼 또는 문자열
STR			찾으려는 문자(열)
POSITION		찾을 위치 시작 값 (기본값 1) -> 찾을 위치 시작값임 이거 조심 단순히 방향을 의미하는게 아님
			POSITION > 0 : STRING의 시작부터 끝 방향으로 찾음
			POSITION < 0 : STRING의 끝부터 시작 방향으로 찾음
OCCURRENCE		검색된 STR의 순번(기본값 1), 음수 사용 불가 -> 1이면 뒤에서부터 첫번째 나오는 값을 찾게됨
*/

SELECT 
    EMAIL 
    , INSTR(EMAIL, '@', -1) VAL -- 셀때는 앞에서부터 셈 1부터 시작, 못찾으면 0 반환
FROM EMPLOYEE;

SELECT INSTR('AABAACAABBAA','B') LOC FROM DUAL; --3번째위치
SELECT INSTR('AABAACAABBAA','B',1) LOC FROM DUAL;---1번째 이후에있는 3번째위치
SELECT INSTR('AABAACAABBAA','B',4) LOC FROM DUAL;--4번째 이후에있는 B는 처음부터 9번째
SELECT INSTR('AABAACAABBAA','B',1,2) LOC FROM DUAL;--앞에서부터 1번째 이후에있는 2번째 'B' 의 위치 앞에서부터 세어보면 9번째 
SELECT INSTR('AABAACAABBAA','B',-1,2) LOC FROM DUAL;--뒤에서부터 1번째 이후에있는 2번째 'B' 의 위치 앞에서부터 세어보면 9번째 

SELECT 
    EMAIL 
    , INSTR(EMAIL, 'h', -1, 1) VAL -- 셀때는 앞에서부터 셈 1부터 시작, 못찾으면 0 반환
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원명, 이메일, 
-- @ 이후를 제외한 아이디를 조회

SELECT
    EMP_NAME
    , EMAIL
    , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) VAL -- SUBSTR('문자열', '시작위치', 자를 길이)
FROM EMPLOYEE;

-- LPAD/RPAD : 주어진 컬럼 문자열에 임의의 문자열을 덧붙여 길이 N의 문자열을 반환하는 함수

SELECT
    LPAD(EMAIL, 20, '#') VAL
FROM EMPLOYEE;

SELECT
    RPAD(EMAIL, 20, '#') VAL
FROM EMPLOYEE;

SELECT
    LPAD(EMAIL, 10, '#') VAL -- 더 작게 잡으면 잘림
FROM EMPLOYEE;

SELECT
    RPAD(EMAIL, 10, '#') VAL -- 더 작게 잡으면 잘림 LPAD랑 똑같이 잘림
FROM EMPLOYEE;


-- LTRIM/RTRIM : 주어진 컬럼이나 문자열 왼쪽/오른쪽에서 지정한 문자혹은 문자열을 제거한 나머지를 반환하는 함수
SELECT LTRIM('    KH') FROM DUAL;
SELECT LTRIM('    KH', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123132KH', '123') FROM DUAL; -- 123이든 132든 다 지워버림
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT LTRIM('5782KH', '0123456789') FROM DUAL; -- 포함되어있는건 다 지워버림

SELECT RTRIM('KH    ') FROM DUAL;
SELECT RTRIM('KH    ', ' ') FROM DUAL;
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KH123132', '123') FROM DUAL; -- 123이든 132든 다 지워버림
SELECT RTRIM('123KH123123', '123') FROM DUAL;
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;
SELECT RTRIM('KH5782', '0123456789') FROM DUAL; -- 포함되어있는건 다 지워버림

-- TRIM : 주어진 컬럼이나 문자열의 앞/뒤에 지정한 문자를 제거

SELECT TRIM('   KH   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZZ123456ZZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZ123456ZZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZZ123456ZZZZ') FROM DUAL;

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치로부터 지정한 문자열을 잘라서 리턴하는 함수
-- SUBSTR('문자열', '시작위치', 자를 길이)

SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7번째부터 다 나옴
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- -8 뒤에서부터 8번째
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL; -- 한글도 마찬가지이고 공백도 포함

SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) VAL, EMP_NO
FROM EMPLOYEE;


-- LOWER/UPPER/INITCAP : 대소문자를 변경해주는 함수

-- LOWER(문자열 | 컬럼) : 소문자로 변경해주는 함수
SELECT
    LOWER('Welcome To My World') VAL
FROM DUAL;

-- UPPER(문자열 | 컬럼) : 대문자로 변경해주는 함수
SELECT
    UPPER('Welcome To My World') VAL
FROM DUAL;

-- INITCAP : 앞글자만 대문자로 변경해주는 함수
-- LOWER(문자열 | 컬럼) : 소문자로 변경해주는 함수
SELECT
    INITCAP('한글welcome to my 2world') VAL -- 한글이나 숫자 같은 다른거 넣으면 그 부분은 무시 한글 쪽은 대문자로 해줌
FROM DUAL;

--CONCAT : 문자열 혹은 컬럼 두개를 하나로 합쳐주는 함수
SELECT
    CONCAT('가나다라','ABC')
FROM DUAL;

SELECT
    '가나다라'||'ABC'
FROM DUAL; -- 같음 ||는 여러개도 붙일 수 있음

--REPLACE : 컬럼 혹은 문자열을 입력받아 변경하고자 하는 문자열로 바꿔준다.
SELECT
    REPLACE('서울시 강남구 역삼동','역삼동','삼성동') VAL
FROM DUAL;

-- 1. EMPLOYEE 테이블에서 직원들의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단 컬럼의 별칭은 생년, 생월, 생일로한다.
SELECT
    EMP_NAME 사원명
    , SUBSTR(EMP_NO, 1, 2) 생년
    , SUBSTR(EMP_NO, 3, 2) 생월
    , SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;

-- 2. 여직원들의 모든 컬럼정보를 조회
SELECT 
    *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- 3. 직원들의 입사일을 입사년도, 입사월, 입사날짜를 분리하여 조회
-- 단 컬럼의 별칭은 입사년도, 입사월, 입사날짜
SELECT 
    SUBSTR(HIRE_DATE, 1, 2) 입사년도
    , SUBSTR(HIRE_DATE, 4, 2) 입사월
    , SUBSTR(HIRE_DATE, 7, 2) 입사날짜
FROM EMPLOYEE;


-- SUBSTRB : 바이트 단위로 추출하는 함수
SELECT
    SUBSTR('ORACLE', 3, 2)
    , SUBSTRB('ORACLE', 3, 2)
FROM DUAL;

SELECT
    SUBSTR('오라클', 2, 2)
    , SUBSTRB('오라클', 4, 6)
FROM DUAL;


-- 함수 중첩 사용 가능 : 함수 안에서 함수를 사용할 수 있음
-- EMPlOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년 월일만 보이게 하고, '-' 다음 값은 '*' 로 바꿔서 출력 하기

SELECT
    EMP_NAME 사원명
    , RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') 주민번호
FROM EMPLOYEE;


-- 숫자 처리 함수 : ABS, MOD, ROUND, FLOOR, TRUNC, CEIL

-- ABS(숫자 | 숫자로된 컬럼명) : 절대값 구하는 함수
SELECT
    ABS(-10) COL1
    , ABS(10) COL2
FROM DUAL;

-- MOD(숫자 | 숫자로된 컬럼명, 숫자 | 숫자로된 컬럼명)
-- : 두 수를 나누어서 나머지를 구하는 함수
-- 처음 인자는 나누어지는 수, 두번째 인자는 나눌 수
SELECT
    MOD(10, 5) COL1
    , MOD(10, 3) COL2
    , MOD(10, -3) COL3
    , MOD(-10, 3) COL3 -- 컬럼명 같으면 COL3_1 이렇게 됨, NUMBER -가 오면 -가 나옴
    , MOD(-10, -3) COL4
FROM DUAL;

-- ROUND(숫자 | 숫자로된 컬럼명, [위치])
-- : 반올림해서 리턴하는 함수
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL; -- 소수점 첫째자리까지
SELECT ROUND(123.456, 2) FROM DUAL; -- 소수점 둘째자리까지
SELECT ROUND(123.456, -2) FROM DUAL; -- 소수점 기준 왼쪽으로 -2 : 십의 자리

-- FLOOR(숫자 | 숫자로도니 컬럼명)
-- : 내림처리하는 함수 (인자로 전달받은 숫자 혹은 컬럼의 소수점 자리수를 버리는 함수)
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC(숫자 | 숫자로된 컬럼명, [위치])
-- 내림처리 (절삭) 함수, (인자로 전달받은 숫자 혹은 컬럼의 지정한 위치 이후의 소수점자리 수를 버리는 함수
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, 2) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL(숫자 | 숫자로된 컬럼명)
-- 올림처리하는 함수 (소수점 기준으로 올림처리)
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;


-- 날짜함수 : SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, EXTRACT

-- SYSDATE : 시스템에 저장되어있는 날짜를 반환해주는 함수
SELECT 
    SYSDATE
FROM DUAL;

-- MONTHS_BETWEEN(날짜, 날짜)
-- : 두 날짜의 개월 수 차이를 숫자로 리턴하는 함수
SELECT 
    EMP_NAME
    , HIRE_DATE
    , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) COL
FROM EMPLOYEE;

-- ADD_MONTH(날짜, 숫자)
-- : 날짜에 숫자만큼 개월 수를 더해서 리턴
SELECT
    ADD_MONTHS(SYSDATE, 1) COL1
FROM DUAL;

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 6개월이 되는 날짜를 조회
SELECT
    EMP_NAME
    , HIRE_DATE
    , ADD_MONTHS(HIRE_DATE, 6) COL1
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 근무년수가 20년 이상인 직원 조회
SELECT
    A.*, ADD_MONTHS(HIRE_DATE, 240) -- 이런 식으로 asterisk 랑 다른 열 같이 조회하려면 테이블에 별칭을 주면 됨
FROM EMPLOYEE A
--WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- NEXT_DAY(기준날짜, 요일(문자|숫자))
-- : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') NDAY FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) NDAY FROM DUAL; -- 구하려는 요일을 숫자로 하면 1: 일요일, 7: 토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') NDAY FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') NDAY FROM DUAL; -- 영어로 하면 에러뜸 NLS KOREAN으로 되어있어서 그럼
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- 이걸로 바꿔주면 FRIDAY 해결

ALTER SESSION SET NLS_DATE_FORMAT = 'RR-MM-DD'; -- 이런 식으로 날짜 포맷을 변경할 수 있음

ALTER SESSION SET NLS_LANGUAGE = KOREAN;
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

SELECT *
FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER IN('NLS_LANGUAGE', 'NLS_DATE_FORMAT', 'NLS_DATE_LANGUAGE'); -- NLS_DATE_LANGUAGE 따로 없으면 NLS_LANGUAGE 상속 받아 쓴다고함

-- LAST_DAY(날짜)
-- : 해당 월의 마지막 날짜를 구하여 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) LDAY FROM DUAL;

-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사월의 마지막날, 근무일수 조회
-- 입사일 - 오늘, 오늘 - 입사일 : 근무일수
SELECT
    EMP_NAME
    , HIRE_DATE
    , LAST_DAY(HIRE_DATE) LDAY
    , CEIL(SYSDATE - HIRE_DATE) 근무일수
    , CEIL(ABS(HIRE_DATE - SYSDATE)) 근무일수
FROM EMPLOYEE;

-- 입사한 월의 근무일수
SELECT
    LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 COL1 -- ex) 29 ~ 31이면 29,30,31 하루 더 필요하므로 + 1
    ,HIRE_DATE 입사일
    ,LAST_DAY(HIRE_DATE) LDAY
FROM EMPLOYEE;

-- EXTRACT : 연, 월, 일 정보를 추출하여 리턴하는 함수
-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월만 추출
-- EXTRACT(DAY FROM 날짜) : 일만 추출
SELECT
    EXTRACT(YEAR FROM SYSDATE) 년도
    ,EXTRACT(MONTH FROM SYSDATE) 월
    ,EXTRACT(DAY FROM SYSDATE) 일
FROM DUAL;

-- EMPLOYEE 테이블에서 사원이름, 입사년, 입사월, 입사일 조회
SELECT
    EMP_NAME 사원이름
    ,EXTRACT(YEAR FROM HIRE_DATE) 입사년
    ,EXTRACT(MONTH FROM HIRE_DATE) 입사월
    ,EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE
--ORDER BY EMP_NAME;
--ORDER BY EMP_NAME DESC;
--ORDER BY 사원이름; -- 별칭으로도 가능
--ORDER BY 1; -- 이렇게 숫자로도 해도 됨 사원이름 의미
ORDER BY 2 ASC, 3 DESC;

-- EMPLOYEE 테이블에서 사원이름, 입사일, 근무년수를 조회 (단, 근무년수는 현재년도 - 입사년도로 조회)
SELECT
    EMP_NAME 사원이름
    , HIRE_DATE 입사일
    , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원이름, 입사일, 근무년수를 조회 (MONTHS_BETWEEN 으로 근무년수 조회)
SELECT
    EMP_NAME 사원이름
    , HIRE_DATE 입사일
    , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) 근무년수 -- 이렇게하면 오차가 있을 수 있음
FROM EMPLOYEE;


-- 형변환 함수
-- TO_CHAR(날짜, [포맷] ) : 날짜형 데이터를 문자형 데이터로 변환
-- TO_CHAR(숫자, [포맷] ) : 숫자형 데이터를 문자형 데이터로 변환

/*
Format		 예시			설명
,(comma)	9,999		콤마 형식으로 변환
.(period)	99.99		소수점 형식으로 변환
0		09999		왼쪽에 0을 삽입
$		$9999		$ 통화로 표시
L		L9999		Local 통화로 표시(한국의 경우 \)
9:자릿수를 나타내며 ,자릿수가 많지않아도 0으로채우지않는다
0:자릿수를나타내며, 자릿수가 많지 않을 경우 0으로 채워준다.
EEEE 과학 지수 표기법*/

SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, '00000') FROM DUAL;
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- Local 통화로 표시 \ 
SELECT TO_CHAR(1234, '$99,999') FROM DUAL;
SELECT TO_CHAR(1234, '00,000') FROM DUAL;
SELECT TO_CHAR(1234, '9.9EEEE') FROM DUAL;
SELECT TO_CHAR(1234, '999') FROM DUAL; -- 작으면 #### 이렇게 문제 생김

-- EMPLOYEE 테이블에서 사원명, 급여를 조회
-- 급여는 \9,000,000 형식으로 표시하세요
SELECT
    EMP_NAME 사원명
    ,TO_CHAR(SALARY, 'L99,999,999') 급여
FROM EMPLOYEE;
    

--날짜 데이터 포맷 적용
SELECT TO_CHAR(SYSDATE,'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MON DY,YYYY') FROM DUAL; -- DAY이면 월요일 이렇게 됨
SELECT TO_CHAR(SYSDATE,'YYYY-fmMM-DD DAY') FROM DUAL; -- 월앞에 0 제거하고 싶을때
SELECT TO_CHAR(TO_DATE('980630','RRMMDD'),'YYYY-fmMM-DD') FROM DUAL; -- 월앞에 0제거하고 싶을때 fm사용
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YEAR,Q')||'분기' FROM DUAL;


-- 제일 많이 쓰는 포맷
SELECT
    EMP_NAME
    , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일
FROM EMPLOYEE;
SELECT
    EMP_NAME
    , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS') 입사일
FROM EMPLOYEE;

SELECT CURRENT_TIMESTAMP FROM DUAL;

SELECT 
    TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS') VAL 
    , TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMMDDHH24MISS') VAL2 
FROM DUAL;


-- 오늘 날짜에 대해 년도 4자리, 2자리
-- 년도 이름으로 출력
SELECT 
    TO_CHAR(SYSDATE, 'YYYY')
    , TO_CHAR(SYSDATE, 'RRRR')
    , TO_CHAR(SYSDATE, 'YY')
    , TO_CHAR(SYSDATE, 'RR')
    , TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;


/* 
    RR과 YY차이
    RR은 두자리 년도를 네자리로 바꿀 때
    바꿀년도가 50년 미만인 경우 2000(현재세기)년대를 적용
    50년 이상이면 1900(이전세기)년대 적용
    
    TO_DATE 시 Y를 적용하면 2000년도 적용
*/ 
SELECT
    TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYY-MM-DD') VAL -- RR 2자리 연도를 50년 미만이면 20을 적용 50년이상이면 19를 적용
FROM DUAL;

SELECT
    TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYY-MM-DD') VAL
FROM DUAL;

-- 오늘 날짜에 월만 출력
SELECT
    TO_CHAR(SYSDATE, 'MM')
    , TO_CHAR(SYSDATE, 'MONTH')
    , TO_CHAR(SYSDATE, 'MON')
    , TO_CHAR(SYSDATE, 'RM') -- 로마문자 표기
FROM DUAL;

-- 오늘 날짜에 일만 출력
SELECT
    TO_CHAR(SYSDATE, '"1년 기준 "DDD"일째"')
    , TO_CHAR(SYSDATE, '"달 기준 "DD"일째"')
    , TO_CHAR(SYSDATE, '"주 기준 "D"일째"') -- 일요일이 1이라 월요일은 2
FROM DUAL;

-- 오늘 날짜에서 분기와 요일 출력 처리
SELECT
    TO_CHAR(SYSDATE, 'Q"분기"') -- 'Q"분기"Q' 이렇게도 쓸 수 있음
    , TO_CHAR(SYSDATE, 'DAY')
    , TO_CHAR(SYSDATE, 'DY')
FROM DUAL;