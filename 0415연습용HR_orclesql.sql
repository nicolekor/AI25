SELECT employee_id, first_name, last_name from employees;

SELECT employee_id, first_name, last_name FROM employees 
ORDER BY employee_id DESC;

SELECT job_id FROM employees;

SELECT DISTINCT job_id FROM employees; 

SELECT employee_id as 사원번호, first_name as 이름 FROM employees 
ORDER BY employee_id DESC;

SELECT employee_id 사원번호, first_name 이름 
FROM employees 
ORDER BY employee_id DESC;

SELECT employee_id, first_name || ' ' || last_name fullname FROM employees;

SELECT employee_id, first_name || last_name || '@' || 'company.com' email FROM employees;

SELECT employee_id, salary, salary+5000, salary -100, salary*1.1/2 FROM employees;

SELECT * FROM employees where employee_id = 100;

SELECT * FROM employees where first_name = 'David';

SELECT* FROM employees where employee_id >= 105;

SELECT * FROM employees where salary >= 10000 and salary <= 20000;
select * from employees where salary between 10000 and 20000;

select * from employees where salary in (10000, 17000, 24000);

select * from employees where job_id like 'AD%';

-- 주석

select * from employees where job_id like 'AD___';

select * from employees where manager_id is null;

select * from employees where salary >= 4000 and job_id = 'IT_PROG';

select * from employees where salary >= 4000 
and job_id = 'IT_PROG' 
or job_id = 'FI_ACCOUNT';

select * from employees where employee_id <> 105;

select  
last_name, 
lower(last_name) 소문자, 
upper(last_name) 대문자, 
email,
initcap(email) INITCAP from employees;

select sysdate, hire_date, months_between(sysdate, hire_date) 적용결과 
from employees where department_id = 100;

select salary * nvl(commission_pct, 1)
from employees order by commission_pct;

select first_name, last_name, department_id, salary 원래급여, 
decode(department_id, 60, salary*1.1, salary) 조정급여, 
decode(department_id, 60, '10% 인상', '미인상') 인상여부 from employees;


select employee_id, first_name, last_name, salary,
    case 
        when salary >=9000 then '상위급여'
        when salary between 6000 and 8999 then '중위급여'
        else '하위급여'
    end as 급여등급
from employees
where job_id='IT_PROG';

select employee_id, salary, 
    rank() over(order by salary desc) rank_급여,
    dense_rank() over(order by salary desc) dense_rank_급여,
    row_number() over(order by salary desc) row_number_rank_급여
from employees;

select count(salary) salary행수
from employees; 


select sum(salary) salary_sum, 
        round(sum(salary) / count(salary)) salary_avg
from employees;

select max(salary) sal_max, 
        min(salary) sal_min,
        max(first_name) name_max,
        min(first_name) name_min
from employees;

SELECT job_id 직무, SUM(salary) 직무별_총급여, AVG(salary) 직무별_평균급여
FROM employees
WHERE employee_id >= 10
GROUP BY job_id
HAVING SUM(salary) > 30000
ORDER BY 직무별_총급여 DESC, 직무별_평균급여;

--250417
select a.employee_id, a.department_id, b.department_name, c.location_id, c.city 
from employees A, departments B, locations C;

select a.employee_id, a.department_id, b.department_name, c.location_id, c.city 
from employees A, departments B, locations C
where a.department_id = b.department_id
and b.location_id = c.location_id;

select a.employee_id, a.first_name, a.last_name, b.department_id, b.department_name 
from employees A, departments B
where a.department_id = b.department_id(+) 
order by a.employee_id;

select a.employee_id, a.first_name, a.last_name, a.manager_id, b.first_name||' '||b.last_name manager_name
from employees A, employees B
where a.manager_id = b.employee_id
order by a.employee_id;

select department_id
from employees
union -- 중복안됌
select department_id
from departments;

select department_id
from employees
union all -- 중복됌
select department_id
from departments;

select department_id
from employees
INTERSECT
select department_id
from departments;

select department_id
from departments
MINUS
select department_id
from employees;


select *
from employees A
where a.salary in ( 
                 select salary 
                 from employees
                 where last_name = 'Taylor'
                );    


select *
from employees A
where A.salary IN (
    select min(salary) 최저급여
    from employees
    group by department_id
)
order by a.salary desc;


-- 다중열
select *
from employees A
where (A. job_id, A.salary) IN (
    select job_id, min(salary) 그룹별_급여
    from employees
    group by job_id
)
order by a.salary desc;

select *
from employees A, (
    select department_id
    from departments
    where department_name='IT'
    ) B
where A.department_id = B.department_id;


insert into departments (department_id, department_name, manager_id, location_id)
       values(271, 'Sample_Dept', 200, 1700);
       
select * from departments;     

SELECT * FROM departments WHERE department_id = 271;

UPDATE departments
SET manager_id = 114,
    location_id = 2900
WHERE department_id = 271;

SELECT * FROM departments WHERE department_id = 271;

delete from departments
where department_name = 'Sample_Dept';


--250418
create table sample_product( 
    product_id number,
    product_name varchar2(30),
    manu_date date
    );

select * from sample_product;
insert into sample_product values(1, 'television', to_date('140101', 'YYMMDD'));


insert into sample_product values(2, 'washer', to_date('150101', 'YYMMDD'));
insert into sample_product values(3, 'cleaner', to_date('160101', 'YYMMDD'));

DELETE FROM sample_product
WHERE ROWID IN (
    SELECT ROWID
    FROM (
        SELECT ROWID
        FROM sample_product
        WHERE product_name = 'washer'
        ORDER BY ROWID DESC
    )
    WHERE ROWNUM = 1
);

alter table sample_product add (factory VARCHAR2(10));

alter table sample_product modify (factory VARCHAR2(20));

alter table sample_product rename COLUMN factory to factory_name;

truncate table sample_product;

drop table sample_product;

create table grades (
    student_id varchar2(4) primary key, -- primary key로 설정하면 중복데이터 입력 안됌, PK 설정하면 무조건 인덱스를 설정한다
    korean number(3),
    english number(3),
    math number(3)
    );
    
select * from grades;

insert into grades values(1111, 90, 80, 70);


create table dept_fk(
deptno number(2) PRIMARY key,
dname varchar(14),
loc varchar(13)
);

CREATE TABLE emp_fk(
empno number(4),
ename varchar2(10),
job varchar2(9),
mgr varchar2(4),
hirdate date,
sal number(7,2),
comm number(7,2),
deptno number(2) CONSTRAINT empfk_deptno_fk PRIMARY key REFERENCES dept_fk (deptno)
);


drop table dept_fk;
DROP TABLE dept_fk CASCADE CONSTRAINTS;

drop table emp_fk;

CREATE TABLE dept_fk (
    deptno NUMBER(2) PRIMARY KEY,  -- 중복불가능
    dname VARCHAR2(14),
    loc   VARCHAR2(13)
);

CREATE TABLE emp_fk (
    empno    NUMBER(4) PRIMARY KEY,
    ename    VARCHAR2(10),  
    deptno   NUMBER(2)    -- 중복가능
);

ALTER TABLE emp_fk
ADD CONSTRAINT empfk_deptno_fk
FOREIGN KEY (deptno)
REFERENCES dept_fk(deptno);

insert into dept_fk values(11, '김재우', '수원');



insert into emp_fk values(1111, '메롱', 11);
insert into emp_fk values(1112, '잘되지', 11);


select * from dept_fk;

select * from emp_fk;












