CREATE TABLE SQLD_34_19 (
    N1 NUMBER,
    N2 NUMBER,
    C1 VARCHAR(10),
    C2 VARCHAR(10)
);

INSERT INTO SQLD_34_19 VALUES (1, NULL, 'A', NULL);
INSERT INTO SQLD_34_19 VALUES (2, 1, 'B', 'A');
INSERT INTO SQLD_34_19 VALUES (4, 2, 'D', 'B');
INSERT INTO SQLD_34_19 VALUES (5, 4, 'E', 'D');
INSERT INTO SQLD_34_19 VALUES (3, 1, 'C', 'A');

SELECT * FROM SQLD_34_19;

-- 보기 1
SELECT C1, C2, N1, N2 FROM SQLD_34_19 WHERE N1=4 START WITH N2 IS NULL CONNECT BY PRIOR N1 = N2;
-- 2
SELECT C1, C2, N1, N2 FROM SQLD_34_19 START WITH C2 = 'B' CONNECT BY PRIOR N1 = N2 AND C2 <> 'D';
-- 3
SELECT C1, C2, N1, N2 FROM SQLD_34_19 START WITH C1 = 'B' CONNECT BY PRIOR N1 = N2 AND PRIOR C2 = 'B';
-- 4
SELECT C1, C2, N1, N2 FROM SQLD_34_19 WHERE C1 <> 'B' START WITH N1 = 2 CONNECT BY PRIOR N1 = N2 AND PRIOR N1 = 2;
