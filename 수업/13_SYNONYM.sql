-- 동의어 (SYNONYM)
-- 다른 데이터 베이스가 가진 객체에 대한 별명 혹은 줄임말
-- 여러사용자가 테이블을 공유할경우
-- 다른 사용자가 테이블에 접근할경우 사용자명.테이블명 으로 표현함
-- 동의어를 사용하면 간단하게 접근 가능
-- 삭제 : DROP SYNONYM EMP;
SELECT * FROM USER_SYNONYMS;
SELECT * FROM DBA_SYNONYMS WHERE SYNONYM_NAME = 'EMP'; -- 시스템계정에서 찾아볼 때

-- 생성방법
--CREATE SYNONYM 줄임말 FOR 사용자명.객체명;

-- SYNONYM 권한 주기
GRANT CREATE SYNONYM TO EMPLOYEE; -- 시스템계정에서 권한주고 오기

CREATE SYNONYM EMP FOR EMPLOYEE; -- 동의어란 폴더에 들어감
SELECT * FROM EMP;

-- 동의어의 구분
--1. 비공개 동의어
-- 객체에대한 접근 권한을 부여 받은 사용자가 정의한 동의어
--2. 공개 동의어
-- 모든 권한을 주는 사용자(DBA)가 정의한 동의어
-- 모든 사용자가 사용할수 있음 (PUBLIC)
-- 예) DUAL

-- 시스템 계정에서 테스트
SELECT * FROM EMP; -- 시스템계정에서 에러 발생 비공개 동의어이기 때문에 EMPLYOEE 계정에서만 사용 가능
SELECT * FROM EMPLOYEE.DEPARTMENT; -- 계정명.테이블명
--SELECT * FROM EMPLOYEE.EMP; -- 이건 됨

CREATE PUBLIC SYNONYM DEPT FOR EMPLOYEE.DEPARTMENT;

SELECT * FROM DEPT; -- 직원, 시스템 둘다 조회됨