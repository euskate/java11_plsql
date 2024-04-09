SET SERVEROUTPUT ON;

-- 커서(CURSOR) : SELECT 또는 DML과 같은 SQL의 한 컬럼의 결과셋(ResultSet)을 저장하여 필요한 곳에서 활용하기 위한 객체 
--      선언(DECLARATION) -> 열기(OPEN) -> 반복읽기(FETCH) -> 닫기(CLOSE) : 명시적 커서
--      선언(DECLARATION) -> 반복 루프(FOR/LOOP/WHILE...) : 묵시적 커서

-- 명시적 커서(EXPLICIT CURSOR) : 선언 -> 열기 -> 읽기 -> 닫기 등의 순서로 이루어지는 커서

select * from emp;

CREATE OR REPLACE PROCEDURE emp_prt1(vpno IN emp.pno%TYPE)
IS
    CURSOR cur_pno IS SELECT pno, ename, pos, salary FROM emp WHERE pno=vpno;
vppo emp.pno%TYPE;
vename emp.ename%TYPE;
vpos emp.pos%TYPE;
psal emp.salary%TYPE;
BEGIN
    OPEN cur_pno;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('부서코드  사원명  직급  급여');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    LOOP
        FETCH cur_pno INTO vppo, vename, vpos, psal;
        EXIT WHEN cur_pno%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(vppo || '  ' || vename || '  ' || vpos || '  ' || psal);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('전체 건수 : ' || cur_pno%ROWCOUNT);
    CLOSE cur_pno;
END;
/

EXEC emp_prt1(40);

-- 묵시적 커서(IMPLICIT CURSOR) : 열기나 읽기, 닫기의 별도 구문없이 반복문만 활용하는 커서
CREATE OR REPLACE PROCEDURE emp_prt2(vpno IN emp.pno%TYPE)
IS
    CURSOR cur_pno IS SELECT pno, ename, pos, salary FROM emp WHERE pno=vpno;
vcnt NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('부서코드  사원명  직급  급여');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    FOR cur IN cur_pno LOOP 
       DBMS_OUTPUT.PUT_LINE(cur.pno || '  ' || cur.ename || '  ' || cur.pos || '  ' || cur.salary);
       vcnt := cur_pno%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('전체 건수 : ' || vcnt);
END;
/
EXEC emp_prt2(10);

-- 직속코드(SUPERIOR)를 매개변수로 입력받아 입력한 직속코드에 속한 직원의 
-- 사원번호(eno), 사원명(ename), 직급(pos), 급여(salary) 를 출력하는 cur_super
-- 묵시적 커서(IMPLICIT CURSOR)를 생성하시오.
CREATE OR REPLACE PROCEDURE cur_super(vsup IN emp.superior%TYPE)
IS
    CURSOR cur_data IS SELECT eno, ename, pos, salary FROM emp WHERE superior=vsup;
vcnt NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE('사원번호  사원명  직급  급여');
    DBMS_OUTPUT.PUT_LINE('**********************************');
    FOR cur IN cur_data LOOP 
       DBMS_OUTPUT.PUT_LINE(RPAD(cur.eno,9) || RPAD(cur.ename,8) || RPAD(cur.pos,7) || RPAD(cur.salary,10));
       vcnt := cur_data%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************************');
    DBMS_OUTPUT.PUT_LINE(vsup || '가 직속상관인 사원수 : ' || vcnt);
END;
/
EXEC cur_super(2004);


-- 패키지(PACKAGE) : 여러 개의 프로시저 또는 함수 등을 하나의 그룹으로 묶은 묶음.
-- 패키지 선언부(PACKAGE DECLARATION)
CREATE OR REPLACE PACKAGE emp_pack
IS
    PROCEDURE eno_out;
    PROCEDURE ename_out;
    PROCEDURE pno_out;
    PROCEDURE pos_out;
END emp_pack;    
/

-- 패키지 기능 정의부(PACKAGE DEFINE OF FUNCTION)
CREATE OR REPLACE PACKAGE BODY emp_pack 
IS
    CURSOR sw_cur IS SELECT * FROM emp;
    
    PROCEDURE eno_out
    IS
    BEGIN
       DBMS_OUTPUT.PUT_LINE('사원번호');
       DBMS_OUTPUT.PUT_LINE('--------');
       FOR k IN sw_cur LOOP 
          DBMS_OUTPUT.PUT_LINE(k.eno);
       END LOOP;
    END eno_out;
    PROCEDURE ename_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('사원명');
        DBMS_OUTPUT.PUT_LINE('------');
        FOR k IN sw_cur LOOP 
            DBMS_OUTPUT.PUT_LINE(k.ename);
        END LOOP;
    END ename_out;
    PROCEDURE pno_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('부서번호');
        DBMS_OUTPUT.PUT_LINE('------');
        FOR k IN sw_cur LOOP
            DBMS_OUTPUT.PUT_LINE(k.pno);
        END LOOP;
    END pno_out;
    PROCEDURE pos_out
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('직급');
        DBMS_OUTPUT.PUT_LINE('----');
        FOR k IN sw_cur LOOP 
            DBMS_OUTPUT.PUT_LINE(k.pos);
        END LOOP;
    END pos_out;
END;
/
EXEC emp_pack.ename_out;


-- 트리거(TRIGGER) : 