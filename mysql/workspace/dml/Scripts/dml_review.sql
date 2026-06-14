create database dml_review01;
use dml_review01;

drop table tbl_car;
create table tbl_car(
   id bigint unsigned auto_increment primary key,
   car_brand varchar(255) not null,
   car_model varchar(255) not null,
   car_price bigint unsigned default 0,
   car_release_date date
);
select * from tbl_car;
insert into tbl_car
(car_brand, car_model, car_price, car_release_date)
values
('Hyundai', 'Avante', 2500, '2021-03-15'),
('Hyundai', 'Sonata', 3200, '2020-07-10'),
('Kia', 'K5', 3300, '2022-05-20'),
('Kia', 'Sportage', 3800, '2021-11-30'),
('Genesis', 'G80', 6500, '2023-02-01'),
('Genesis', 'GV70', 7200, '2022-09-18'),
('BMW', '320i', 5800, '2020-04-05'),
('BMW', 'X5', 9800, '2021-08-22'),
('Benz', 'C-Class', 6100, '2019-06-14'),
('Audi', 'A6', 6300, '2020-10-09');

create table tbl_owner(
   id bigint unsigned auto_increment primary key,
   owner_name varchar(255) not null,
   owner_phone varchar(255) not null,
   owner_address varchar(255) not null,
   owner_address_detail varchar(255) not null
);
select * from tbl_owner;
insert into tbl_owner
(owner_name, owner_phone, owner_address, owner_address_detail)
values
('김민수', '01012345678', '서울특별시 강남구', '역삼동 101-1'),
('이정훈', '01023456789', '서울특별시 서초구', '서초동 202-3'),
('박지훈', '01034567890', '경기도 성남시 분당구', '정자동 15-7'),
('최수연', '01045678901', '경기도 수원시 영통구', '망포동 88-2'),
('정우성', '01056789012', '부산광역시 해운대구', '우동 312-9'),
('한지민', '01067890123', '대구광역시 수성구', '범어동 44-6'),
('오세훈', '01078901234', '인천광역시 연수구', '송도동 77-5'),
('강다은', '01089012345', '광주광역시 북구', '용봉동 19-8'),
('신동엽', '01090123456', '대전광역시 유성구', '봉명동 250-4'),
('윤아름', '01001234567', '울산광역시 남구', '삼산동 66-1');

create table tbl_registration(
   id bigint unsigned auto_increment primary key,
   car_id bigint unsigned not null,
   owner_id bigint unsigned not null,
   constraint fk_registration_car foreign key(car_id)
   references tbl_car(id),
   constraint fk_registration_owner foreign key(owner_id)
   references tbl_owner(id)
);
select * from tbl_registration;
update tbl_registration 
set car_id = 2
where id = 3;
insert into tbl_registration
(car_id, owner_id)
values
(1, 1),(2, 1),(3, 2),(4, 3),(5, 4),(6, 5),(7, 6),(8, 7),(9, 8),(10, 9);
/* from -> join -> on -> where -> select */
/*전체 차량 정보 조회
모든 차량의 브랜드, 모델, 가격, 출시일 조회*/
select * from tbl_car;
/*차량 가격이 5천만 원 이상인 차량 조회
브랜드, 모델, 가격만 출력*/
select car_brand, car_model, car_price
from tbl_car
where car_price >= 5000;
/*차주 이름이 '김민수' 인 사람이 소유한 차량 브랜드, 모델 조회*/
select c.car_brand , c.car_model , o.owner_name 
from tbl_car c join tbl_registration r
on c.id = r.car_id 
join tbl_owner o
on o.id = r.owner_id
where o.owner_name ='김민수';
/*차량 + 차주 정보 함께 조회
차량 브랜드, 모델, 차주 이름, 전화번호, JOIN 사용*/
select c.car_brand, c.car_model ,o.owner_name ,o.owner_phone 
from tbl_car c join tbl_registration r 
on c.id = r.car_id join tbl_owner o 
on o.id = r.owner_id ;
/*한 사람이 여러 대의 차량을 가진 경우 조회, 차주 이름, 소유 차량 수, GROUP BY 사용*/
select o.owner_name '소유자', concat(count(*) ,'대') '차량수'
from tbl_owner o join tbl_registration r 
on o.id = r.owner_id 
group by owner_name having count(*) >=2;
/*차량을 가장 많이 소유한 차주 조회.차주 이름, 차량 수
order by + limit*/
select o.owner_name,count(*)  
from tbl_owner o join tbl_registration r 
on o.id = r.owner_id
group by o.owner_name
order by count(*) desc
limit 1;
/*아직 차량이 없는 차주 조회
차주 이름만 출력
LEFT JOIN*/
select o.owner_name 
from tbl_owner o left outer join tbl_registration r 
on o.id = r.owner_id 
where r.owner_id is null;
/*2021년 이후 출시된 차량의 소유자 조회
차량 브랜드, 모델, 차주 이름*/
select c.car_brand, c.car_model ,o.owner_name 
from tbl_car c join tbl_registration r
on c.id = r.car_id join tbl_owner o 
on o.id = r.owner_id
where c.car_release_date >= '2021-01-01';
/*차량 가격 평균 조회, 소수점 없이 출력*/
select round(avg(car_price),0) '차량가격 평균' from tbl_car;
/*차량 가격이 가장 비싼 차량의 차주 조회. 차량 브랜드, 모델, 가격, 차주 이름
sub query 또는 order by limit*/
select c.car_brand, c.car_model, c.car_price, o.owner_name
from tbl_car c join tbl_registration r
on c.id = r.car_id
join tbl_owner o
on o.id = r.owner_id
where c.car_price = (
  	select max(car_price)
  	from tbl_car
);