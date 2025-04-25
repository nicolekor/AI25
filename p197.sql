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


-- p243

use sqldb;

set @myvar1 = 5;
set @myvar2 = 3;
set @myvar3 = 4.25;
set @myvar4 = '가수 이름 ==> ';

SELECT@myvar1 ;

SELECT@myvar2 + @myvar3 ;

SELECT@myvar4, name from usertbl where height > 180;

set @myvar1 = 3;
PREPARE myquery
from 'select name, height from usertbl order by height limit ?';
EXECUTE myquery using @myvar1;

-- p245
use sqldb;
select avg(amount) as '평균 구매 개수' from buytbl;

-- p247
SELECT'100' + '200' ;
SELECT concat('100', '200');
SELECT concat(100, 200);
SELECT 1 > '2mega';
SELECT 3 > '2MEGA';
SELECT 0 = 'mega2';

-- p248 ~ 308(267, 268제외, 273 해도 되고 안해도 됌)

SELECT if (100>200, '참', '거짓');
SELECT ifnull(null, '널'), ifnull(100, '널');

SELECT nullif(100, 100), nullif(200, 100);

SELECT case 10
		when 1 then '1'
		when 5 then '5'
		when 10 then '10'
		else '모름'
	end as 'case연습';

SELECT ascii('A'), char(65);

SELECT bit_length('abc'), char_length('abc'), length('abc');
SELECT bit_length('가나다'), char_length('가나다'), length('가나다');

SELECT concat_ws('/', '2025', '01', '01');

select elt(2, '하나', '둘', '셋'), field('둘', '하나', '둘', '셋'), 
	find_in_set('둘', '하나,둘,셋'), instr('하나둘셋', '둘'), locate('둘', '하나둘셋');
    
SELECT format(123456.123456, 4);

SELECT bin(31), hex(31), oct(31);

-- p251
SELECT insert('abcdefghi', 3, 4, '@@@@'), insert('abcdefghi', 3, 2, '@@@@');

SELECT left('abcdefghi', 3), right('abcdefghi', 3);

SELECT lower('abcdEFGHI'), upper('abcdEFGHI');

SELECT lpad('이것이', 5, '##'), rpad('이것이', 5, '##');
SELECT ltrim('    이것이'), rtrim('이것이    ');
-- 공백 제거
select trim('     이것이          '), trim(both 'ㅋ' from 'ㅋㅋㅋ재밌어요. ㅋㅋㅋ');


SELECT concat('이것이', space(10), 'mysql이다');

SELECT substring('대한민국만세', 3,2);
SELECT substring_index('cafe.naver.com', '.', 2), substring_index('cafe.naver.com', '.', -2);

SELECT abs(-100); -- 절대값

SELECT ceiling(4.7),floor(4.7), round(4.7);

SELECT conv('AA', 16, 2), conv(100, 10, 8);

SELECT degrees(pi()), radians(180);

SELECT mod(157, 10), 157 % 10, 157 mod 10;

SELECT pow(2,3), sqrt(9);

SELECT rand(), floor(1+(rand() * (7-1)));

SELECT sign(100), sign(0), sign(-100.123);

SELECT truncate(12345.12345, 2), truncate(12345.12345, -2);

-- p256
SELECT adddate('2025-01-01', interval 31 day), adddate('2025-01-01', interval 1 month);
SELECT subdate('2025-01-01', interval 31 day), subdate('2025-01-01', interval 1 month);

SELECT addtime('2025-01-01 23:59:59', '1:1:1'), addtime('15:00:00','2:10:10');
SELECT subtime('2025-01-01 23:59:59', '1:1:1'), subtime('15:00:00','2:10:10');

SELECT year(curdate()), month(curdate()), dayofmonth(curdate()); 

SELECT hour(curtime()), minute(curtime()), second(curtime()), microsecond(curtime());

SELECT date(now()), time(now());

SELECT datediff('2025-01-01', now()), timediff('23:59:59', '12:11:10');

SELECT dayofweek(curdate()), monthname(curdate()), dayofyear(curdate());
select last_day('2025-02-01');

SELECT makedate(2025, 32);
SELECT maketime(12, 11, 10);

SELECT period_add(202501, 11), period_diff(202501, 202312);
SELECT quarter('2025-07-07');
SELECT time_to_sec('12:11:10');

SELECT current_user(), database();

use sqldb;
SELECT * from usertbl;
SELECT found_rows();

update buytbl set price = price*2;
SELECT row_count();

SELECT sleep(5);
select '5초 후에 이게 보여요';

-- p273 조인

SELECT * from buytbl
	inner join usertbl 
		on buytbl.userid = usertbl.userid
	where buytbl.userid = 'JYP';

SELECT * from buytbl
	inner join usertbl 
		on buytbl.userid = usertbl.userid
	ORDER BY num;

SELECT userid, name, prodname, addr, concat(mobile1, mobile2) as '연락처'
	from buytbl
		inner join usertbl
			on buytbl.userid = usertbl.userid
		ORDER BY num; -- 에러가 나오는게 맞음
        
SELECT buytbl.userid, name, prodname, addr, concat(mobile1, mobile2) as '연락처'
	from buytbl
		inner join usertbl
			on buytbl.userid = usertbl.userid
		ORDER BY num; 

SELECT buytbl.userid, usertbl.name, buytbl.prodname, usertbl.addr, concat(usertbl.mobile1, usertbl.mobile2) as '연락처'
	from buytbl
		inner join usertbl
			on buytbl.userid = usertbl.userid
		ORDER BY buytbl.num; 
        
SELECT B.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from buytbl B
		inner join usertbl U
			on B.userid = U.userid
		ORDER BY B.num; 

SELECT B.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from buytbl B
		inner join usertbl U
			on B.userid = U.userid
		where B.userid = 'JYP'; 

SELECT U.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from usertbl U
		inner join buytbl B
			on U.userid = B.userid
		where B.userid = 'JYP'; 

SELECT U.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from usertbl U
		inner join buytbl B
			on U.userid = B.userid
		ORDER BY U.userid;

SELECT distinct U.userid, U.name, U.addr
	from usertbl U
		inner JOIN buytbl B
			on U.userid = B.userid
		ORDER By U.userid;
        
SELECT U.userid, U.name, U.addr
	from usertbl U
    where EXISTS (
		SELECT * from buytbl B
			where U.userid = B.userid);
            
-- p281
use sqldb;
create table stdtbl
(stdname varchar(10) not null primary key,
addr char(4) not null);

create table clubtbl
(clubname varchar(10) not null primary key,
roomno char(4) not null);

create table stdclubtbl
(num int AUTO_INCREMENT not null PRIMARY key,
stdname varchar(10) not null,
clubname varchar(10) not null,
FOREIGN KEY(stdname) REFERENCES stdtbl(stdname),
FOREIGN KEY(clubname) REFERENCES clubtbl(clubname));

INSERt INTO stdtbl values ('김범수', '경남'), ('성시경', '서울'), ('조용필', '경기'), ('은지원', '경북'), ('바비킴', '서울');
INSERt INTO clubtbl values ('수영', '101호'), ('바둑', '102호'), ('축구', '103호'), ('봉사', '104호');
INSERt INTO stdclubtbl values (null, '김범수', '바둑'), (null, '김범수', '축구'), (null, '조용필', '축구'), (null, '은지원', '축구'), (null, '은지원', '봉사'), (null,'바비킴', '봉사');

SELECT S.stdname, S.addr, C.clubname, C.roomno
	from stdtbl S
		inner join stdclubtbl SC
			on S.stdname = SC.stdname
		inner JOIN clubtbl C
			on SC.clubname = C.clubname
		ORDER BY S.stdname;

-- p283
SELECT C.clubname, C.roomno, S.stdname, S.addr
	from stdtbl S
		inner join stdclubtbl SC
			on SC.stdname = S.stdname
		inner JOIN clubtbl C
			on SC.clubname = C.clubname
		ORDER BY C.clubname;
        
-- p285
SELECT U.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from usertbl U
		left outer join buytbl B
			on U.userid = B.userid
		ORDER BY U.userid;
        
SELECT U.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from buytbl B
		right outer join usertbl U
			on U.userid = B.userid
		ORDER BY U.userid;	
	
SELECT U.userid, U.name, B.prodname, U.addr, concat(U.mobile1, U.mobile2) as '연락처'
	from usertbl U
		left outer join buytbl B
			on U.userid = B.userid
		where B.prodname is null
		ORDER BY U.userid;
        
SELECT S.stdname, S.addr, C.clubname, C.roomno 
	from stdtbl S
		left outer join stdclubtbl SC
			on S.stdname = SC.stdname
		left outer join clubtbl C
			on SC.clubname = C.clubname
		ORDER BY S.stdname;	
        
SELECT  C.clubname, C.roomno, S.stdname, S.addr 
	from stdtbl S
		left outer join stdclubtbl SC
			on SC.stdname = S.stdname
		right outer join clubtbl C
			on SC.clubname = C.clubname
		ORDER BY C.clubname;	
       
       -- p288
SELECT S.stdname, S.addr, C.clubname, C.roomno 
	from stdtbl S
		left outer join stdclubtbl SC
			on S.stdname = SC.stdname
		left outer join clubtbl C
			on SC.clubname = C.clubname
UNION
SELECT S.stdname, S.addr, C.clubname, C.roomno 
	from stdtbl S
		left outer join stdclubtbl SC
			on SC.stdname = S.stdname
		right outer join clubtbl C
			on SC.clubname = C.clubname;
            
SELECT * from buytbl, usertbl;

use employees;
SELECT count(*) as '데이터개수'
	from employees
		cross join titles;
        
use sqldb;
create table emptbl (emp char(3), manager char(3), emptel varchar(8));
insert into emptbl values('나사장', null, '0000');
insert into emptbl values('김재무', '나사장', '2222');
insert into emptbl values('김부장', '김재무', '2222-1');
insert into emptbl values('이부장', '김재무', '2222-2');
insert into emptbl values('우대리', '이부장', '2222-2-1');
insert into emptbl values('지사원', '이부장', '2222-2-2');
insert into emptbl values('이영업', '나사장', '1111');
insert into emptbl values('한과장', '이영업', '1111-1');
insert into emptbl values('최정보', '나사장', '3333');
insert into emptbl values('윤차장', '최정보', '3333-1');
insert into emptbl values('이주임', '윤차장', '3333-1-1');

SELECT A.emp as '부하직원', B.emp as '직속상관', B.emptel as '직속상관연락처'
	from emptbl A
		INNER join emptbl B
			on A.manager = B.emp
		where A.emp = '우대리';
        
use sqldb;
SELECT stdname, addr from stdtbl
	union all
SELECT clubname, roomno from clubtbl;

SELECT name, concat(mobile1, mobile2) as '전화번호' from usertbl
	where name not in (SELECT name from usertbl where mobile1 is null);
    
SELECT name, concat(mobile1, mobile2) as '전화번호' from usertbl
	where name in (SELECT name from usertbl where mobile1 is null);
    
delimiter $$
create procedure 스토어드프로시저이름()
begin
	이부분에 sql 프로그래밍 코딩
end $$
delimiter ;
call 스토어드프로시저이름();
    
-- p296
drop procedure if exists ifproc;
delimiter $$
create procedure ifproc()
begin
	DECLARE var1 int;
    set var1 = 100;
    
    if var1 = 100 then
		select '100 입니다';
	ELSE
		SELECT '100이 아니요';
	END IF;
end $$
delimiter ;
call ifproc();


-- p297

SELECT * FROM employees WHERE emp_no = 10001;

SHOW CREATE PROCEDURE ifproc2;


-- STEP 1: employees 데이터베이스를 명확히 선택
USE employees;

-- STEP 2: 혹시 모를 이전 프로시저 제거 (다시 한 번 안전하게)
DROP PROCEDURE IF EXISTS ifproc2;

-- STEP 3: 프로시저 생성
DELIMITER $$

CREATE PROCEDURE ifproc2()
BEGIN
    DECLARE hiredate DATE;
    DECLARE curdate DATE;
    DECLARE days INT;

    SELECT hire_date INTO hiredate 
    FROM employees
    WHERE emp_no = 10001;

    SET curdate = CURRENT_DATE();
    SET days = DATEDIFF(curdate, hiredate);

    IF days / 365 >= 5 THEN 
        SELECT CONCAT('입사한지 ', days, '일이 지남 축하함') AS message;
    ELSE
        SELECT CONCAT('입사한지 ', days, '일밖에 안됐다, 수고') AS message;
    END IF;
END $$

DELIMITER ;

-- STEP 4: 프로시저 호출
CALL ifproc2();

-- p298
DROP PROCEDURE IF EXISTS ifproc3;

DELIMITER $$

CREATE PROCEDURE ifproc3()
BEGIN
    DECLARE point INT;
    DECLARE credit char(1);
    set point = 77;

    IF point >= 90 THEN 
        set credit = 'A';
	elseif point >= 80 THEN 
		set credit = 'B';
	elseif point >= 70 THEN 
		set credit = 'C';
	elseif point >= 60 THEN 
		set credit = 'D';
    ELSE
        set credit = 'F';
    END IF;
    SELECT concat('취득점수==>', point), concat('학점==>', credit);
END $$

DELIMITER ;

CALL ifproc3();

-- p299

drop PROCEDURE if EXISTS caseproc;
delimiter $$
create PROCEDURE caseproc()
BEGIN
	DECLARE point INT;
    DECLARE credit char(1);
    set point = 77;
    
    case
		when point >= 90 THEN 
			set credit = 'A';
		when point >= 80 THEN 
			set credit = 'B';
		when point >= 70 THEN 
			set credit = 'C';
		when point >= 60 THEN 
			set credit = 'D';
		ELSE
			set credit = 'F';
    END case;
	SELECT concat('취득점수==>', point), concat('학점==>', credit);
END $$

DELIMITER ;

CALL caseproc();

-- p300

use sqldb;
SELECT userid, sum(price*amount) as '총구매액'
	from buytbl
    group by userid
    order by sum(price*amount) desc;
    
SELECT B.userid, U.name, sum(price*amount) as '총구매액'
	from buytbl B
		INNER  join usertbl U
			on B.userid = U.userid
		GROUP BY B.userid, U.name
        ORDER BY sum(price*amount) desc;

SELECT B.userid, U.name, sum(price*amount) as '총구매액'
	from buytbl B
		right outer join usertbl U
			on B.userid = U.userid
		GROUP BY B.userid, U.name
        ORDER BY sum(price*amount) desc;
        
SELECT U.userid, U.name, sum(price*amount) as '총구매액'
	from buytbl B
		right outer join usertbl U
			on B.userid = U.userid
		GROUP BY U.userid, U.name
        ORDER BY sum(price*amount) desc;

-- p302
SELECT U.userid, U.name, sum(price*amount) as '총구매액',
	case
		when (sum(price*amount) >= 1500) then '최우수고객'
		when (sum(price*amount) >= 1000) then '우수고객'
		when (sum(price*amount) >= 1) then '일반고객'
		else '유령고객'
	end as '고객등급'

from buytbl B
	right outer join usertbl U
		on B.userid = u.userid
	group by U.userid, U.name
    order by sum(price*amount) desc;