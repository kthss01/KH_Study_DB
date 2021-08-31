CREATE TABLE SQLD_30_11_01 (
    COL1 VARCHAR2(30),
    COL2 NUMBER
);

INSERT INTO SQLD_30_11_01 VALUES(1, 20);
INSERT INTO SQLD_30_11_01 VALUES(2, 30);
INSERT INTO SQLD_30_11_01 VALUES(3, 40);
INSERT INTO SQLD_30_11_01 VALUES('A', 50);

SELECT * FROM SQLD_30_11_01;

-- 보기 1만 테스트
SELECT A.COL1, A.COL2
FROM SQLD_30_11_01 A
WHERE A.COL1 > 0;