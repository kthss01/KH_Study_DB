DROP TABLE SQLD_34_50;

CREATE TABLE SQLD_34_50 (
    EMPLOYEE_ID NUMBER,
    DEPARTMENT_ID NUMBER,
    LAST_NAME VARCHAR(30),
    SALARY NUMBER
);

INSERT INTO SQLD_34_50 VALUES (100, 90, 'King', 24000);
INSERT INTO SQLD_34_50 VALUES (101, 90, 'Kochhar', 17000);
INSERT INTO SQLD_34_50 VALUES (102, 90, 'De Haan', 17000);
INSERT INTO SQLD_34_50 VALUES (103, 60, 'Hunold', 9000);
INSERT INTO SQLD_34_50 VALUES (104, 60, 'Ernst', 6000);
INSERT INTO SQLD_34_50 VALUES (105, 60, 'Austin', 4800);
INSERT INTO SQLD_34_50 VALUES (106, 60, 'Pataballa', 4800);
INSERT INTO SQLD_34_50 VALUES (107, 60, 'Lorentz', 4200);
INSERT INTO SQLD_34_50 VALUES (108, 100, 'Greenberg', 12000);
INSERT INTO SQLD_34_50 VALUES (109, 100, 'Faviet', 9000);

SELECT * FROM SQLD_34_50;

-- SQL 결과를 출력하는 SQL 문장 완성
-- LAG LEAD 이전행의 값을 찾거나 다음행의 값을 찾을 때 사용하는 함수
-- LAG 함수 : 이전 행의 값 리턴
-- LEAD 함수 : 다음 행의 값 리턴
-- LAG(SALARY, 2) offset 2란 얘기

SELECT EMPLOYEE_ID,
    DEPARTMENT_ID,
    LAST_NAME,
    SALARY,
    LAG(SALARY, 2) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS BEFORE_SALARY
FROM SQLD_34_50
WHERE EMPLOYEE_ID < 110;
