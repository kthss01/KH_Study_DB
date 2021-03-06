CREATE TABLE SQLD_34_33 (
    EMP_NAME VARCHAR(30)
);

INSERT INTO SQLD_34_33 VALUES ('Abc');
INSERT INTO SQLD_34_33 VALUES ('abc');
INSERT INTO SQLD_34_33 VALUES ('bc');

SELECT * FROM SQLD_34_33;

-- SQL 
SELECT *
FROM SQLD_34_33
WHERE EMP_NAME LIKE 'A%'; -- a는 안먹힘 구분없이 하려면 UPPER or LOWER 함수 사용

SELECT *
FROM SQLD_34_33
WHERE UPPER(EMP_NAME) LIKE 'A%';
