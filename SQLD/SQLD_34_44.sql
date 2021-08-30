CREATE TABLE SQLD_34_44 (
    ID NUMBER,
    SUPER_ID NUMBER,
    CODE CHAR(1)
);

INSERT INTO SQLD_34_44 VALUES (1, NULL, 'A');
INSERT INTO SQLD_34_44 VALUES (2, 1, 'B');
INSERT INTO SQLD_34_44 VALUES (3, 1, 'C');
INSERT INTO SQLD_34_44 VALUES (4, 2, 'D');

SELECT * FROM SQLD_34_44;

-- SQL 문 , 두번째 나오는 값 구하기
SELECT CODE
FROM SQLD_34_44
START WITH SUPER_ID IS NULL
CONNECT BY PRIOR ID = SUPER_ID
ORDER SIBLINGS BY CODE DESC;