-- 시퀀스(SEQUENCE)
-- 자동 번호 발생기 역할을 하는 객체
-- 순차적으로 정수값을 자동으로 생성해줌
/*
  CRAETE SEQUENCE 시퀀스이름
  [START WITH 숫자] -- 처음 발생시킬 값 지정, 생략하면 자동 1 기본
  [INCREMENT BY 숫자] -- 다음 값에 대한 증가치, 생략하면 자동 1 기본
  [MAXVALUE 숫자 | NOMAXVALUE] -- 발생시킬 최대값 지정(10의 27승)
  [MINVALUE 숫자 | NOMINVALUE] -- 최소값 지정 (-10의 26승)
  [CYCLE | NOCYCLE]  -- 값순환 여부
  [CACHE 바이트크기 | NOCACHE] -- 캐시사용여부 (기본값은 20바이트, 최소는 2바이트)
  
  /*
  1 2 3 4 5   --> 시퀀스 
  12345 678910 --> 캐쉬는 미리 생성되어있음 
  1 2 3  11 -->껏다키고 다시 시작하면 캐쉬 생성된 다음 인 11 부터 시작 
  */
  
CREATE SEQUENCE SEQ_EMPID -- SEQ_EMPID 시퀀스 객체 생성
START WITH 300            -- 시작번호 300부터
INCREMENT BY 5            -- 5씩 증가
MAXVALUE 310              -- 최대 310
NOCYCLE                   -- 310 이후에는 증가하지 않고 에러 발생 알림
NOCACHE;                  -- 캐쉬 사용 안함
  
  -- NEXTVAL, CURRVAL
  -- CURRVAL: 현재값을 반환 -- 현재값을 생성한 후에 조회해야함 (시퀀스 생성 후 바로 조회하려고 하면 에러 발생) -> NEXTVAL 한번 해야하는거 같음
  -- NEXTVAL: 현재 시퀀스의 다음값을 반환
  
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 그냥 돌리면 에러, 시작값이 없으므로 NEXTVAL을 무조건 한번 실행한 후 CURRVAL 실행
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- NEXTVAL 한번 돌리면 300이됨
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- MAXVALUE 값 넘어서서 에러발생 CURRVAL은 310으로 되어있음


SELECT * FROM SYS.USER_SEQUENCES; -- 딕셔너리도 있다고함


-- 시퀀스 변경
-- START WITH 는 변경 불가능 - 변경하고자 한다면 DROP (삭제) 후 다시 생성
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

DROP SEQUENCE SEQ_EMPID;

CREATE SEQUENCE SEQ_EMPID -- SEQ_EMPID 시퀀스 객체 생성
START WITH 900            -- 시작번호 900부터
INCREMENT BY 1            -- 1씩 증가
MAXVALUE 1000             -- 최대 1000
NOCYCLE                   -- 310 이후에는 증가하지 않고 에러 발생 알림
NOCACHE;                  -- 캐쉬 사용 안함

-- NEXTVAL, CURRVAL 을 사용할 수 있는 경우
--> 서브 쿼리가 아닌 SELECT문
--> INSERT문의 SELECT 절
--> INSERT문의 VALUE 절
--> UPDATE문의 SET 절

-- NEXTVAL, CURRVAL 을 사용할 수 없는 경우
-- 서브쿼리의 SELECT문에서 사용 불가
-- VIEW의 SELECT절에서 사용 불가
-- DISTINCT 키워드가 있는 SELECT문에서 사용 불가
-- GROUP BY , HAVING절이 있는 SELECT문에서 사용 불가
-- ORDER BY 절에서 사용 불가
-- CREATE TABLE, ALTER TABLE의 DEFAULT값으로 사용 불가


CREATE TABLE SEQ_TEST (   
    NO NUMBER PRIMARY KEY, 
    NAME NVARCHAR2(20) NOT NULL, 
    AGE NUMBER NOT NULL
);

CREATE SEQUENCE SEQ_TEST_NO
START WITH 1
INCREMENT BY 1
MAXVALUE 100
NOCYCLE
NOCACHE;

SELECT * FROM SEQ_TEST;

INSERT INTO SEQ_TEST VALUES (SEQ_TEST_NO.NEXTVAL, '홍길동', 20);
INSERT INTO SEQ_TEST VALUES (SEQ_TEST_NO.NEXTVAL, '유재석', 30);

