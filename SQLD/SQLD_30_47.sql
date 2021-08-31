CREATE TABLE SQLD_30_47 (
    COL1 VARCHAR2(30),
    COL2 NUMBER
);

INSERT INTO SQLD_30_47 VALUES('ABCD', NULL);
INSERT INTO SQLD_30_47 VALUES('CD', NULL);
ALTER TABLE SQLD_30_47 MODIFY COL2 DEFAULT 10;
INSERT INTO SQLD_30_47 VALUES('XY', NULL); -- 이거 null 로 들어감
INSERT INTO SQLD_30_47 (COL1) VALUES('EXD');

SELECT SUM(COL2) FROM SQLD_30_47;

SELECT * FROM SQLD_30_47;
