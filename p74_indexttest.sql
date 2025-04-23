use employees;

-- p74
create table indexTBL (
first_name varchar(14), last_name varchar(16), hire_date date);


insert into indexTBL
	select first_name, last_name, hire_date
	from employees
	limit 500;

select * from indexTBL;

select * from indexTBL where first_name = 'Mary'; -- 인덱싱이 안되어 있어서 전체 데이터에서 조회함

create index idx_indexTBL_firstname on indexTBL(first_name); -- 인덱스 생성


-- p81
use shopdb;
-- 뷰 생성 p80

select * from memberTbl where membername = '당탕이';
select * from producttbl where productid = '냉장고' ;

-- 2개를 각각 조회하기 귀찮으니깐 각 테이블에 있는 내용을 한번에 보고 싶다

create view uv_memberTBL as 
select membername, memberaddress from memberTBL;

select * from uv_memberTBL;

-- 프로시져 작업
delimiter $$

create procedure myproc2()
begin
	select * from memberTbl where membername = '당탕이';
    select * from producttbl where productid = '냉장고';
end $$

delimiter ; 

call myproc2() ;



-- p156
use employees;

select * from titles; 

-- p159

use shopdb;
create table test (id INT);
insert into test values(1);

use employees;
select * from employees;


use shopdb;

select * from memberTBL;

-- p183
-- 여러줄 주석 처리 = /* */
/* select select_expr
	from table_references
    where where_condition
    GROUP BY col_name | expr | position
    having where_condition
    order by col_name | expr | position ;*/
    
    
-- p 188
use employees;
SELECT * from employees.titles;
SELECT * from titles;

SELECT FIRST_name from employees;

SELECT FIRST_name, last_name, gender from employees;

show DATABASES;
DESCRIBE employees;
desc employees;

select FIRST_name, gender from employees;


    












