-- 직원관리 계정생성
CREATE USER EMPLOYEE IDENTIFIED BY EMPLOYEE;

GRANT RESOURCE, CONNECT TO EMPLOYEE;


--select * from nls_session_parameters
--        where PARAMETER in  ('NLS_LANGUAGE','NLS_DATE_FORMAT','NLS_DATE_LANGUAGE');

CREATE USER kh IDENTIFIED BY oracle;
GRANT CONNECT, RESOURCE TO kh;
SELECT username from dba_users;
SELECT username, account_status FROM dba_users WHERE username='KH';