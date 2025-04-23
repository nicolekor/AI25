use shopdb;

SELECT * FROM shopdb.producttbl;

INSERT INTO `shopdb`.`producttbl` (`productID`, `cost`, `makeDate`, `company`, `amount`) VALUES ('컴퓨터', '10', '2021-01-01', '삼성', '17');
INSERT INTO `shopdb`.`producttbl` (`productID`, `cost`, `makeDate`, `company`, `amount`) VALUES ('세탁기', '20', '2022-09-01', 'LG', '3');
INSERT INTO `shopdb`.`producttbl` (`productID`, `cost`, `makeDate`, `company`, `amount`) VALUES ('냉장고', '5', '2023-02-01', '대우', '22');


select * from producttbl;