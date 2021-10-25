CREATE TABLE SQLD_30_42_01 (
    COL1 VARCHAR(10),
    COL2 VARCHAR(10),
    COL3 NUMBER
);

CREATE TABLE SQLD_30_42_02 (
    COL1 VARCHAR(10),
    COL2 VARCHAR(10),
    COL3 NUMBER
);

INSERT INTO SQLD_30_42_01 VALUES('A', 'X', 1);
INSERT INTO SQLD_30_42_01 VALUES('B', 'Y', 2);
INSERT INTO SQLD_30_42_01 VALUES('C', 'Z', 3);
INSERT INTO SQLD_30_42_01 VALUES('X', 'T', 1);

INSERT INTO SQLD_30_42_02 VALUES('A', 'X', 1);
INSERT INTO SQLD_30_42_02 VALUES('B', 'Y', 2);
INSERT INTO SQLD_30_42_02 VALUES('C', 'Z', 3);
INSERT INTO SQLD_30_42_02 VALUES('D', '가', 4);
INSERT INTO SQLD_30_42_02 VALUES('E', '나', 5);

SELECT * FROM SQLD_30_42_01;
SELECT * FROM SQLD_30_42_02;

COMMIT;

MERGE INTO SQLD_30_42_01 A
USING SQLD_30_42_02 B
    ON (A.COL1 = B.COL1)
WHEN MATCHED THEN
    UPDATE SET A.COL3 = 4
        WHERE A.COL3 = 2
    DELETE WHERE A.COL3 <= 2
WHEN NOT MATCHED THEN
    INSERT (A.COL1, A.COL2, A.COL3) VALUES (B.COL1, B.COL2, B.COL3);
    
ROLLBACK;

