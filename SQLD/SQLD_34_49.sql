CREATE TABLE SQLD_34_49 (
    COL1 CHAR(1)
);

INSERT INTO SQLD_34_49 VALUES ('A');
INSERT INTO SQLD_34_49 VALUES ('B');
INSERT INTO SQLD_34_49 VALUES ('C');
INSERT INTO SQLD_34_49 VALUES ('D');
INSERT INTO SQLD_34_49 VALUES ('E');
INSERT INTO SQLD_34_49 VALUES ('F');
INSERT INTO SQLD_34_49 VALUES ('G');
INSERT INTO SQLD_34_49 VALUES ('H');
INSERT INTO SQLD_34_49 VALUES ('I');
INSERT INTO SQLD_34_49 VALUES ('J');

SELECT * FROM SQLD_34_49;

-- SQL 결과를 보고 SQL 문장 완성
-- NTILE 특정 기준으로 ROW 분할 NTILE(4) 4 구간으로 분할 10개면 2,2,2,2 한후 앞에 하나씩 -> 3,3,2,2
SELECT VAL, COUNT(*) AS CNT
FROM (
    SELECT NTILE(4) OVER (ORDER BY COL1) AS VAL
    FROM SQLD_34_49
    )
WHERE 1=1
GROUP BY VAL
ORDER BY 1;