use employees;
select * from employees;


show databases;
-- 사용자가 뭐가 있는지 확인하기

use mysql;
select user, host from user;

create user webuser@'%' identified by '54321'; -- 사용자 생성  
grant all privileges on employees.* to 'webuser'@'%';  -- 권한 부여

flush privileges; -- 새로고침

grant all privileges on shopdb.* to 'webuser'@'%';  -- 권한 부여
flush privileges; -- 새로고침

