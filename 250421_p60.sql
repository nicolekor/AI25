use shopdb;


CREATE TABLE `shopdb`.`memberTBL` (
  `memberID` CHAR(8) NOT NULL,
  `memberName` CHAR(5) NOT NULL,
  `memberAddress` CHAR(20) NULL,
  PRIMARY KEY (`memberID`));


CREATE TABLE `shopdb`.`productTBL` (
  `productID` CHAR(4) NOT NULL,
  `cost` int NOT NULL,
  `makeDate` date NULL, 
  `company` CHAR(5) NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`productID`));
  
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Dang', '당탕이', '경기 부천시 중동');
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Jee', '지운이', '서울 은평구 증산동');
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Han', '한주연', '인천 남구 주안동');
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Sang', '상길이', '경기 성남시 분당구');
INSERT INTO `shopdb`.`membertbl` (`memberID`, `memberName`, `memberAddress`) VALUES ('Naota', '나오타', '주소불명');

select * from memberTBL;
select * from productTBL;

-- membertbl 테이블에서 나오타 행 지우기
delete from membertbl where memberID = 'Naota';