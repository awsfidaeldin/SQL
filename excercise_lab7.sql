-- SOLUTION QUESTION#1
SET SERVEROUTPUT ON;

DECLARE
POSITION EMP.JOB%TYPE;
NAME DEPT.DNAME%TYPE;
BEGIN
SELECT JOB,DNAME
INTO POSITION,NAME
FROM EMP NATURAL JOIN DEPT
WHERE ENAME LIKE 'JAMES';
DBMS_OUTPUT.PUT_LINE('JOB: '||POSITION||' DEPARTMENT: '||NAME);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NO RELATED DATA');
END;

-- SOLUTION QUESTION#2
SET SERVEROUTPUT ON;
DECLARE
CURSOR CUR IS
  SELECT ENAME,JOB,DNAME
  FROM EMP,DEPT
  WHERE DEPT.DEPTNO=EMP.DEPTNO;
BEGIN
FOR I IN CUR
LOOP
  DBMS_OUTPUT.PUT_LINE(I.ENAME||' JOB IS ' || I.JOB || ' , ' ||'HE WORKS IN ' || I.DNAME);
END LOOP;
END;

-- SOLUTION QUESTION#3
SET SERVEROUTPUT ON;
DECLARE
  V_ENAME EMP.ENAME%TYPE;
  V_SAL EMP.SAL%TYPE;
  V_INC NUMBER(5,2):=0.05;
BEGIN
  UPDATE EMP
  SET SAL=SAL+(SAL*V_INC)
  WHERE ENAME LIKE 'JAMES';
  
  SELECT ENAME,SAL
  INTO V_ENAME,V_SAL
  FROM EMP
  WHERE ENAME LIKE 'JAMES';
  DBMS_OUTPUT.PUT_LINE('SAL AFTER INCREASE = '|| V_SAL);
END;

-- SOLUTION QUESTION#4
SET SERVEROUTPUT ON;
DECLARE
CURSOR CUR IS
  SELECT ENAME,SAL
  FROM EMP;
BEGIN
FOR I IN CUR
LOOP
  DBMS_OUTPUT.PUT_LINE(I.ENAME ||' HAS A SALARY OF ' || I.SAL||' USD');
  DBMS_OUTPUT.NEW_LINE;
END LOOP;
END;

-- SOLUTION QUESTION#5
SET SERVEROUTPUT ON;
DECLARE
DEPT_RECORD DEPT%ROWTYPE;
V_AVGSAL EMP.SAL%TYPE;

BEGIN
SELECT *
INTO DEPT_RECORD
FROM DEPT
WHERE LOC='DALLAS';

SELECT  ROUND(AVG(SAL))
INTO V_AVGSAL
FROM EMP
WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE LOC='DALLAS')
GROUP BY DEPTNO;

DBMS_OUTPUT.PUT_LINE('DEPTNO = '||DEPT_RECORD.DEPTNO);
DBMS_OUTPUT.PUT_LINE('DNAME = '||DEPT_RECORD.DNAME);
DBMS_OUTPUT.PUT_LINE('LOC = '||DEPT_RECORD.LOC);
DBMS_OUTPUT.PUT_LINE('DEPARTMENT AVERAGE SALARY = '||V_AVGSAL);

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
END;
