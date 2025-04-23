-- p194

drop database if exists sqldb;
create database sqldb;

use sqldb;

create table usertbl (
	userID char(8) not null primary key,	
	name varchar(10) not null,
    birthyear int not null,
    addr char(2) not null,
    mobile1 char(3),
    mobile2 char(8),
    height smallint,
    mdate DATE    
);

create table buytbl (
	num int auto_increment not null primary key,
    userid char(8) not null,
    prodname char(6) not null,
    groupname char(4),
    price int not null,
    amount smallint not null,
    FOREIGN KEY(userid) references usertbl(userid)
);


INSERT into usertbl values('lsg', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT into usertbl values('kbs', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT into usertbl values('kkh', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
INSERT into usertbl values('jyp', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
INSERT into usertbl values('ssk', '성시경', 1979, '서울', null, 		null, 186, '2013-12-12');
INSERT into usertbl values('ljb', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT into usertbl values('yjs', '윤종신', 1969, '경남', null, 		null, 170, '2005-5-5');
INSERT into usertbl values('ejw', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT into usertbl values('jkw', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT into usertbl values('bbk', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');

INSERT into buytbl values(null, 'kbs', '운동화', null, 30, 2);
INSERT into buytbl values(null, 'kbs', '노트북', '전자', 1000, 1);
INSERT into buytbl values(null, 'jyp', '모니터', '전자', 200, 1);
INSERT into buytbl values(null, 'bbk', '모니터', '전자', 200, 5);
INSERT into buytbl values(null, 'kbs', '청바지', '의류', 50, 3);
INSERT into buytbl values(null, 'bbk', '메모리', '전자', 80, 10);
INSERT into buytbl values(null, 'ssk', '책',	   '서적', 15, 5);
INSERT into buytbl values(null, 'ejw', '책', 	'서적', 15, 2);
INSERT into buytbl values(null, 'ejw', '청바지', '의류', 50, 1);
INSERT into buytbl values(null, 'bbk', '운동화', null, 30, 2);
INSERT into buytbl values(null, 'ejw', '책', 	'서적', 15, 1);
INSERT into buytbl values(null, 'bbk', '운동화', null, 30, 2);

SELECT * from usertbl;
SELECT * from buytbl;

SELECT * from usertbl where name = '김경호';

SELECT userid, name from usertbl where birthyear >= 1970 and height >= 182;

SELECT userid, name from usertbl where birthyear >= 1970 or height >= 182;

SELECT name, height from usertbl where height >= 180 and height <=183;
SELECT name, height from usertbl where height between 180 and 183;

select name, addr from usertbl where addr= '경남' or addr = '전남' or addr='경북';

select name, addr from usertbl where addr in('경남', '전남', '경북');

select name, height from usertbl where name like '김%';
select name, height from usertbl where name like '_종신';

select name, height from usertbl where height > 177;

select name, height from usertbl 
where height > (SELECT height from usertbl where name = '김경호');

select name, height from usertbl 
where height >= any (SELECT height from usertbl where addr = '경남');

select name, height from usertbl 
where height >= all (SELECT height from usertbl where addr = '경남');

select name, height from usertbl 
where height = any (SELECT height from usertbl where addr = '경남');

select name, height from usertbl 
where height in (SELECT height from usertbl where addr = '경남');

SELECT name, mdate from usertbl order by mdate;
SELECT name, mdate from usertbl order by mdate desc;


SELECT name, mdate from usertbl order by mdate desc, name asc;
select addr from usertbl;
select addr from usertbl order by addr;

select distinct addr from usertbl; -- 중복 제외

use employees;
select emp_no, hire_date from employees
order by hire_date asc;
    
select emp_no, hire_date from employees
order by hire_date asc limit 5;

select emp_no, hire_date from employees
order by hire_date asc limit 0, 5;

use sqldb;
create table buytbl2 (select * from buytbl);
select * from buytbl2;

create table buytbl3 (select userid, prodname from buytbl);
select * from buytbl3 ;

SELECT userid, amount from buytbl order by userid;
SELECT userid, sum(amount) from buytbl group by userid;

SELECT userid as '사용자 아이디', sum(amount) as '총 구매 개수' 
from buytbl group by userid;

SELECT userid as '사용자 아이디', sum(price*amount) as '총 구매액' 
from buytbl group by userid;

SELECT avg(amount) as '평균 구매 개수' from buytbl;

SELECT userid, avg(amount) as '평균 구매 개수' from buytbl group by userid;

SELECT name, max(height), min(height) from usertbl GROUP BY name;

SELECT name, height from usertbl
where height = (select max(height) from usertbl) or
	height = (select min(height) from usertbl);
    
select count(*) from usertbl;
select count(mobile1) as '휴대폰이 있는 사용자' from usertbl;

select userid as '사용자', sum(price*amount) as '총구매액'
from buytbl GROUP BY userid;

/* select userid as '사용자', sum(price*amount) as '총구매액'
from buytbl where sum(price*amount)>1000 
GROUP BY userid; 에러 뜨는 구문*/ 


select userid as '사용자', sum(price*amount) as '총구매액'
from buytbl 
GROUP BY userid
having sum(price*amount)>1000 ;

SELECT num, groupname, sum(price*amount) as '비용'
from buytbl
group by groupname, num with rollup;

select groupname, sum(price*amount) as '비용'
from buytbl group by groupname with rollup;

create table testtbl1 (id int, username char(3), age int);
insert into testtbl1 values (1, '홍길동', 25);

insert into testtbl1(id, username) values (2, '설현');

insert into testtbl1(username, age, id) values ('하니', 26,3);

create table testtbl2 (id int AUTO_INCREMENT primary key, 
	username char(3), age int);

insert into testtbl2 values (NULL, '지민', 25);
insert into testtbl2 values (NULL, '유나', 22);
insert into testtbl2 values (NULL, '유경', 21);

SELECT * from testtbl2;



alter table testtbl2 AUTO_INCREMENT=100;
insert into testtbl2 values (NULL, '현미', 23);

create table testtbl3 (id int AUTO_INCREMENT primary key, 
	username char(3), age int);
    
alter table testtbl3 AUTO_INCREMENT=1000;
set @@auto_increment_increment=3;

insert into testtbl3 values (NULL, '나연', 20); -- 두번들어감
insert into testtbl3 values (NULL, '정연', 18);
insert into testtbl3 values (NULL, '모모', 19);

SELECT * from testtbl3;

create table testtbl4 (id int, fname varchar(50), lname VARCHAR(50));
insert into testtbl4 
	select emp_no, first_name, last_name
    from employees.employees;

create table testtbl5 (
	select emp_no, first_name, last_name
    from employees.employees);

select * from testtbl4;
update testtbl4 
set lname = '없음' 
where fname = 'Kyoichi';

select * from testtbl4 where fname = 'Kyoichi';
-- p224 까지 했음

use sqldb;
update buytbl set price = price * 1.5 ;