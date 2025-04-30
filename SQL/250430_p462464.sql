-- p463

use sqldb;

create TABLE if not exists testtbl(id int, txt varchar(10));


SELECT * from testtbl;

INSERT into testtbl values(1, '레드벨벳');
INSERT into testtbl values(2, '잇지');
INSERT into testtbl values(3, '블랙핑크');

-- p464 트리거 부착



drop TRIGGER if EXISTS testtrg;

DELIMITER $$
CREATE trigger testtrg
	after delete
    on testtbl
    for each row
begin
	set @msg = '가수 그룹이 삭제됌';
end $$

set @msg = '';
insert into testtbl values(4, '마마무');
select @msg;
update testtbl set txt = '블핑' where id = 3;
select @msg;
delete from testtbl where id = 4;
select @msg;



