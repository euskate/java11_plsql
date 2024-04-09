# 1. PL/SQL 의 개념

PL/SQL (Oracle’s Procedural Language extension to SQL) 은 SQL의 확장된 개념으로 ORACLE에서 지원하는 프로그래밍 언어의 특성을 수용한 SQL의 확장이며, PL/SQL Block내에서 SQL의 DML(데이터 조작어)문과 Query(검색어)문, 절차형 언어(if, loop)등을 사용하여 절차적 프로그래밍을 가능하게 한 강력한 트랜잭션 언어이다.

<br><br>
-----------------------------------------------------------
<br><br>

# 2. PL/SQL의 특징
- Oracle의 PL/SQL은 Block 구조로 되어있고 Block 내에는 DML 문장과 QUERY 문장, 그리고 절차형 언어(IF, LOOP) 등을 사용할 수 있으며, 절차적 프로그래밍을 가능하게 하는 트랜잭션 언어입니다. 이런 PL/SQL을이용하여 다양한 저장 모듈(Stored Module)을 개발할 수 있습니다.

- 저장 모듈(Stored Module)이란 PL/SQL 문장을 데이터베이스 서버에 저장하여 사용자와 애플리케이션 사이에서 공유할 수 있도록 만든 일종의 SQL 컴포넌트 프로그램이며, 독립적으로 실행되거나 다른 프로그램으로부터 실행될 수 있는 완전한 실행 프로그램입니다.

- Oracle의 저장 모듈에는 Procedure, User Defined Function, Trigger가 있습니다.

- PL/SQL은 Block 구조로 되어있어 각 기능별로 모듈화가 가능합니다.

- 변수, 상수 등을 선언하여 SQL 문장간 값을 교환합니다.

- IF, LOOP 등의 절차형 언어를 사용하여 절차적인 프로그램이 가능하도록 합니다.

- DBMS 정의 에러나 사용자 정의 에러를 정의하여 사용할 수 있습니다.

- PL/SQL은 Oracle에 내장되어 있으므로 Oracle과 PL/SQL을 지원하는 어떤 서버로도 프로그램을 옮길 수 있습니다.

- PL/SQL은 응용 프로그램의 성능을 향상시킵니다.

- PL/SQL은 여러 SQL 문장을 Block으로 묶고 한 번에 Block 전부를 서버로 보내기 때문에 통신량을 감소시킬 수 있습니다.

<br><br>
-----------------------------------------------------------
<br><br>

# 3. PL/SQL의 기본 구조

선언부(DECLARE) -> 시작(BEGIN) -> 예외부(EXCEPTION) -> 종료(END)

| 명령 | 설명 |
|------------|--------------------------------------------|
| DECLARE |  BEGIN ~ END 절에서 사용될 변수와 인수에 대한 정의 및 데이터 타입을 선언하는 선언부 |
| BEGIN ~ END | 개발자가 처리하고자 하는 SQL 문과 여러 가지 비교문, 제어문을 이용하여 <br> 필요한 로직을 처리하는 실행부 |
| EXCEPTION |  BEGIN ~ END 절에서 실행되는 SQL 문이 실행될 때 에러가 발생하면 그 에러를<br> 어떻게 처리할 것이지를  정의하는 예외 처리부 |

<br><br>

## 3-1. 변수 및 상수 선언

### 3-1-1. 변수 선언

```
[IS | DECLARE]
    변수명 데이터타입 : = 초기값;
```

```sql
DECLARE
    EX_NUM NUMBER  := 1;
    EX_STR VARCHAR2(10) := 'STR1';
```

<br>

### 3-1-2. 상수 선언

```
[IS | DECLARE]
    상수명 CONSTRANT 데이터타입 : = 상수값;
```

```sql
DECLARE
    EX_PI CONSTANT NUMBER  := 3.14159;
```

<br>

### 3-1-3. 변수 및 상수의 출력문

```sql
-- DBMS_OUTPUT.PUT_LINE 명령으로 출력시에는 반드시 ON 하여야 합니다.
SET SERVEROUTPUT ON; 
```

```sql
DECLARE
    EX_NUM CONSTANT NUMBER := 10; --상수 선언
    EX_STR VARCHAR2(10); --변수 선언

BEGIN
    EX_STR := 'EXAMPLE'; --변수 초기값 설정
    DBMS_OUTPUT.PUT_LINE(EX_NUM); --상수 출력
    DBMS_OUTPUT.PUT_LINE(EX_STR); --변수 출력
END;
```

<br>

### 3-1-4. 변수 및 상수의 연산


| 연산자 | 용도 |
|-----------------------------|------------------------|
 **	| 제곱 연산자 |
| +, -, *, / | 덧셈, 뺄셈, 곱셈, 나눗셈 연산자 |
| =, <, >, <=, >=, <>, !=, ~=, ^=, 	| 비교 연산자 |
| IS NULL, LIKE, BETWEEN, IN | 오라클 함수 연산자 |
| NOT, AND, OR | 논리 연산자 |

```sql
DECLARE
    VN_NUM NUMBER :=1;
    VN_NUM2 NUMBER :=2;
BEGIN
    DBMS_OUTPUT.PUT_LINE(VN_NUM +  VN_NUM2); 
END;
```

<br>

### 3-1.5. 타입의 선언

- 변수명 컬럼명%TYPE : 해당 컬럼의 데이터 타입을 가져와 변수에 같은 데이터 타입 적용
- 변수명 테이블명%ROWTYPE : 해당 레코드 전체의 구조를 가져와 변수에 같은 레코드셋 타입 적용
- TYPE 레코드타입명 IS RECORD(컬럼1 컬럼타입,...) : 연산할 레코드셋 타입을 지정
  

<br><br>

## 3-2. PL/SQL의 객체

### 3-2-1. 익명의 프로시저(Procedure)

- 이름없이 사용되는 PL/SQL 블록으로 컴파일 즉시 실행된다.

<br>

### 3-2-2. 저장되는 일반적인 프로시저(Procedure)

- 생성 이후에 DB에 프로시저 객체의 형태로 저장되며, 종료 문장(END;) 이후에 /(슬래시)를 반드시 포함하여 실행해야 한다.
- 매개변수를 포함할 수 있지만, 반환(Return)이 허용되지 않는다.
- 실행시에는 EXEC 명령을 활용하여야 하며, 매개변수가 있을 경우는 반드시 지정한 개수만큼 값을 지정해야 한다.

<br>

### 3-2-3. 저장되는 일반적인 함수(Function)

- 생성 이후에 DB에 함수 객체의 형태로 저장되며, 종료 문장(END;) 이후에 /(슬래시)를 반드시 포함하여 실행해야 한다.
- 매개변수를 포함할 수 있지만, 반환(Return)이 허용된다.
- 실행시에는 SELECT 명령과 같은 DML을 활용할 수 있으며, 매개변수가 있을 경우는 반드시 지정한 개수만큼 값을 지정해야 한다.

<br>

### 3-2-4. 패키지(Package)

- 특정 업무에 사용되는 프로시저 또는 함수를 묶어 생성하여 관리하는 PL 객체

<br>

### 3-2-5. 트리거(Trigger)

- 테이블 생성시 지정하며, 지정된 이벤트 발생시 자동적으로 호출되어 실행되는 특수한 형태의 프로시저
- DB의 감시, 보안, 연속적 오퍼레이션의 자동처리 구현시 활용된다.

<br>

## 3-3. 객체(PROCEDURE, FUNCTION, PACKAGE, TRIGGER)의 생성

```sql
CREATE OR REPLACE 객체종류 객체명[(매개변수 매개변수타입)]
IS | DECLARE
    선언문장;
BEGIN    
    실행문장;
END [객체명];    
```

<br>

## 3-4. 객체(PROCEDURE, FUNCTION, PACKAGE, TRIGGER)의 제거

```sql
-- 프로시저 삭제
DROP PROCEDURE 프로시저명;

-- 함수 삭제
DROP FUNCTION 함수명;

-- 패키지 본문만 삭제
DROP PACKAGE BODY 패키지명;

-- 패키지 정의부와 본문 모두 삭제
DROP PACKAGE 패키지명;

-- 트리거 삭제
DROP TRIGGER 트리거명;
```

<br>

## 3-5. 객체(PROCEDURE, FUNCTION, PACKAGE, TRIGGER)의 기타 명령

```sql
-- 프로시저 조회
SELECT * FROM USER_SOURCE WHERE TYPE='PROCEDURE' AND NAME='프로시저이름';

-- 함수 조회
SELECT * FROM USER_SOURCE WHERE TYPE='FUNCTION' AND NAME='함수이름';

-- 패키지 조회
SELECT * FROM USER_SOURCE WHERE TYPE='PACKAGE' AND NAME='패키지이름';

-- 트리거 비활성화
ALTER TRIGGER 트리거명 DISABLE;

-- 트리거 활성화
ALTER TRIGGER 트리거명 ENABLE;

-- 트리거 상태 확인
select table_name, status from user_triggers;
```

<br><br>
-----------------------------------------------------------
<br><br>


# 4. 기본 조건문, 반복문 문법

## 4-1. 조건문

### 4-1-1. 단순 IF 

```
IF 조건 THEN
   처리문장;
END IF;
```

<br>

### 4-1-2. IF~ELSE~ 

```
IF 조건 THEN
   조건만족시처리문장;
ELSE
   조건불만족시처리문장;
END IF;
```

<br>

### 4-1-3. IF~ELSIF~ELSE~

```
IF 조건 THEN
   처리문장1;
ELSIF 조건2 THEN
   처리문장2;
   ...
ELSE
   처리문장n;
END IF;
```

<br>

### 4-1.4. IF 예시 코드

```sql
DECLARE
  VN_NUM1 NUMBER := 10;
  VN_NUM2 NUMBER := 20;
BEGIN
  IF VN_NUM1 >= VN_NUM2 THEN
     DBMS_OUTPUT.PUT_LINE(VN_NUM1 || '이 큰 수');
  ELSE
     DBMS_OUTPUT.PUT_LINE(VN_NUM2 || '이 큰 수');
  END IF;
END;
```


```sql
DECLARE
  VN_SALARY         NUMBER := 0;
  VN_DEPARTMENT_ID  NUMBER := 0;
BEGIN
  VN_DEPARTMENT_ID := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
  
  SELECT  SALARY
  INTO    VN_SALARY
  FROM    EMPLOYEES
  WHERE   DEPARTMENT_ID = VN_DEPARTMENT_ID
  AND     ROWNUM = 1;
  
  DBMS_OUTPUT.PUT_LINE(VN_SALARY);
  
  IF  VN_SALARY BETWEEN 1 AND 3000 THEN
      DBMS_OUTPUT.PUT_LINE('낮음');
  ELSIF VN_SALARY BETWEEN 3001 AND 6000 THEN
      DBMS_OUTPUT.PUT_LINE('중간');
  ELSIF VN_SALARY BETWEEN 6001 AND 10000 THEN
      DBMS_OUTPUT.PUT_LINE('높음');
  ELSE
      DBMS_OUTPUT.PUT_LINE('최상위');
  END IF;
END;
```

```sql
DECLARE
  VN_SALARY         NUMBER := 0;
  VN_DEPARTMENT_ID  NUMBER := 0;
  VN_COMMISSION     NUMBER := 0;
BEGIN
  VN_DEPARTMENT_ID := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
  
  SELECT  SALARY, COMMISSION_PCT
  INTO    VN_SALARY, VN_COMMISSION
  FROM    EMPLOYEES
  WHERE   DEPARTMENT_ID = VN_DEPARTMENT_ID
  AND     ROWNUM = 1;
  
  DBMS_OUTPUT.PUT_LINE(VN_SALARY);
  
  IF  VN_COMMISSION > 0 THEN
      IF  VN_COMMISSION > 0.15 THEN
          DBMS_OUTPUT.PUT_LINE(VN_SALARY * VN_COMMISSION);
      END IF;
  ELSE
      DBMS_OUTPUT.PUT_LINE(VN_SALARY);
  END IF;
END;
```

<br>

### 4-1-5. CASE 

```
CASE  표현식
      WHEN  결과1 THEN
            처리문1;
      WHEN  결과2 THEN
            처리문2;
      ...
      ELSE
            기타 처리문;
END CASE;
```

```
CASE  WHEN  표현식1  THEN
            처리문1;
      WHEN  표현식2  THEN
            처리문2;
      ...
      ELSE
            기타 처리문;
END CASE;
```

<br>

### 4-1-6. CASE 예시 코드

```sql
DECLARE
  VN_SALARY         NUMBER := 0;
  VN_DEPARTMENT_ID  NUMBER := 0;
BEGIN
  VN_DEPARTMENT_ID := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);
  
  SELECT  SALARY
  INTO    VN_SALARY
  FROM    EMPLOYEES
  WHERE   DEPARTMENT_ID = VN_DEPARTMENT_ID
  AND     ROWNUM = 1;
  
  DBMS_OUTPUT.PUT_LINE(VN_SALARY);
  
  CASE  WHEN  VN_SALARY BETWEEN 1 AND 3000  THEN
              DBMS_OUTPUT.PUT_LINE('낮음');
        WHEN  VN_SALARY BETWEEN 3001 AND 6000 THEN
              DBMS_OUTPUT.PUT_LINE('중간');
        WHEN  VN_SALARY BETWEEN 6001 AND 10000  THEN
              DBMS_OUTPUT.PUT_LINE('높음');
        ELSE
              DBMS_OUTPUT.PUT_LINE('최상위');
  END CASE;
END;
```

<br><br>

## 4-2. 반복문

### 4-2-1. LOOP 문

```
LOOP
    반복처리문장;
    EXIT [조건];
END LOOP;
```

<br>

### 4-2-2. LOOP 예시 코드

```sql
DECLARE
NUM1 NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM1); --출력
        NUM1 := NUM1+1; --NUM = NUM +1
        EXIT WHEN NUM1 >10; --NUM1이 10보다 크면 LOOP종료
    END LOOP;
END;
```

<br>

### 4-2-3. WHILE 문

```
WHILE 조건 LOOP
    반복처리문장;
END LOOP;
```

<br>

### 4-2-4. WHILE 예시코드

```sql
DECLARE
NUM1 NUMBER :=1;
BEGIN
    WHILE(NUM1<10) LOOP
        DBMS_OUTPUT.PUT_LINE(NUM1); --출력
        NUM1 := NUM1+1; --NUM = NUM +1
    END LOOP;
END;
```

<br>

### 4-2-5. FOR 문

```
FOR 증감변수 IN 초기값..최종값 LOOP
    처리문장;
END LOOP;
```

<br>

### 4-2-6. FOR 예시코드

```sql
BEGIN
    FOR i IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE('안녕하세요'); 
    END LOOP;
END;
```


<br><br>
-----------------------------------------------------------
<br><br>

# 5. 익명의 프로시저 작성 문법

```

```

## 5-1. 기본 문법

```
DECLARE
    선언문장;
BEGIN
    실행문장;
END;    
```

<br>

## 5-2. 익명의 프로시저 예시코드

```sql
-- 단순 변수값 출력
DECLARE  
    vnum NUMBER;
    vname VARCHAR2(20);
BEGIN
    vnum := 100; --변수값을 저장하기 위해서는 := 를 사용한다.
    vname := '홍길동';
    DBMS_OUTPUT.PUT_LINE(vnum || ',' || vname);
END;
```

```sql
-- 특정 레코드 출력
DECLARE
    TYPE firsttype IS RECORD(a emp.ename%TYPE, b emp.pos%TYPE, 
    c emp.salary%TYPE);
cus1 firsttype;
BEGIN
    SELECT ename, pos, salary INTO cus1 FROM emp where eno=2001;
    DBMS_OUTPUT.PUT_LINE('***********************************************');
    DBMS_OUTPUT.PUT_LINE(cus1.a || CHR(10) || cus1.b || CHR(10) || cus1.c);
    DBMS_OUTPUT.PUT_LINE('현재 계정 : ' || USER);
    DBMS_OUTPUT.PUT_LINE('현재 질의 시간 : ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:SS'));
END;
```

```sql
-- 익명의 프로시저를 활용하여 사원(emp) 테이블로 부터 사원번호 2002인 직원의
-- 사원번호, 사원명, 직급, 주소, 입사일을 출력하시오.
-- (단, 입사일은 연도 네 자리-월 두 자리-일 두 자리 형태로 출력될 수 있도록 할 것.)
DECLARE
    sawon emp%ROWTYPE;
BEGIN
    SELECT * INTO sawon FROM emp where eno=2002;
    DBMS_OUTPUT.PUT_LINE('***********************************************');
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || sawon.eno);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || sawon.ename);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || sawon.pos);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || sawon.addr);
    DBMS_OUTPUT.PUT_LINE('입사일 : ' || TO_CHAR(sawon.regdate, 'YYYY-MM-DD'));
END;
```

```sql
-- 사원(emp) 테이블로 부터 사원명(ename), 직급(pos) 컬럼의 모든 사원을 출력하시오.
DECLARE
    TYPE ename_type IS TABLE OF emp.ename%TYPE INDEX BY BINARY_INTEGER;
    TYPE pos_type IS TABLE OF emp.pos%TYPE INDEX BY BINARY_INTEGER;
    ename_col ename_type;
    pos_col pos_type;
    i BINARY_INTEGER := 0;
BEGIN
    FOR k IN(SELECT ename, pos FROM emp) LOOP
        i := i + 1;
        ename_col(i) := k.ename;
        pos_col(i) := k.pos;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('******************');
    DBMS_OUTPUT.PUT_LINE('사원명      직급');
    DBMS_OUTPUT.PUT_LINE('******************');
    FOR j IN 1..i LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(ename_col(j), 12) || RPAD(pos_col(j), 10));
    END LOOP;    
END;
```

<br><br>
-----------------------------------------------------------
<br><br>

# 6. 프로시저 작성 및 실행 문법

## 6-1. 프로시저 기본 문법

```
CREATE OR REPLACE PROCEDURE 프로시저 이름( 매개변수명1[ IN | OUT | IN OUT ] 데이터타입[:= 디폴트값],
      매개변수명2[ IN | OUT | IN OUT ] 데이터타입[:= 디폴트값], ... )
  IS[AS]
      변수, 상수 등 선언;
  BEGIN
      실행문장;
  [EXCEPTION 예외처리부]
END [프로시저 이름];
/
```

```sql
-- 실행문장
EXEC 프로시저명(매개변수값);
```

<br>

## 6-2. 프로시저 예시 코드

```sql
-- 사원번호(eno)와 급여(salary)를 매개변수로 입력받아 해당 사원의 급여를 갱신하는 프로시저(update_pay)를 작성하여라
CREATE OR REPLACE PROCEDURE update_pay(u_eno IN NUMBER, u_salary IN NUMBER)
IS
BEGIN
    UPDATE emp SET salary=u_salary WHERE eno = u_eno;
    COMMIT;
END update_pay;
/
```

```sql
-- 컴파일된 프로시저를 실행
EXEC update_pay(2001, 5000000);
EXEC update_pay(2006, 2800000);
select * from emp;
```

```sql
-- 사원번호(eno)와 직급(pos), 주소(addr)를 입력 받아 갱신하는 프로시저(update_emp)를 작성하고,
-- 임의의 데이터로 3건 이상 실행하도록 하시오.
CREATE OR REPLACE PROCEDURE update_emp(u_eno IN NUMBER, u_pos IN emp.pos%TYPE, u_addr IN emp.addr%TYPE)
IS
BEGIN
    UPDATE emp SET pos=u_pos,addr=u_addr WHERE eno = u_eno;
    COMMIT;
END update_emp;
/
```

```sql
-- update_emp 프로시저 실행
EXEC update_emp(2004, '부장', '서울 강동구');
EXEC update_emp(2002, '과장', '서울 강남구');
EXEC update_emp(2003, '대리', '부산 해운대구');

select * from emp;
```

<br><br>
-----------------------------------------------------------
<br><br>

# 7. 함수 작성 및 실행 문법

## 7-1. 함수 작성 기본 문법

```
CREATE OR REPLACE FUNCTION 함수 이름 (매개변수1, 매개변수2....)
    RETURN 데이터 타입;
    IS[AS]
        변수, 상수 선언..
    BEGIN
        실행부
        RETURN 반환값
        [EXCEPTION 예외처리부]
END [함수 이름];
/
```
<br>

## 7-2. 함수 작성 예시 코드

```sql
-- 사원번호(eno)를 매개변수로 입력받아 특정 직원의 세금(3.3%)을 계산하여 출력하는 함수(tax_fnc)를 작성하고 실행하시오.
-- 임의로 3건의 실행문을 실행하고, 그 결과를 출력하시오.
CREATE OR REPLACE FUNCTION tax(v_eno IN emp.eno%TYPE)
RETURN NUMBER
IS
    v_tax NUMBER;
BEGIN
    SELECT (salary+NVL(bonus, 0))*0.033 INTO v_tax FROM emp WHERE eno = v_eno;
    RETURN v_tax;
END tax;    
/
```

```sql
-- tax 함수 실행 방법1
select tax(2003) as "세금" from dual;

-- tax 함수 실행 방법2
select distinct tax(2003) as "세금" from emp;
select tax(2003) as "세금" from emp where eno = 2003;
```

<br>

```sql
-- 직급(pos)을 매개변수로 입력 받아 해당 직급별 급여 총액, 평균 급여, 인원수를 출력하는 
-- 프로시저(tot_emp)를 작성하시오.
CREATE OR REPLACE PROCEDURE tot_emp(v_pos IN VARCHAR2)
IS
    a NUMBER :=0;
    b NUMBER(12,2):=0;
    c NUMBER:=0;
BEGIN
    SELECT SUM(salary+NVL(bonus,0)), AVG(salary+NVL(bonus,0)), COUNT(*) INTO a,b,c
    FROM emp WHERE pos=v_pos;
    DBMS_OUTPUT.PUT_LINE(v_pos || '의 급여 집계');
    DBMS_OUTPUT.PUT_LINE('급여 총액 : ' || a || '원');
    DBMS_OUTPUT.PUT_LINE('평균 급여 : ' || b || '원');
    DBMS_OUTPUT.PUT_LINE('인원수 : ' || c || '명');
END tot_emp;
/
```

```sql
-- tot_emp 함수 실행
EXEC tot_emp('사원');
EXEC tot_emp('대리');
EXEC tot_emp('과장');
EXEC tot_emp('부장');
```

<br><br>
-----------------------------------------------------------
<br><br>

# 8. 커서(CURSOR) 작성 문법

- SELECT 또는 DML과 같은 SQL의 컬럼의 결과셋(ResultSet)을 저장하여 필요한 곳에서 활용하기 위한 저장소

## 8-1. 명시적 커서(EXPLICIT CURSOR)

### 8-1-1. 명시적 커서 기본 문법

- 선언(DECLARATION) -> 열기(OPEN) -> 반복읽기(FETCH) -> 닫기(CLOSE) 과정으로 전개되는 커서

```
DECLARE	
    CURSOR [커서이름] IS [SELECT 구문];
    BEGIN	
        OPEN [커서이름];	
        FETCH [커서이름] INTO [로컬변수];	
        CLOSE [커서이름];
    END;
```

<br>

### 8-1-2. 명시적 커서의 조건 속성

- %ROWCOUNT : 현재까지 반환된 모든 행의 수를 출력
- %FOUND : FETCH한 데이터가 행을 반환하면 TRUE
- %NOTFOUND : FETCH한 데이터가 행을 반환하지 않으면 TRUE (LOOP를 종료할 시점을 찾는다)   
- %ISOPEN : 커서가 OPEN되어있으면 TRUE


<br>

### 8-1-3. 명시적 커서 예시 코드

```sql
DECLARE    
    CURSOR emp_cur 
    IS    
    SELECT * FROM emp WHERE DEPTNO = 10;    
    emp_rec emp%ROWTYPE; 
    BEGIN    
        OPEN emp_cur;    
        LOOP 
            FETCH emp_cur INTO emp_rec; 
            EXIT WHEN emp_cur%NOTFOUND; 
            DMBS_OUTPUT.PUT_LINE(emp_rec.empno || ' ' || emp_rec.name);
        END LOOP;    
        CLOSE emp_cur;
    END;
```

<br><br><br>

## 8-2. 묵시적 커서(IMPLICIT CURSOR)

- 선언(DECLARATION) -> 반복 루프(FOR/LOOP/WHILE...) 등으로 전개되는 커서

### 8-2-1. 묵시적 커서 기본 문법

```
DECLARE
    CURSOR 커서명 
    IS    
    SELECT 명령문;
    BEGIN    
        FOR 저장객체명 IN 커서명 LOOP
            실행문장; 
        END LOOP;
    END;
```

<br>

### 8-2-2. 묵시적 커서 예시 코드

```sql
DECLARE
    CURSOR ID_LIST 
    IS    
    SELECT 'GOD' AS USER_ID FROM DUAL;
    BEGIN    
        FOR TEST_CURSOR IN ID_LIST LOOP
            DBMS_OUTPUT.putline(TEST_CURSOR.USER_ID);    
        END LOOP;
    END;
```

<br><br>
-----------------------------------------------------------
<br><br>

# 9. 트리거 작성 문법

- 특정 상황이나 동작 등을 이벤트라고 할 때, 이벤트가 발생하면, 연쇄 동작으로 해당 기능을 자동으로 처리해주는 서브 프로그램의 일종

## 9-1. 트리거 기본 문법

```
CREATE [OR REPLACE] TRIGGER 트리거명 
[BEFORE | AFTER] insert | delete | update ON 테이블명
[FOR EACH ROW]
[WHEN (condition)]
DECLARE
    변수선언문장;
BEGIN
    실행문장
EXCEPTION
END;
```

<br>

## 9-2. 트리거 예시 코드

```sql
-- 입고시의 재고 처리 : 입고(store) 테이블에 새로운 레코드가 추가되면, 재고는 증가된다.
-- 만약, 현재 해당 상품의 재고가 없으면, 새로운 상품으로 재고를 처리하고,
-- 해당 상품에 기존에 존재하면, 그 제품의 수량과 단가를 적용하여 재고를 처리할 수 있도록 구현할 것.
-- 트리거 이름 : store_trigger
-- 재고의 단가 : 입고시 원래 가격의 40%의 마진율
CREATE OR REPLACE TRIGGER store_trigger
AFTER INSERT ON store 
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        INSERT INTO inventory VALUES (:NEW.pno, :NEW.amount, :NEW.price*1.4);
    ELSE
        UPDATE inventory SET amount=amount+:NEW.amount, price=:NEW.price*1.4 
        WHERE pno=:NEW.pno;
    END IF;    
END;
/
```

```sql
-- 트리거 발생 이전에 검색
select * from inventory;
-- 입고 처리
INSERT INTO store VALUES(100,2,2500);
-- 재고 처리 : store_trigger에 의해 자동 처리됨
-- 트리거 발생 이후에 검색
select * from inventory;
COMMIT;

INSERT INTO store VALUES(100,3,2500);
INSERT INTO store VALUES(200,4,2000);
ROLLBACK
```

<br>

```sql
-- 출고시의 재고 처리 : 출고(release) 테이블에 새로운 레코드가 추가되면, 재고는 감소된다.
-- 만약, 현재 해당 상품이 모두 출고 되면, 해당 상품의 재고 정보를 삭제하고,
-- 해당 상품이 출고되고도 잔존하면, 그 제품의 수량을 적용하여 재고를 처리할 수 있도록 구현할 것.
-- 트리거 이름 : release_trigger
CREATE OR REPLACE TRIGGER release_trigger
AFTER INSERT ON release 
FOR EACH ROW
DECLARE
    vcnt NUMBER;
BEGIN
    SELECT amount-:NEW.amount INTO vcnt FROM inventory WHERE pno=:NEW.pno;
    IF (vcnt=0) THEN
        DELETE FROM inventory WHERE pno=:NEW.pno;
    ELSE
        UPDATE inventory SET amount=amount-:NEW.amount WHERE pno=:NEW.pno;
    END IF;    
END;
/
```

```sql
-- 트리거 발생 전 테이블 검색
select * from inventory;
-- 출고 테이블의 레코드 추가로 인해 트리거 발생
INSERT INTO release VALUES(100,3,(SELECT price FROM inventory WHERE pno=100));
-- 트리거 발생 후 테이블 검색
select * from inventory;
```


<br><br>
-----------------------------------------------------------
<br><br>

# 10. PL/SQL 내장 함수

## 10-1. 문자열 관련 내장 함수

| 내장함수 | 함수 설명 |
|---------------------------|------------------------------------------------------|
| NVL(컬럼명,NULL인 경우 대체할 값) | 해당 컬럼의 값이 null 일 경우 특정 값으로 대체 |
| LOWER(컬럼명) | 해당 컬럼의 값을 모두 소문자로 변경 |
| UPPER(컬럼명) | 해당 컬럼의 값을 모두 대문자로 변경 |
| INITCAP(컬럼명) | 해당 컬럼의 값을 첫 글자만 대문자 나머지는 소문자로 변경 |
| CONCAT(컬럼명1,컬럼명2) | 해당 문자열이나 컬럼명을 문자열 더하기하여 반환 |
| LENGTH(컬럼명) | 해당 컬럼의 글자수를 반환 |
| LENGTHB(컬럼명) | 해당 컬럼의 바이트수를 반환 |
| LPAD(컬럼명, 출력자리수, '채울 문자열') | 해당 컬럼의 데이터로 채우고 남은 자리를 채울 문자열로 왼쪽에 채움 |
| RPAD(컬럼명, 출력자리수, '채울 문자열') | 해당 컬럼의 데이터로 채우고 남은 자리를 채울 문자열로 오른쪽에 채움 |
| INSTR(컬럼명,'찾을 문자열') | 해당 컬럼에서 찾을 문자열을 찾아 위치를 반환 |
| SUBSTR(컬럼명, 시작, 글자수) | 해당 컬럼에서 시작위치 부터 글자수 만큼 추출 |
| REPLACE(컬럼명,'찾을 문자열','바꿀 문자열') | 해당 컬럼에서 찾을 문자열을 찾아 바꿀 문자열로 변환 |
| TO_CHAR(컬럼명, 형식) | 해당 컬럼을 지정한 날짜로 출력 |
| TO_NUMBER(컬럼명) | 해당 컬럼의 문자형 숫자를 숫자로 변환 |
| TRIM(컬럼명) | 앞 뒤의 공백 문자를 제거하여 반환 |


<br>

## 10-2. 날짜 관련 내장 함수

| 내장함수 | 함수 설명 |
|---------------------------|------------------------------------------------------|
| SYSDATE | 현재 날짜와 시간을 반환 |
| TO_DATE(컬럼명) | 문자열을 날짜 데이터로 변환 |
| MONTHS_BETWEEN (나중날짜,먼저날짜) | 흐른 특정 개월 수 반환 |
| ADD_MONTHS(날짜,숫자) | 특정 날짜에 개월 수 더한 날짜 반환 |

<br>

## 10-3. 숫자 관련 내장 함수

| 내장함수 | 함수 설명 |
|---------------------------|------------------------------------------------------|
| ROUND(실수) | 소숫점 이하 반올림하여 정수로 반환 |
| FLOOR(실수) | 소숫점 이하 버림하여 정수로 반환 |
| CEIL(실수) | 소숫점 이하 올림하여 정수로 반환 |
| MOD(피젯수,젯수) | 피젯수를 젯수로 나눈 나머지 반환 |
| POWER(정수,승수) | 정수를 승수만큼 거듭제곱한 수 반환 |
| SQRT(정수) | 정수의 제곱근을 구하여 반환 |


<br><br>
-----------------------------------------------------------
<br><br>

