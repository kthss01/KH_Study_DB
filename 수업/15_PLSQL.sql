-- PL/SQL (PROCEDURE LANGUAGE EXTENSION TO SQL)
-- 오라클 자체에 내장된 절차적 언어
-- SQL의 단점을 보완하여 SQL문장 내에서
-- 변수의 정의, 조건처리, 반복처리, 예외처리 등을 지원한다.

-- PL/SQL의 장점
-- BLOCK구조로 다수의 SQL문을 한 번에 ORACLE DB로 보내 처리하므로 수행 속도 향상
-- 단순, 복잡한 데이터 형태의 변수 및 테이블의 데이터 구조와 컬럼 명에 준하여 동적으로 변수 선언 가능

-- PL/SQL 구조
-- 선언부, 실행부, 예외처리부로 구성되어 있음
-- 선언부 : DECLARE로 시작, 변수나 상수를 선언하는 부분
-- 실행부 : BEGIN으로 시작, 제어문, 반복문, 함수의 정의등 로직 작성
-- 예외처리부 : EXCEPTION으로 시작, 예외처리 내용 작성

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;
/

-- SET SERVEROUTPUT ON을 실행시켜줘야 출력. 기본은 OFF
SET SERVEROUTPUT ON;

--1. DECLARE 선언부
-- 변수 및 상수 선언해 놓는 공간 (초기화도 가능)
-- 일반타입 변수, 레퍼런스 타입 변수, ROW 타입 변수 

--1-1) 일반타입 변수 선언 및 초기화
--[표현법] 
-- 변수명 [CONSTANT] 자료형(크기) [:=값];

DECLARE
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
BEGIN
    EMP_ID := '888';
    EMP_NAME := '배장남';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
END;
/

-- 1-2) 레퍼런스타입 변수 선언 및 초기화 (어떤 테이블의 어떤 컬럼의 데이터 타입을 참조해서 그 타입으로 지정)
-- [표현법] 변수명 테이블명.컬럼명%TYPE;

DECLARE
    EMP_IDA EMPLOYEE.EMP_ID%TYPE;
    EMP_NAMEA EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT
        EMP_ID,
        EMP_NAME
    INTO 
        EMP_IDA,
        EMP_NAMEA
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_IDA);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAMEA);
END;
/

--SELECT
--    *
--FROM EMPLOYEE
--WHERE EMP_ID = '&EMP_ID'; -- 그냥 쿼리문에도 쓸 수 있음

-- 레퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE,SALARY
-- 를 선언 하고 , EMPLOYEE 테이블에서 사번,이름, 직급코드, 부서코드, 급여를 조회하여
-- 선언한 레퍼런스 변수에 담아 출력하세요 
-- 단, 입력받은 이름과 일치하는 조건의 직원을 조회하세요 

DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
    DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
    JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT
        EMP_ID, 
        EMP_NAME, 
        JOB_CODE, 
        DEPT_CODE, 
        SALARY
    INTO
        EMP_ID, 
        EMP_NAME, 
        JOB_CODE, 
        DEPT_CODE, 
        SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&EMP_NAME';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
END;
/


--1_3) 한행에 대한 타입변수선언
--[표현법] 변수명 테이블명 %ROWTYPE;
-- 테이블의 한행의 모든 컬럼과 자료형을 참조하는 경우 사용

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';

    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || EMP.DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || EMP.JOB_CODE);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || EMP.SALARY);
END;
/

--2. BEGIN 
--조건문 
--1) IF 조건식 THEN 실행내용 END IF;(단일IF문)

-- 사번을 입력받은 후 해당사원의 사번, 이름 , 급여 , 보너스 율(%) 출력하기 
-- 단, 보너스를 받지않는 사원은 보너스율 출력전 '보너스를 지급받지않는 사원입니다 ' 출력
-- 사번 : 200 , 201

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;    
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY || '원');
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS*100 || '%');
END;
/

--2) IF 조건식 THEN 실행내용 ELSE 실행내용 END IF;(IF~ELSE문)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;    
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY || '원');
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS*100 || '%');
    END IF;
END;
/


-- IF ~ ELSIF ~ ELSE ~ END IF
-- 점수를 입력받아 SCORE 변수에 저장하고 
-- 90점 이상은 'A', 80점 이상은 'B', 70점 이상은 'C'
-- 60점 이사은 'D' , 60 점 미만은 'F' 로 조건 처리하여 
-- GRADE 변수에 저장하여 
--' 당신의 점수는 90 점이고 , 학점은 A 학점 입니다.' 형태로 출력하세요 

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(10);
BEGIN
    SCORE := '&점수';
    
    IF (SCORE >= 90) THEN GRADE := 'A';
    ELSIF (SCORE >= 80) THEN GRADE := 'B';
    ELSIF (SCORE >= 70) THEN GRADE := 'C';
    ELSIF (SCORE >= 60) THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || ' 점이고, 학점은 ' || GRADE || ' 학점 입니다.');
END;
/



-- CASE  비교대상자 
-- WHEN 동등 비교할 값1 THEN 결과값1 
-- WHEN 동등 비교할 값2 THEN 결과값2 
-- ELSE 결과값 
-- END;


-- 사번을 입력하여 해당상원의 사번 ,이름 , 부서명 출력
