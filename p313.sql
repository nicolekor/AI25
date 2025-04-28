drop DATABASE if EXISTS shopdb;
drop DATABASE if EXISTS modeldb;

drop DATABASE if EXISTS tabledb;
create DATABASE tabledb;

CREATE TABLE `tabledb`.`usertbl` (
  `userid` CHAR(8) NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  `birthyear` INT NOT NULL,
  `addr` CHAR(2) NOT NULL,
  `mobile1` CHAR(3) NULL,
  `mobile2` CHAR(8) NULL,
  `height` SMALLINT NULL,
  `mdate` DATE NULL,
  `usertblcol` VARCHAR(45) NULL,
  PRIMARY KEY (`userid`));

drop table buytbl;

CREATE TABLE `tabledb`.`buytbl` (
  `num` INT NOT NULL AUTO_INCREMENT,
  `userid` CHAR(8) NOT NULL,
  `prodname` CHAR(6) NOT NULL,
  `groupname` CHAR(4) NULL,
  `price` INT NOT NULL,
  `amount` SMALLINT NOT NULL,
  PRIMARY KEY (`num`),
  FOREIGN KEY (userid) REFERENCES usertbl(userid)
  );
  
  DROP DATABASE tabledb;
  CREATE DATABASE tabledb;
  
  use tabledb;
  drop table if exists buytbl, usertbl;
  create table usertbl 
	(	userid char(8),
		name varchar(10),
        birthyear int,
        addr char(2),
        mobil1 char(3),
        mobil2 char(8),
        height smallint,
        mdate date    
    );
    
    create table buytbl
    (	num int,
		userid char(8),
        prodname char(6),
        groupname char(4),
        price int,
        amount smallint
	);
    
use tabledb;
  drop table if exists buytbl, usertbl;
  create table usertbl 
	(	userid char(8) not null PRIMARY KEY,
		name varchar(10) not null,
        birthyear int not null,
        addr char(2) not null,
        mobil1 char(3) null,
        mobil2 char(8) null,
        height smallint null,
        mdate date null    
    );
    
    drop table if EXISTS buytbl;
    create table buytbl
    (	num int AUTO_INCREMENT not null PRIMARY KEY,
		userid char(8) not null,
        prodname char(6) not null,
        groupname char(4) null,
        price int not null,
        amount smallint not null,
        FOREIGN KEY(userid) REFERENCES usertbl(userid)
	);
    
INSERT into usertbl values ('LSG', '이숭기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT into usertbl values ('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT into usertbl values ('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');    
INSERT into usertbl values ('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
  
INSERT into buytbl values(null, 'kbs', '운동화', null, 30, 2);
INSERT into buytbl values(null, 'kbs', '노트북', '전자', 1000, 1);
INSERT into buytbl values(null, 'jyp', '모니터', '전자', 200, 1);

USE tabledb;
DESCRIBE usertbl;

drop table if EXISTS prodtbl;
create table prodtbl 
(
	prodcode CHAR(3) not null,
    prodid char(4) not null,
    proddate datetime not null,
    prodcur char(10) null
);
alter table prodtbl
	add CONSTRAINT pk_prodtbl_procode_prodid
		PRIMARY KEY (prodcode, prodid);
drop table if EXISTS prodtbl;

create table prodtbl 
(
	prodcode CHAR(3) not null,
    prodid char(4) not null,
    proddate datetime not null,
    prodcur char(10) null,
    CONSTRAINT pk_prodtbl_procode_prodid
		PRIMARY KEY (prodcode, prodid)
);

show index from prodtbl;

alter table buytbl
	add CONSTRAINT FK_usertbl_buytbl
    FOREIGN KEY (userid)
    REFERENCES usertbl (userid)
    on update cascade;
    
use tabledb;
DROP table if EXISTS buytbl, usertbl;

CREATE table usertbl 
( 	userid char(8) not null PRIMARY KEY,
	name varchar(10) not null,
	birthyear int not null,
    email char(3) null UNIQUE
);

drop table if EXISTS usertbl;
CREATE table usertbl 
( 	userid char(8) not null PRIMARY KEY,
	name varchar(10) not null,
	birthyear int not null,
    email char(3) null,
    CONSTRAINT AK_email UNIQUE (email)
);

drop table if EXISTS usertbl;
CREATE table usertbl 
( 	userid char(8) PRIMARY KEY,
	name varchar(10),
	birthyear int CHECK (birthyear >= 1900 and birthyear <= 2023),
    mobile1 char(3) null,
    CONSTRAINT CK_name check (name is not null)
);

alter table usertbl
	add constraint CK_mobile1
    check (mobile1 in ('010', '011', '016', '017', '018', '019'));

drop table if EXISTS usertbl;
CREATE table usertbl 
( 	userid char(8) not null PRIMARY KEY,
	name varchar(10) not null,
	birthyear int not null DEFAULT -1,
    addr char(2) not null DEFAULT '서울',
    mobile1 char(3) null,
    mobile2 char(8) null,
	height smallint null DEFAULT 170,
	mdate date null    
);
    
drop table if EXISTS usertbl;
CREATE table usertbl 
( 	userid char(8) not null PRIMARY KEY,
	name varchar(10) not null,
	birthyear int not null,
    addr char(2) not null,
    mobile1 char(3) null,
    mobile2 char(8) null,
	height smallint null,
	mdate date null    
);

alter table usertbl
	alter COLUMN birthyear set DEFAULT -1;
alter table usertbl
	alter COLUMN addr set DEFAULT '서울';
alter table usertbl
	alter COLUMN height set DEFAULT 170;
    
INSERT into usertbl values ('LHL', '이혜리', default, DEFAULT, '011', '1234567', DEFAULT, '2023.12.12');
INSERT into usertbl (userid, name) values('KAY', '김아영');
INSERT into usertbl values ('WB', '원빈', 1982, '대전', '019', '9876543', 176, '2020.5.5');

SELECT * from usertbl;

create DATABASE if not EXISTS compressdb;
use compressdb;
create table normaltbl(emp_no int, first_name varchar(14));
create table compresstbl(emp_no int, first_name varchar(14))
	row_format = compressed;
    
INSERT into normaltbl
	SELECT emp_no, first_name from employees.employees;
INSERT into compresstbl
	SELECT emp_no, first_name from employees.employees;
    
show table status from compressdb;

drop DATABASE if EXISTS compressdb;

use employees;
create TEMPORARY TABLE if not EXISTS temptbl (id int, name char(5));

DROP table employess;
create TEMPORARY TABLE if not EXISTS employees (id int, name char(5));

DESCRIBE temptbl;

DESCRIBE employees;

INSERT into temptbl values (1, 'this');
INSERT into employees values (2, 'mysql');
SELECT * from temptbl;
SELECT * from employees;

DROP TEMPORARY table temptbl;

use tabledb;
alter table usertbl
	add homepage varchar(30)
		DEFAULT 'http://www.hanbit.co.kr'
        null;
        
ALTER table usertbl
	DROP COLUMN mobile1;
    
-- p345
ALTER table usertbl
	change COLUMN name uname varchar(20) null;

ALTER table usertbl
	drop PRIMARY KEY;

-- p346
use tabledb;
DROP table if EXISTS buytbl, usertbl;
create table usertbl
(	userid CHAR(8) ,
	name VARCHAR(10) ,
	birthyear INT ,
	addr CHAR(2) ,
	mobile1 CHAR(3) ,
	mobile2 CHAR(8) ,
	height SMALLINT ,
	mdate DATE 
);

    create table buytbl
    (	num int AUTO_INCREMENT PRIMARY KEY,
		userid char(8),
        prodname char(6),
        groupname char(4),
        price int,
        amount smallint
	);
    
INSERT into usertbl values ('lsg', '이숭기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT into usertbl values ('kbs', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT into usertbl values ('kkh', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');    
INSERT into usertbl values ('jyp', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
  
INSERT into buytbl values(null, 'kbs', '운동화', null, 30, 2);
INSERT into buytbl values(null, 'kbs', '노트북', '전자', 1000, 1);
INSERT into buytbl values(null, 'jyp', '모니터', '전자', 200, 1);
INSERT into buytbl values(null, 'bbk', '모니터', '전자', 200, 5);

ALTER table usertbl
	add CONSTRAINT PK_usertbl_userid
	PRIMARY KEY (userid);

DESCRIBE usertbl;

DELETE from buytbl WHERE userid = 'bbk';
ALTER table buytbl
	add CONSTRAINT FK_usertbl_buytbl
    FOREIGN KEY (userid)
    REFERENCES usertbl (userid);

INSERT into buytbl values(null, 'bbk', '모니터', '전자', 200, 5);

SET foreign_key_checks = 0;
INSERT into buytbl values(null, 'bbk', '모니터', '전자', 200, 5);
INSERT into buytbl values(null, 'kbs', '청바지', '의류', 50, 3);
INSERT into buytbl values(null, 'bbk', '메모리', '전자', 80, 10);
INSERT into buytbl values(null, 'ssk', '책',	   '서적', 15, 5);
INSERT into buytbl values(null, 'ejw', '책', 	'서적', 15, 2);
INSERT into buytbl values(null, 'ejw', '청바지', '의류', 50, 1);
INSERT into buytbl values(null, 'bbk', '운동화', null, 30, 2);
INSERT into buytbl values(null, 'ejw', '책', 	'서적', 15, 1);
INSERT into buytbl values(null, 'bbk', '운동화', null, 30, 2);
SET foreign_key_checks = 1;

UPDATE	usertbl set birthyear = 1979 where userid = 'kbs';

UPDATE	usertbl set birthyear = 1971 where userid = 'kkh';

ALTER table usertbl
	add CONSTRAINT CK_birthyear
    check ((birthyear >= 1990 and birthyear <= 2023) and (birthyear is not null));
    
INSERT into usertbl values ('tkv', '태권뷔', 2999, '우주', null, null, 186, '2023-12-12');
    
INSERT into usertbl values('ssk', '성시경', 1979, '서울', null, 		null, 186, '2013-12-12');
INSERT into usertbl values('ljb', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT into usertbl values('yjs', '윤종신', 1969, '경남', null, 		null, 170, '2005-5-5');
INSERT into usertbl values('ejw', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT into usertbl values('jkw', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT into usertbl values('bbk', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');

set foreign_key_checks = 0;
UPDATE usertbl set userid = 'vvk' where userid = 'bbk';
set foreign_key_checks = 1;   

SELECT B.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from buytbl B
		inner join usertbl U
			on B.userid = U.userid;
            
SELECT count(*) from buytbl;

SELECT B.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from buytbl B
		LEFT OUTER join usertbl U
			on B.userid = U.userid
		ORDER BY B.userid;

set foreign_key_checks = 0;
UPDATE usertbl set userid = 'bbk' where userid = 'vvk';
set foreign_key_checks = 1;   

alter table buytbl
	drop FOREIGN KEY FK_usertbl_buytbl;

alter table buytbl
	add CONSTRAINT FK_usertbl_buytbl
		FOREIGN KEY (userid)
        REFERENCES usertbl (userid)
        on update cascade;

-- p353
update usertbl set userid = 'vvk' where userid = 'bbk';
SELECT B.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from buytbl B
		inner join usertbl U
			on B.userid = U.userid
		ORDER BY B.userid;

alter table buytbl
	drop FOREIGN KEY FK_usertbl_buy;

DELETE from usertbl where userid = 'vvk';
    
alter table usertbl
	drop COLUMN birthyear;

use tabledb;
create view v_usertbl
as SELECT userid, name, addr from usertbl;

SELECT * from v_usertbl;

SELECT U.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from usertbl U
		inner join buytbl B
			on U.userid = B.userid;

create view v_userbuytbl
as
SELECT U.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from usertbl U
		inner join buytbl B
			on U.userid = B.userid;

SELECT * from v_userbuytbl where name = '김범수';

use sqldb;
create view v_userbuytbl
as
SELECT U.userid as 'user id', U.name  as 'user name', 
B.prodname  as 'product name', U.addr, concat(U.mobile1, U.mobile2) as 'mobile phone'
	from usertbl U
		inner join buytbl B
			on U.userid = B.userid;

SELECT 'user id', 'user name' from  v_userbuytbl;

DROP view  v_userbuytbl;

create or REPLACE view  v_usertbl
as
SELECT userid, name, addr from usertbl;

DESCRIBE  v_usertbl;

UPDATE v_usertbl set addr = '부산' where userid = 'jkw';

INSERT into v_usertbl(userid, name, addr) values ('kbm', '김병만', '충북');

-- ㅔ361
create view v_sum
as
SELECT userid as 'userid', sum(price*amount) as 'total'
	from buytbl GROUP BY userid;

SELECT * from v_sum;

create view v_height177
as 
SELECT * from usertbl where height >= 177;

SELECT * from v_height177;

INSERT into v_height177 values('kbw', '김병만', 1977, '경기', '010', '55555555', 158, '2023-01-01');

ALTER view v_height177
as
SELECT * from usertbl where height >= 177
	with check option;

INSERT into v_height177 values ('sjh', '서장훈', 2006, '서울', '010', '33333333', 155, '2023-3-3');

SHOW VARIABLES like 'innodb_data_file_path';

create tablespace ts_a add datafile 'ts_a.ibd';
create tablespace ts_b add datafile 'ts_b.ibd';
create tablespace ts_c add datafile 'ts_c.ibd';

CREATE table table_a (id int) tablespace ts_a;
create table table_b (id int);
alter table table_b TABLESPACE ts_b;

create table table_c (SELECT * from employees.salaries);
alter table table_c TABLESPACE ts_c;

-- p378

create table tbl1
(
	a int PRIMARY key,
    b int,
    c INT
);

create table tbl2
(
	a int PRIMARY key,
    b int UNIQUE,
    c INT UNIQUE,
    d int
);

show index from tbl2;

create table tbl3
(
	a int UNIQUE,
    b int UNIQUE,
    c INT UNIQUE,
    d int
);

show index from tbl3;

create table tbl4
(
	a int UNIQUE not null,
    b int UNIQUE,
    c INT UNIQUE,
    d int
);
show index from tbl4;

create table tbl5
(
	a int UNIQUE not null,
    b int UNIQUE,
    c INT UNIQUE,
    d int PRIMARY KEY
);
show index from tbl5;

create DATABASE if not EXISTS testdb;
use testdb;
drop table if EXISTS usertbl;

create table usertbl
(
	userid char(8) not null PRIMARY key,
	name varchar(10) not null,
	birthyear int not null,
	addr nchar(2) not null
);

INSERT into usertbl values ('lsg', '이숭기', 1987, '서울' );
INSERT into usertbl values ('kbs', '김범수', 1979, '경남');
INSERT into usertbl values ('kkh', '김경호', 1971, '전남');    
INSERT into usertbl values ('jyp', '조용필', 1950, '경기');
INSERT into usertbl values ('ssk', '성시경', 1979, '서울');
  
alter table usertbl drop PRIMARY KEY;
ALTER table usertbl
	add CONSTRAINT pk_name PRIMARY KEY(name);
SELECT * from usertbl;

-- p388

create DATABASE if not EXISTS testdb;
use testdb;
drop table clustertbl;

CREATE table clustertbl
(
	userid char(8),
    name varchar(10)
);

INSERT into clustertbl values('lsg', '이승기');
INSERT into clustertbl values('kbs', '김범수');
INSERT into clustertbl values('kkh', '김경호');
INSERT into clustertbl values('jyp', '조용필');
INSERT into clustertbl values('ssk', '성시경');
INSERT into clustertbl values('ljb', '임재범');
INSERT into clustertbl values('yjs', '윤종신');
INSERT into clustertbl values('ejw', '은지원');
INSERT into clustertbl values('jkw', '조관우');
INSERT into clustertbl values('bbk', '바비킴');


CREATE table mixedtbl
(
	userid char(8) not null,
    name varchar(10) not null,
    addr char(2)
);

INSERT into mixedtbl values('lsg', '이승기', '서울');
INSERT into mixedtbl values('kbs', '김범수', '경남');
INSERT into mixedtbl values('jyp', '조용필', '전남');
INSERT into mixedtbl values('ssk', '성시경', '경기');
INSERT into mixedtbl values('ljb', '임재범', '서울');
INSERT into mixedtbl values('yjs', '윤종신', '서울');
INSERT into mixedtbl values('ejw', '은지원', '경남');
INSERT into mixedtbl values('jkw', '조관우', '경기');
INSERT into mixedtbl values('bbk', '바비킴', '서울');

-- p405
use	sqldb;
SELECT * from usertbl;
show INDEX from usertbl;
show table status like 'usertbl';

create index idx_usertbl_addr
	on usertbl (addr);

show INDEX from usertbl;

-- p406
ANALYZE table usertbl;
show table status like 'usertbl';

create UNIQUE INDEX idx_usertbl_birthyear
	on usertbl (birthyear);
    
create UNIQUE INDEX idx_usertbl_name
	on usertbl (name);
 
show INDEX from usertbl;

-- p407
create INDEX idx_usertbl_name_birthyear
	on usertbl (name, birthyear);

drop INDEX idx_usertbl_name on usertbl;

show INDEX from usertbl;

SELECT * from usertbl where name = '윤종신' and birthyear = '1969';
SELECT * FROM usertbl WHERE name = '윤종신';

-- p408

create INDEX idx_usertbl_mobile1
	on usertbl (mobile1);
    
SELECT * from usertbl WHERE mobile1 = '011';

show INDEX from usertbl;

drop index idx_usertbl_addr on usertbl;
drop index idx_usertbl_name_birthyear on usertbl;
drop index idx_usertbl_mobile1 on usertbl;

-- p409
create database if not exists indexdb;

use indexdb;
SELECT count(*) from employees.employees;

create table emp select * from employees.employees order by rand();
create table emp_c select * from employees.employees order by rand();
create table emp_Se select * from employees.employees order by rand();

SELECT * from emp limit 5;
SELECT * from emp_c limit 5;
SELECT * from emp_Se limit 5;

alter table emp_c add primary key(emp_no);
alter table emp_Se add index idx_emp_no (emp_no);

SELECT * from emp limit 5;
SELECT * from emp_c limit 5;
SELECT * from emp_Se limit 5;

ANALYZE table emp, emp_c, emp_Se;

show index from emp;
show index from emp_c;
show index from emp_Se;
show table status;

-- p414

use indexdb;

show global status like 'Innodb_pages_read';
SELECT * from emp WHERE emp_no = 100000;
show GLOBAL status like 'Innodb_pages_read';

show global status like 'Innodb_pages_read';
SELECT * from emp_c WHERE emp_no = 100000;
show GLOBAL status like 'Innodb_pages_read';

-- p417
show global status like 'Innodb_pages_read';
SELECT * from emp WHERE emp_no < 110000;
show GLOBAL status like 'Innodb_pages_read';

show global status like 'Innodb_pages_read';
SELECT * from emp_c WHERE emp_no < 11000;
show GLOBAL status like 'Innodb_pages_read';

-- p420
show global status like 'Innodb_pages_read';
SELECT * from emp_c WHERE emp_no < 500000 limit 1000000;
show GLOBAL status like 'Innodb_pages_read';

SELECT * from emp;

show global status like 'Innodb_pages_read';
SELECT * from emp_c IGNORE INDEX(PRIMARY) WHERE emp_no < 500000 limit 1000000;
show GLOBAL status like 'Innodb_pages_read';

SELECT * from emp_c;

show global status like 'Innodb_pages_read';
SELECT * from emp_Se WHERE emp_no < 11000;
show GLOBAL status like 'Innodb_pages_read';

show global status like 'Innodb_pages_read';
SELECT * from emp_Se IGNORE INDEX(idx_emp_no) WHERE emp_no < 11000;
show GLOBAL status like 'Innodb_pages_read';

show global status like 'Innodb_pages_read';
SELECT * from emp_Se WHERE emp_no < 400000 limit 500000;
show GLOBAL status like 'Innodb_pages_read';

SELECT * from emp_Se where emp_no < 60000 limit 500000;

SELECT * from emp_c where emp_no = 100000;

show global status like 'Innodb_pages_read';
SELECT * from emp_c where emp_no = 100000;
show global status like 'Innodb_pages_read';

-- p430
SELECT * from emp_c where emp_no = 100000 / 1;
SELECT * from emp;

alter table emp add INDEX idx_gender (gender);
ANALYZE table emp;
show index from emp;

SELECT * from emp where gender = 'M' limit 500000;

SELECT * from emp IGNORE INDEX (idx_gender) where gender = 'M' limit 500000;

-- p 436
use sqldb;
SELECT name, birthyear, addr from usertbl where userid = 'KKH';



