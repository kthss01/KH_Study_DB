
---------------------------------------------------------
DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE MEMBER;

DROP SEQUENCE SEQ_UNO;
DROP SEQUENCE SEQ_BNO;
DROP SEQUENCE SEQ_RNO;

--------------------------------------------------
--------------     MEMBER ����	------------------	
--------------------------------------------------

CREATE TABLE MEMBER (
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(30) NOT NULL UNIQUE,
  USER_PWD VARCHAR2(100) NOT NULL,
  USER_NAME VARCHAR2(15) NOT NULL,
  EMAIL VARCHAR2(100),
  BIRTHDAY VARCHAR2(6),
  GENDER VARCHAR2(1) CHECK (GENDER IN('M', 'F')),
  PHONE VARCHAR2(13),
  ADDRESS VARCHAR2(100),
  ENROLL_DATE DATE DEFAULT SYSDATE,
  MODIFY_DATE DATE DEFAULT SYSDATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N'))
);

CREATE SEQUENCE SEQ_UNO NOCACHE;

INSERT INTO MEMBER 
VALUES (SEQ_UNO.NEXTVAL, 'admin', '1234', '������', 'admin@kh.or.kr', '800918', 'F', '010-1111-2222', '����� ������ ���ﵿ', '20191201', '20191201', DEFAULT);

INSERT INTO MEMBER 
VALUES (SEQ_UNO.NEXTVAL, 'user01', 'pass01', '���缮','user01@kh.or.kr', '900213', 'M','010-3333-4444', '����� ��õ�� ��', '20200301', '20200301', DEFAULT);

COMMIT;



----------------------------------------------------
-----------------     BOARD ����        ------------------	
----------------------------------------------------

CREATE TABLE BOARD(
  BOARD_NO NUMBER PRIMARY KEY, 
  BOARD_TITLE VARCHAR2(100) NOT NULL,
  BOARD_CONTENT VARCHAR2(4000) NOT NULL,
  BOARD_WRITER NUMBER,
  COUNT NUMBER DEFAULT 0,
  CREATE_DATE DATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
  FOREIGN KEY (BOARD_WRITER) REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_BNO NOCACHE;

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, 'ù��° �Խ��� ���񽺸� �����ϰڽ��ϴ�.', '�ȳ��ϼ���. ù �Խ����Դϴ�.', 1, DEFAULT, '20191210', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '�ι�° �Խ��� ���񽺸� �����ϰڽ��ϴ�.', '�ȳ��ϼ���. 2 �Խ����Դϴ�.', 2, DEFAULT, '20200320', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '���� ���긮�� �Խ��� ���񽺸� �����ϰڽ��ϴ�.', '�ȳ��ϼ���. 3 �Խ����Դϴ�.', 1, DEFAULT, '20200321', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '�ȳ�.. ���̹�Ƽ���� ó������?', '�ȳ��ϼ���. ù �Խ����Դϴ�.', 2, DEFAULT, '20200322', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '��� ��������', '�ݰ����ϴ�.', 1, DEFAULT, '20200323',  DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '����¡ ó�������� ���õ����� ���� �־���´�...', '�ȳ��Ͻʴϱ�', 1, DEFAULT, '20200324', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '�Խ��� ����', '�ȳ��ϼ���. �Խ����Դϴ�.', 1, DEFAULT, '20200325', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '���õ����͵� ', '�ȳ��ϼ���.', 2, DEFAULT, '20200326', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '��ε� ȭ����!!', 'ȭ���� �ϼ���!!', 1, DEFAULT, '20200327', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '��������!!!', ' �Խ����Դϴ�.', 1, DEFAULT, '20200328', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '�Խ��� ����', '�����ӿ�ũ�� ó������?', 1, DEFAULT, '20200329', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '�����ϰڽ��ϴ�.', '���ݺ��� ����!!', 2, DEFAULT, '20200401', DEFAULT);

INSERT INTO BOARD 
VALUES(SEQ_BNO.NEXTVAL, '������ �Խ��� �����ϰڽ��ϴ�.', '�ȳ��ϼ���. ������ �Խ����Դϴ�.', 1, DEFAULT, '20200402', DEFAULT);



----------------------------------------------------
----------------    REPLY ����         -------------------	
----------------------------------------------------

CREATE TABLE REPLY(
  REPLY_NO NUMBER PRIMARY KEY,
  REPLY_CONTENT VARCHAR2(400),
  REF_BNO NUMBER,
  REPLY_WRITER NUMBER,
  CREATE_DATE DATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
  FOREIGN KEY (REF_BNO) REFERENCES BOARD,
  FOREIGN KEY (REPLY_WRITER) REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_RNO NOCACHE;

INSERT INTO REPLY
VALUES(SEQ_RNO.NEXTVAL, 'ù��° ����Դϴ�.', 1, 2, '20191225',  DEFAULT);

INSERT INTO REPLY
VALUES(SEQ_RNO.NEXTVAL, 'ù��° ����Դϴ�.', 13, 2, '20200412',  DEFAULT);

INSERT INTO REPLY
VALUES(SEQ_RNO.NEXTVAL, '�ι�° ����Դϴ�.', 13, 2, '20200413',  DEFAULT);

INSERT INTO REPLY
VALUES(SEQ_RNO.NEXTVAL, '������ ����Դϴ�.', 13, 2, '20200414',  DEFAULT);



COMMIT;

